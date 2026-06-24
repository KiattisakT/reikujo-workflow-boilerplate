#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

APP_DIR="${1:-app}"

if [[ "$APP_DIR" == "." || "$APP_DIR" == "/" ]]; then
  echo "Refusing to scaffold into: $APP_DIR" >&2
  exit 1
fi

if [[ -e "$APP_DIR" ]]; then
  echo "App directory already exists: $APP_DIR" >&2
  exit 1
fi

if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm is required for the frontend-vite variant" >&2
  exit 1
fi

pnpm create vite@latest "$APP_DIR" --template react-ts

cd "$APP_DIR"
pnpm install

# Add baseline validation tooling. Keep this light; projects can add Playwright/shadcn/Tailwind later.
pnpm add -D vitest jsdom @testing-library/react @testing-library/jest-dom

python3 - <<'PY'
from pathlib import Path
import json

package_path = Path('package.json')
data = json.loads(package_path.read_text())
scripts = data.setdefault('scripts', {})
scripts.setdefault('typecheck', 'tsc --noEmit')
scripts.setdefault('test', 'vitest')
package_path.write_text(json.dumps(data, indent=2) + '\n')

readme = Path('README.md')
variant_readme = Path('../variants/frontend-vite/templates/app-readme.md')
if variant_readme.exists():
    readme.write_text(variant_readme.read_text())
PY

echo "✓ Created React/Vite app in $APP_DIR"
echo "Next: cd $APP_DIR && pnpm dev"
echo "Optional base components: ./scripts/copy-frontend-base-components.sh $APP_DIR --install-deps"
