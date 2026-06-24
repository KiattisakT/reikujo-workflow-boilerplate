# Frontend Vite Coding Style

This variant extends the base Reikujo and Mahiro style docs for React/Vite projects.

## Preferred direction

- React + TypeScript with clear component contracts.
- `import type` for type-only imports when supported.
- Owner-local props/types until reuse creates a shared owner.
- Named exports for reusable components/hooks/utilities unless local repo patterns differ.
- `cn`/class composition helper when the project establishes one.
- Source-owned base primitives modeled after `shadcn-ui/ui`, not installed as a component library.
- Radix-first primitive choice for new base components unless the project explicitly chooses Base UI.

## Component ownership

- Route/page: orchestration, URL, loader/action, page composition.
- Domain component: business UI and screen sections.
- Shared UI primitive: generic, reusable visual primitive only.
- Hook: reusable stateful behavior or query/mutation wiring.
- Service: transport and API payload mapping.

## UI restraint

Avoid generic AI frontend defaults:

- metric-card walls without user value
- decorative pill clusters
- fake-premium gradients
- gratuitous animation
- verbose helper copy
- placeholder-only form labels

Prefer product-specific hierarchy, clear actions, and visual checks.

## Base component pattern

For `components/ui/*` primitives, prefer:

- `cn()` from `src/lib/utils.ts`
- `cva()` + `VariantProps` for component-owned variants
- `data-slot` and useful `data-*` attributes
- `asChild` only when polymorphic composition is useful
- domain wrappers above primitives for business behavior

Primitive package rule:

- Use Radix UI by default for headless primitives.
- Use Base UI only when the project decides it intentionally.
- Do not mix both casually in the same primitive family.
