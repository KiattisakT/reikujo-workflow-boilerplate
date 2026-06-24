# Frontend Vite Variant

The `frontend-vite` variant adds a React/Vite-oriented workflow layer on top of the Reikujo base.

Use it when the project is a frontend app or prototype that should start with:

- React + TypeScript
- Vite
- pnpm
- Tailwind/shadcn-style UI posture, when the project chooses that stack
- shadcn-style source-owned component paths without running shadcn CLI
- Vitest for unit/component tests
- Playwright for visual/e2e checks when UI behavior matters

## How to start

```bash
./scripts/init-project.sh "My Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps
```

The scaffold script creates the app in `app/` by default. Keep Reikujo workflow docs at the repo root.

## Ownership shape

Recommended source layout after scaffold:

```text
app/src/
├── app/              # app shell and route registry when routing exists
├── components/       # shared UI, layouts, modules, sections
├── hooks/            # reusable stateful behavior, fetchers, mutations
├── services/         # API clients and transport boundaries
├── stores/           # long-lived client state
├── constants/        # shared runtime constants
├── types/            # shared API/domain contracts
├── utils/            # focused pure helpers
└── styles/           # global styles/theme entry points
```

Do not create every folder up front. Add owners when code earns them.

## Validation baseline

From `app/`:

```bash
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

Use exact dependency versions in generated apps:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

Add Playwright/e2e checks when layout, routing, auth, or critical flows matter.

The scaffold configures Tailwind CSS and the `@/*` alias so copied primitives can live in:

```text
app/src/components/ui/
app/src/lib/utils.ts
```

## UI posture

Use Mahiro Style plus project-local product tone:

- local primitives first
- explicit labels for forms
- no generic SaaS metric-card walls by default
- no gradient/pill/motion overload without product reason
- visual QA for layout-sensitive changes

## Base components

This variant follows the `shadcn-ui/ui` source-owned component pattern without installing shadcn/ui by default.

Default primitive choice: Radix UI. Base UI is an intentional project-level alternative, not the default.

Read `variants/frontend-vite/docs/base-components.md` for the convention and optional copy helper.
