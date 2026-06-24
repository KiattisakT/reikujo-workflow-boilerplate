# Validation

Adapt this file after choosing a stack.

## Current baseline

```bash
./scripts/check.sh
```

## Variant smoke tests

For the generated React/Vite frontend variant:

```bash
./scripts/test-frontend-vite-smoke.sh
```

This creates a temporary Reikujo project, scaffolds `frontend-vite`, copies base components, verifies exact package versions and required generated files, then runs `pnpm typecheck`, `pnpm test -- --run`, and `pnpm build` inside the generated app.

## Add project-specific checks here

Examples:

```bash
# frontend
pnpm typecheck
pnpm lint
pnpm test
pnpm build

# backend
pnpm test
pnpm build
pnpm db:validate

# visual / e2e
pnpm e2e
```

## Reporting validation

When reporting completion, include:

- commands run
- pass/fail result
- important failure output if failed
- what was not validated
