#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm is required for the frontend-vite smoke test" >&2
  exit 1
fi

TMP="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP"
}
trap cleanup EXIT

echo "✓ frontend-vite smoke root: $ROOT"
echo "✓ temp workspace: $TMP"

rsync -a \
  --exclude .git \
  --exclude .letta \
  --exclude node_modules \
  --exclude dist \
  --exclude build \
  "$ROOT/" "$TMP/reikujo/"

cd "$TMP/reikujo"

./scripts/init-project.sh "Frontend Vite Smoke" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps

cd app

python3 - <<'PY'
import json
from pathlib import Path

package_json = Path('package.json')
package = json.loads(package_json.read_text())

for group in ('dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies'):
    for name, version in (package.get(group) or {}).items():
        if isinstance(version, str) and version.startswith(('^', '~')):
            raise SystemExit(f'{group}.{name} is not exact: {version}')

required_dependencies = [
    'tailwind-variants',
    'clsx',
    'tailwind-merge',
    '@radix-ui/react-slot',
    'framer-motion',
    'lucide-react',
]
for dependency in required_dependencies:
    if dependency not in package.get('dependencies', {}):
        raise SystemExit(f'missing dependency: {dependency}')

required_dev_dependencies = [
    'tailwindcss',
    '@tailwindcss/vite',
    'vitest',
]
for dependency in required_dev_dependencies:
    if dependency not in package.get('devDependencies', {}):
        raise SystemExit(f'missing dev dependency: {dependency}')

if 'save-exact=true' not in Path('.npmrc').read_text():
    raise SystemExit('.npmrc missing save-exact=true')

required_paths = [
    'src/lib/utils.ts',
    'src/components/ui/button.tsx',
    'src/components/ui/card.tsx',
    'src/components/ui/input.tsx',
    'src/components/ui/label.tsx',
    'src/components/ui/tubelight-navbar.tsx',
    'src/components/tubelight-navbar-demo.tsx',
    'src/components/modules/example/example-section.tsx',
    'src/components/modules/example/index.ts',
    'src/hooks/use-example-toggle.ts',
]
for path in required_paths:
    if not Path(path).exists():
        raise SystemExit(f'missing generated path: {path}')

button_source = Path('src/components/ui/button.tsx').read_text()
if 'tailwind-variants' not in button_source or 'class-variance-authority' in button_source:
    raise SystemExit('button template must use tailwind-variants and not cva')
PY

pnpm typecheck
pnpm test -- --run
pnpm build

echo "✓ frontend-vite smoke test passed"
