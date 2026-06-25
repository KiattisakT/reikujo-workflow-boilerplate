# Mahiro Component Profile

The `frontend-vite` variant uses a Mahiro-style component profile by default.

For portable project-level pattern docs, also read:

- `docs/patterns/component-conventions.md`
- `docs/patterns/hooks-pattern.md`

## Defaults

- Package manager: `pnpm`
- Exact installs: `pnpm add -E` / `pnpm add -D -E`
- Variant utility: `tailwind-variants`
- Class utility: `cn()` from `src/lib/utils.ts`
- Base primitives: `src/components/ui/`
- Domain components: `src/components/modules/` or owner-local folders
- Alias: `@/*` → `src/*`

## Component skeleton

```tsx
import type { ComponentProps } from 'react'
import { tv, type VariantProps } from 'tailwind-variants'

import { cn } from '@/lib/utils'

const exampleVariants = tv({
  base: 'rounded-md transition-colors',
  variants: {
    variant: {
      default: 'bg-primary text-primary-foreground',
      outline: 'border border-border bg-background',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

interface IExampleVariants extends VariantProps<typeof exampleVariants> {}

interface IExampleProps extends ComponentProps<'div'>, IExampleVariants {}

const Example = ({ className, variant, ...props }: IExampleProps) => {
  return <div className={cn(exampleVariants({ variant, className }))} {...props} />
}

export { Example, exampleVariants, type IExampleProps, type IExampleVariants }
```

## Section comments

Use section comments when a component or hook has matching concerns:

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

Do not add empty markers. Preserve markers already present in edited files.

## Primitive vs domain component

Keep `components/ui/*` generic:

- no permissions
- no product-specific copy
- no mutation behavior
- no route decisions
- no API calls

Wrap primitives in owner-local modules for domain behavior:

```text
src/components/ui/button.tsx
src/components/modules/invoice/delete-invoice-button.tsx
```

The starter templates include `src/services/example.ts`, `src/types/example.ts`, and `src/components/modules/example/example-list-state.tsx` to demonstrate service ownership and loading/error/empty/data rendering without forcing a query library into every generated project.

## Animation and icons

- Use animation libraries only when the component earns motion.
- Keep animated primitives generic, like `tubelight-navbar`.
- Put route-specific nav data outside the primitive.
- Follow project icon conventions. For this starter, `lucide-react` is used only by the optional navbar demo.
