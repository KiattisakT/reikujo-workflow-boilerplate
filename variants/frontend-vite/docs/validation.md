# Frontend Vite Validation

Run from the frontend app directory, usually `app/`.

## Baseline

```bash
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

## When to add more

- UI layout/responsiveness: browser or screenshot validation.
- Critical flows: Playwright e2e.
- API/data boundaries: unit tests for mappers, services, and hooks.
- Dependency/config changes: clean install and build.

## Report format

When finishing work, report:

- command run
- pass/fail
- important error output if failed
- what was not visually tested
