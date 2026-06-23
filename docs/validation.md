# Validation

Adapt this file after choosing a stack.

## Current baseline

```bash
./scripts/check.sh
```

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
