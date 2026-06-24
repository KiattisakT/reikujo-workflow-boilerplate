# Frontend Vite Coding Style

This variant extends the base Reikujo and Mahiro style docs for React/Vite projects.

## Preferred direction

- React + TypeScript with clear component contracts.
- `import type` for type-only imports when supported.
- Owner-local props/types until reuse creates a shared owner.
- Named exports for reusable components/hooks/utilities unless local repo patterns differ.
- `cn`/class composition helper when the project establishes one.

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
