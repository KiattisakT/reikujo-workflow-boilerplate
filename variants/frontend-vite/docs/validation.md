# Frontend Vite Validation

Run from the frontend app directory, usually `app/`.

## Baseline

```bash
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

## Dependency policy

Use exact package versions for app dependencies:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

Keep `.npmrc` with:

```text
save-exact=true
```

Do not leave `^` or `~` version ranges in generated app `package.json` unless the project explicitly chooses range-based updates.

## Tailwind and component structure

The frontend-vite scaffold configures Tailwind CSS through the Vite plugin and sets up the `@/*` alias for shadcn-style source-owned components.

Expected paths:

```text
app/src/components/ui/
app/src/lib/utils.ts
```

If a project changes these paths, update imports and docs together so copied components do not drift.

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
