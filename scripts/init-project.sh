#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="${1:-}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$ROOT")"
fi

python3 - "$PROJECT_NAME" <<'PY'
from pathlib import Path
import sys

project_name = sys.argv[1]
readme = Path('README.md')
brief = Path('docs/project-brief.md')

if readme.exists():
    text = readme.read_text()
    text = text.replace('# reikujo-workflow-boilerplate', f'# {project_name}', 1)
    readme.write_text(text)

if brief.exists():
    text = brief.read_text()
    text = text.replace('## Project name\n\nTODO', f'## Project name\n\n{project_name}', 1)
    brief.write_text(text)
PY

echo "✓ Initialized project: $PROJECT_NAME"
echo "Next: fill docs/project-brief.md and docs/validation.md"
