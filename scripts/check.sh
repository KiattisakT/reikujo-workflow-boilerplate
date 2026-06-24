#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "✓ reikujo workflow baseline"
echo "root: $ROOT"

required=(
  "AGENTS.md"
  "README.md"
  "reikujo.json"
  "docs/project-brief.md"
  "docs/workflow.md"
  "docs/validation.md"
  "docs/mahiro-style.md"
  "docs/handoff.md"
)

for file in "${required[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

echo "✓ required workflow files exist"

python3 - <<'PY'
import json
from pathlib import Path

data = json.loads(Path('reikujo.json').read_text())
required = [
    data.get('schemaVersion'),
    data.get('workflow', {}).get('name'),
    data.get('workflow', {}).get('version'),
    data.get('workflow', {}).get('variant'),
    data.get('project', {}).get('name'),
]
if any(value in (None, '') for value in required):
    raise SystemExit('Invalid reikujo.json: missing required manifest fields')

for manifest_path in sorted(Path('variants').glob('*/reikujo.variant.json')):
    variant = json.loads(manifest_path.read_text())
    required_variant = [
        variant.get('schemaVersion'),
        variant.get('name'),
        variant.get('workflowVersion'),
        variant.get('description'),
    ]
    if any(value in (None, '') for value in required_variant):
        raise SystemExit(f'Invalid variant manifest: {manifest_path}')
PY

echo "✓ reikujo manifest is valid"
echo "✓ variant manifests are valid"
