# Project Overview

Update this document after the generated frontend app has a real product direction.

## Product

- Name: TODO
- Audience: TODO
- Primary user goal: TODO
- Non-goals: TODO

## Stack

- React
- TypeScript
- Vite
- Tailwind CSS
- Vitest
- pnpm with exact dependency versions

## Source layout

```text
src/
├── components/
│   ├── ui/        # source-owned primitives
│   └── modules/   # product/domain components
├── hooks/         # reusable stateful behavior
├── lib/           # shared utilities such as cn()
└── main.tsx
```

## UI conventions

- Base primitives live in `src/components/ui/`.
- Domain behavior wraps primitives in `src/components/modules/` or owner-local folders.
- Use `tailwind-variants` for component variants.
- Use `cn()` from `src/lib/utils.ts` for class composition.
- Use explicit form labels; do not rely on placeholder-only UX.

## Validation

Use `docs/development-commands.md` as the source of truth for project commands.
