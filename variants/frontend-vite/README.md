# frontend-vite Variant

React/Vite frontend workflow layer for Reikujo.

This variant is intentionally workflow-first. It gives conventions, validation expectations, and scaffold helpers without making every project use the same UI library.

It configures Tailwind CSS, TypeScript, and shadcn-style source-owned component paths without running `shadcn init`.
It also creates `src/lib/utils.ts` with a `cn()` helper backed by `clsx` and `tailwind-merge`.

## Start

From a project created with the Reikujo base:

```bash
./scripts/init-project.sh "My Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps
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

Install new packages with exact versions:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

Default component paths:

```text
src/components/ui/
src/lib/utils.ts
```

If the generated app does not include a command yet, add it before treating the baseline as complete.

## Mahiro posture for frontend work

- Preserve product feel during refactors.
- Follow local primitives and `cn`/class utilities if present.
- Base primitives follow the source-owned `shadcn-ui/ui` style; do not install shadcn/ui by default.
- Prefer Radix UI primitives by default; use Base UI only as an explicit project decision.
- Keep route/page owners thin; move reusable UI to domain components.
- Keep transport in services and query/mutation wiring in hooks when those owners exist.
- Use visual checks for UI-heavy work, not build alone.
