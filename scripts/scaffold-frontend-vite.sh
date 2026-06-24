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
printf 'save-exact=true\n' > .npmrc
python3 - <<'PY'
from pathlib import Path
import json

package_path = Path('package.json')
data = json.loads(package_path.read_text())
for group in ('dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies'):
    deps = data.get(group)
    if not isinstance(deps, dict):
        continue
    for name, version in list(deps.items()):
        if isinstance(version, str) and version[:1] in {'^', '~'}:
            deps[name] = version[1:]
package_path.write_text(json.dumps(data, indent=2) + '\n')
PY
pnpm install

# Add baseline validation and styling tooling. Keep this source-owned; do not run shadcn init by default.
pnpm add -D -E vitest jsdom @testing-library/react @testing-library/jest-dom
pnpm add -D -E tailwindcss @tailwindcss/vite
pnpm add -E clsx tailwind-merge

python3 - <<'PY'
from pathlib import Path
import json

package_path = Path('package.json')
data = json.loads(package_path.read_text())
scripts = data.setdefault('scripts', {})
scripts.setdefault('typecheck', 'tsc --noEmit')
scripts.setdefault('test', 'vitest')

for group in ('dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies'):
    deps = data.get(group)
    if not isinstance(deps, dict):
        continue
    for name, version in list(deps.items()):
        if isinstance(version, str) and version[:1] in {'^', '~'}:
            deps[name] = version[1:]

package_path.write_text(json.dumps(data, indent=2) + '\n')

vite_config = Path('vite.config.ts')
if vite_config.exists():
    text = vite_config.read_text()
    if "@tailwindcss/vite" not in text:
        text = text.replace("import react from '@vitejs/plugin-react'", "import react from '@vitejs/plugin-react'\nimport tailwindcss from '@tailwindcss/vite'\nimport { fileURLToPath, URL } from 'node:url'")
        text = text.replace('plugins: [react()]', "plugins: [react(), tailwindcss()],\n  resolve: {\n    alias: {\n      '@': fileURLToPath(new URL('./src', import.meta.url)),\n    },\n  }")
        vite_config.write_text(text)

tsconfig_app = Path('tsconfig.app.json')
if tsconfig_app.exists():
    text = tsconfig_app.read_text()
    if '"paths"' not in text:
        text = text.replace('"jsx": "react-jsx",', '"jsx": "react-jsx",\n    "paths": {\n      "@/*": ["./src/*"]\n    },')
        tsconfig_app.write_text(text)

index_css = Path('src/index.css')
if index_css.exists():
    index_css.write_text("""@import 'tailwindcss';

@theme {
  --color-background: #080806;
  --color-foreground: #f6f0e6;
  --color-card: #15130f;
  --color-card-foreground: #f6f0e6;
  --color-primary: #c3a56d;
  --color-primary-foreground: #080806;
  --color-secondary: #1d1a14;
  --color-secondary-foreground: #f6f0e6;
  --color-muted: #242018;
  --color-muted-foreground: #a69d8f;
  --color-accent: #242018;
  --color-accent-foreground: #f6f0e6;
  --color-destructive: #d96c5f;
  --color-destructive-foreground: #fff8f0;
  --color-border: rgba(246, 240, 230, 0.14);
  --color-input: rgba(246, 240, 230, 0.16);
  --color-ring: #c3a56d;
}

:root {
  color: var(--color-foreground);
  background: var(--color-background);
  font-family: Geist, ui-sans-serif, system-ui, sans-serif;
  font-synthesis: none;
  text-rendering: geometricPrecision;
}

body {
  min-width: 320px;
  min-height: 100dvh;
  margin: 0;
}

button,
input,
textarea,
select {
  font: inherit;
}
""")

utils = Path('src/lib/utils.ts')
utils.parent.mkdir(parents=True, exist_ok=True)
if not utils.exists():
    utils.write_text("""import { type ClassValue, clsx } from 'clsx'
import { twMerge } from 'tailwind-merge'

export const cn = (...inputs: ClassValue[]) => {
  return twMerge(clsx(inputs))
}
""")

readme = Path('README.md')
variant_readme = Path('../variants/frontend-vite/templates/app-readme.md')
if variant_readme.exists():
    readme.write_text(variant_readme.read_text())

smoke_test = Path('src/smoke.test.ts')
if not smoke_test.exists():
    smoke_test.write_text("""import { describe, expect, it } from 'vitest'\n\ndescribe('smoke', () => {\n  it('runs the test baseline', () => {\n    expect(true).toBe(true)\n  })\n})\n""")
PY

echo "✓ Created React/Vite app in $APP_DIR"
echo "✓ Added cn() utility with clsx + tailwind-merge"
echo "Next: cd $APP_DIR && pnpm dev"
echo "Optional base components: ./scripts/copy-frontend-base-components.sh $APP_DIR --install-deps"
