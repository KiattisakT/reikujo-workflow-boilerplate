# Workflow

## Default flow

```text
explore → plan → implement → validate → handoff
```

## 1. Explore

Before implementation, inspect project reality:

- `AGENTS.md`
- `README.md`
- `docs/`
- package scripts/config
- current source patterns
- existing tests and validation commands

Use semantic search if available for broad exploration, then verify by reading exact files.

## 2. Plan

For non-trivial work, write a short plan before changing files:

- scope
- files/areas likely touched
- risks
- validation
- next decision needed, if any

## 3. Implement

Keep changes scoped. Prefer incremental edits. Do not rewrite unrelated systems.

## 4. Validate

Run the relevant commands from `docs/validation.md`. Report failures honestly with the important error.

## 5. Handoff

Update `docs/handoff.md` or `.agent-state/handoffs/` when context may reset.

A good handoff includes:

- what changed
- files touched
- validation run
- known issues
- exact next step
