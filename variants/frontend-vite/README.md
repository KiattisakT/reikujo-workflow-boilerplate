# frontend-vite Variant

React/Vite frontend workflow layer for Reikujo.

This variant is intentionally workflow-first. It gives conventions, validation expectations, and scaffold helpers without making every project use the same UI library.

## Start

From a project created with the Reikujo base:

```bash
./scripts/init-project.sh "My Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
```

## Default app directory

```text
app/
```

Keep Reikujo docs and `.agent-state/` at the repository root. Keep frontend package commands inside `app/` unless the project later becomes a workspace.

## Baseline commands

From `app/`:

```bash
pnpm install
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

If the generated app does not include a command yet, add it before treating the baseline as complete.

## Mahiro posture for frontend work

- Preserve product feel during refactors.
- Follow local primitives and `cn`/class utilities if present.
- Keep route/page owners thin; move reusable UI to domain components.
- Keep transport in services and query/mutation wiring in hooks when those owners exist.
- Use visual checks for UI-heavy work, not build alone.
