# Mahiro Reference

This document captures durable Mahiro-style lessons that Reikujo variants should apply when the target project has no stronger local convention.

Mahiro Style is a fallback layer, not a replacement for repo reality. If a project already has clear rules, current code and local docs win.

## Reference project

`/Users/kiattisakmayong/Work/eizypay-fe` is a mature Mahiro-style frontend monorepo.

Useful observed patterns:

- monorepo apps/packages are documented separately
- quick rules live in `AGENTS.md`
- detailed rules live under `docs/`
- components and hooks use required section comments
- component variants use `tailwind-variants`
- shared UI exports components and prop types together
- services extend a base transport class with static methods
- React Query UI state is centralized instead of scattered ternaries
- package-manager reality is explicit per repo

## Reikujo default for frontend variants

For Reikujo-owned frontend variants, default to:

- package manager: `pnpm`
- exact dependency versions: `pnpm add -E` / `pnpm add -D -E`
- variant utility: `tailwind-variants`
- class utility: `cn()` using `clsx` + `tailwind-merge`
- component path: `src/components/ui/`
- utility path: `src/lib/utils.ts`
- alias: `@/*` → `src/*`

## Component rules

Prefer:

- kebab-case filenames
- named component exports
- `I`-prefixed prop interfaces such as `IButtonProps`
- exported prop/variant types alongside implementations
- `import type` for type-only imports
- owner-local types until reuse creates a shared owner
- `cn()` for class composition
- `tv()` + `VariantProps` from `tailwind-variants` for component-owned variants

Avoid:

- business behavior inside `components/ui`
- premature shared components
- raw conditional class strings when `cn()` exists
- cva in Mahiro-style variants unless the target repo already uses it

## Section comments

Use these markers in components and hooks when the component has matching concerns:

```ts
// _Ref
// _State
// _Query
// _Mutation
// _Memo
// _Callback
// _Form
// _Event
// _Effect
```

They are organizational markers, not decorative comments. Do not add empty sections just to satisfy a template, but preserve existing sections when editing.

## State and data boundaries

Preferred direction:

- server state belongs in React Query or the project-local query abstraction
- client-only UI state belongs in component state or Zustand when shared broadly
- loading/error/empty/data rendering should be centralized when a project has a reusable query-state component
- services own API endpoints, payload mapping, response typing, and fallback behavior

## Docs structure worth copying

For larger generated projects, prefer docs shaped like:

```text
docs/project-overview.md
docs/development-commands.md
docs/file-organization.md
docs/code-style/typescript.md
docs/code-style/imports.md
docs/patterns/component-conventions.md
docs/patterns/hooks-pattern.md
docs/patterns/services-pattern.md
docs/styling.md
docs/i18n-guidelines.md
```

Use only the docs that match the project's actual scope. Do not create empty ceremony.

Current Reikujo portable pattern docs:

- `docs/patterns/component-conventions.md`
- `docs/patterns/hooks-pattern.md`
