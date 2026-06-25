# Styling

This app uses Tailwind CSS through the Vite plugin.

## Tokens

Global tokens live in `src/index.css` under `@theme`.

Prefer semantic token classes:

```tsx
<div className="bg-background text-foreground" />
<button className="bg-primary text-primary-foreground" />
```

Avoid hardcoded colors in feature components when a token exists.

## Class composition

Use `cn()` from `src/lib/utils.ts`:

```tsx
import { cn } from '@/lib/utils'

const Example = ({ className }: { className?: string }) => {
  return <div className={cn('rounded-md border border-border', className)} />
}
```

## Variants

Use `tailwind-variants` for component-owned variants:

```tsx
import { tv } from 'tailwind-variants'

const cardVariants = tv({
  base: 'rounded-lg border border-border bg-card text-card-foreground',
  variants: {
    tone: {
      default: '',
      muted: 'bg-muted text-muted-foreground',
    },
  },
})
```

## Forms

- Labels must be explicit.
- Helper/error text should sit close to the field.
- Do not rely on placeholder-only UX.
- Preserve focus-visible states.

## Visual validation

Passing `pnpm build` is not visual proof.

For visual changes, run the app in a browser and check:

- mobile layout
- desktop layout
- hover/focus/active states
- empty/loading/error states when relevant
