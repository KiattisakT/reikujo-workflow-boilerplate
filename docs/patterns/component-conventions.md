# Component Conventions

Use this document as a portable Mahiro-style component baseline when the target repo has no stronger local convention.

Local project rules and existing code always win.

## File and export shape

Prefer:

- kebab-case filenames: `delete-invoice-button.tsx`, `example-section.tsx`
- named exports for reusable components
- exported prop and variant types alongside the component
- `I`-prefixed interfaces for component props
- `import type` for type-only imports

```tsx
import type { ComponentProps } from 'react'

interface IExampleSectionProps extends ComponentProps<'section'> {}

const ExampleSection = ({ className, ...props }: IExampleSectionProps) => {
  return <section className={className} {...props} />
}

export { ExampleSection, type IExampleSectionProps }
```

## Ownership layers

Keep ownership clear:

- route/page: URL, loader/action, route composition
- module/domain component: business UI and product behavior
- shared primitive: generic visual behavior only
- hook: reusable stateful behavior
- service: transport/API mapping

Do not put product copy, permissions, API calls, or mutation logic inside `components/ui` primitives.

## Variants

For Mahiro-style frontend variants, use `tailwind-variants`:

```tsx
import type { ComponentProps } from 'react'
import { tv, type VariantProps } from 'tailwind-variants'

import { cn } from '@/lib/utils'

const badgeVariants = tv({
  base: 'inline-flex rounded-md px-2 py-1 text-xs font-medium',
  variants: {
    variant: {
      default: 'bg-primary text-primary-foreground',
      muted: 'bg-muted text-muted-foreground',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

interface IBadgeVariants extends VariantProps<typeof badgeVariants> {}
interface IBadgeProps extends ComponentProps<'span'>, IBadgeVariants {}

const Badge = ({ className, variant, ...props }: IBadgeProps) => {
  return <span className={cn(badgeVariants({ variant, className }))} {...props} />
}

export { Badge, badgeVariants, type IBadgeProps, type IBadgeVariants }
```

Avoid `class-variance-authority`/`cva` in Reikujo Mahiro-style variants unless the target repo already uses it.

## Section comments

Use section comments when the component has matching concerns:

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

Rules:

- do not add empty sections
- preserve existing sections while editing
- keep handlers under `_Event`
- keep derived values under `_Memo`
- keep side effects under `_Effect`

## Styling

- Use `cn()` when composing conditional classes.
- Use project tokens instead of hardcoded colors when tokens exist.
- Keep labels explicit; do not rely on placeholder-only form UX.
- Use visual validation for UI-heavy work; build alone is not visual proof.

## Review checklist

Before accepting a component:

1. Does the file owner match the behavior it contains?
2. Are props typed and exported?
3. Are variants local and typed?
4. Does it use `cn()` instead of manual string juggling?
5. Are business rules outside shared primitives?
6. Are accessibility and focus states covered?
7. Was layout visually checked when the change is visual?
