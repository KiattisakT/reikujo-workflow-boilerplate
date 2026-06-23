#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

STAMP="$(date '+%Y-%m-%d-%H%M')"
OUT=".agent-state/handoffs/${STAMP}.md"
mkdir -p "$(dirname "$OUT")"
cp templates/handoff.md "$OUT"

echo "✓ Created handoff: $OUT"
echo "Edit it before ending the session."
