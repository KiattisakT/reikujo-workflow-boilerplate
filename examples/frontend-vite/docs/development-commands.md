# Development Commands: Pocket Ledger

Run commands from the generated app directory.

## Install

```bash
pnpm install
```

Install packages with exact versions only:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

## Development

```bash
pnpm dev
```

Default local URL:

```text
http://localhost:5173
```

## Validation

```bash
pnpm typecheck
pnpm test -- --run
pnpm build
```

## Visual checks

For UI changes, manually check:

- 360px mobile width
- 768px tablet width
- 1280px desktop width
- hover/focus/active button states
- empty transaction list
- form validation copy

## Reikujo template validation

When editing the Reikujo scaffold/templates rather than the generated app:

```bash
./scripts/test-frontend-vite-smoke.sh
```
