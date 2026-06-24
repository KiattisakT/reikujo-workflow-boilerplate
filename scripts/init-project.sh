#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PROJECT_NAME=""
VARIANT="base"
PACKAGE_MANAGER="project-defined"
INIT_GIT="false"

usage() {
  cat <<'EOF'
Usage: ./scripts/init-project.sh "Project Name" [options]

Options:
  --variant <name>           Workflow variant. Default: base
  --package-manager <name>   Preferred package manager. Default: project-defined
  --git                      Initialize git if this folder is not already a repo
  -h, --help                 Show this help

Examples:
  ./scripts/init-project.sh "Dream Catcher"
  ./scripts/init-project.sh "Pordee" --variant frontend-vite --package-manager pnpm --git
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --variant)
      VARIANT="${2:-}"
      shift 2
      ;;
    --package-manager)
      PACKAGE_MANAGER="${2:-}"
      shift 2
      ;;
    --git)
      INIT_GIT="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$PROJECT_NAME" ]]; then
        PROJECT_NAME="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        usage >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$ROOT")"
fi

if [[ -z "$VARIANT" ]]; then
  echo "--variant requires a value" >&2
  exit 1
fi

if [[ -z "$PACKAGE_MANAGER" ]]; then
  echo "--package-manager requires a value" >&2
  exit 1
fi

python3 - "$PROJECT_NAME" "$VARIANT" "$PACKAGE_MANAGER" <<'PY'
from pathlib import Path
from datetime import datetime, timezone
import json
import sys

project_name = sys.argv[1]
variant = sys.argv[2]
package_manager = sys.argv[3]
readme = Path('README.md')
brief = Path('docs/project-brief.md')
manifest = Path('reikujo.json')

if readme.exists():
    text = readme.read_text()
    text = text.replace('# reikujo-workflow-boilerplate', f'# {project_name}', 1)
    text = text.replace('A personal workflow boilerplate for agent-assisted projects.', 'TODO: Describe this project.', 1)
    readme.write_text(text)

if brief.exists():
    text = brief.read_text()
    text = text.replace('## Project name\n\nTODO', f'## Project name\n\n{project_name}', 1)
    brief.write_text(text)

if manifest.exists():
    data = json.loads(manifest.read_text())
else:
    data = {}

data.setdefault('schemaVersion', 1)
workflow = data.setdefault('workflow', {})
workflow.setdefault('name', 'reikujo')
workflow.setdefault('version', '0.1.0')
workflow['variant'] = variant

project = data.setdefault('project', {})
project['name'] = project_name
if project.get('description') in (None, '', 'A personal workflow boilerplate for agent-assisted projects.'):
    project['description'] = 'TODO: Describe this project.'
project['preferredPackageManager'] = package_manager
project['initializedAt'] = datetime.now(timezone.utc).isoformat(timespec='seconds')

generated_from = data.setdefault('generatedFrom', {})
generated_from.setdefault('name', 'reikujo-workflow-boilerplate')
generated_from.setdefault('version', workflow.get('version', '0.1.0'))

manifest.write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n')
PY

if [[ "$INIT_GIT" == "true" ]]; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "✓ Git already initialized"
  else
    git init -b main
    echo "✓ Initialized git repository"
  fi
fi

echo "✓ Initialized project: $PROJECT_NAME"
echo "✓ Variant: $VARIANT"
echo "✓ Package manager: $PACKAGE_MANAGER"
echo "Next: fill docs/project-brief.md and docs/validation.md"
