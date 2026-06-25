#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT/examples/frontend-vite/basic-app"

if [[ ! -d "$APP_DIR" ]]; then
  echo "Example app not found: $APP_DIR" >&2
  exit 1
fi

if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm is required for the frontend-vite example test" >&2
  exit 1
fi

cd "$APP_DIR"

python3 - <<'PY'
import json
from pathlib import Path

package = json.loads(Path('package.json').read_text())
for group in ('dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies'):
    for name, version in (package.get(group) or {}).items():
        if isinstance(version, str) and version.startswith(('^', '~')):
            raise SystemExit(f'{group}.{name} is not exact: {version}')

required = [
    'src/App.tsx',
    'src/components/ui/button.tsx',
    'src/components/ui/badge.tsx',
    'src/components/ui/textarea.tsx',
    'src/components/ui/separator.tsx',
    'src/components/ui/skeleton.tsx',
    'src/components/modules/example/example-list-state.tsx',
    'src/services/example.ts',
    'src/types/example.ts',
]
for path in required:
    if not Path(path).exists():
        raise SystemExit(f'missing example path: {path}')
PY

pnpm install
pnpm typecheck
pnpm test -- --run
pnpm build

echo "✓ frontend-vite basic example passed"
