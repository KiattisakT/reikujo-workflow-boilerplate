#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

APP_DIR="${1:-app}"
INSTALL_DEPS="false"

shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-deps)
      INSTALL_DEPS="true"
      shift
      ;;
    -h|--help)
      cat <<'HELP'
Usage: ./scripts/copy-frontend-base-components.sh [app-dir] [--install-deps]

Copies source-owned shadcn-style base component templates into app/src.
This does not install shadcn/ui.
HELP
      exit 0
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      exit 1
      ;;
  esac
done

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR" >&2
  exit 1
fi

if [[ ! -d "$APP_DIR/src" ]]; then
  echo "App src directory not found: $APP_DIR/src" >&2
  exit 1
fi

mkdir -p "$APP_DIR/src/components/ui" "$APP_DIR/src/lib"
rsync -a "variants/frontend-vite/templates/src/" "$APP_DIR/src/"

if [[ "$INSTALL_DEPS" == "true" ]]; then
  if ! command -v pnpm >/dev/null 2>&1; then
    echo "pnpm is required to install dependencies" >&2
    exit 1
  fi
  (cd "$APP_DIR" && printf 'save-exact=true\n' > .npmrc && pnpm add -E class-variance-authority clsx tailwind-merge @radix-ui/react-slot framer-motion lucide-react)
fi

echo "✓ Copied source-owned base components into $APP_DIR/src"
echo "Note: these components expect Tailwind-style design tokens/classes to exist in the app CSS."
