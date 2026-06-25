# Development Commands

Run commands from the generated frontend app directory.

## Install

```bash
pnpm install
```

Packages should be installed with exact versions:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

Keep `.npmrc` with:

```text
save-exact=true
```

## Development

```bash
pnpm dev
```

## Validation

```bash
pnpm typecheck
pnpm test -- --run
pnpm build
```

Add lint/e2e commands only after the project actually configures those tools.

## When to run more

- UI/layout changes: run the app and do browser/screenshot checks.
- Routing or production behavior: run `pnpm build`.
- Dependency/config changes: do a clean install/build when practical.
- Template changes in Reikujo: from Reikujo root, run `./scripts/test-frontend-vite-smoke.sh`.
