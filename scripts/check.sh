#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "✓ reikujo workflow baseline"
echo "root: $ROOT"

required=(
  "AGENTS.md"
  "README.md"
  "docs/project-brief.md"
  "docs/workflow.md"
  "docs/validation.md"
  "docs/handoff.md"
)

for file in "${required[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

echo "✓ required workflow files exist"
