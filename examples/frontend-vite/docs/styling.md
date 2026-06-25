# Styling: Pocket Ledger

Pocket Ledger uses Tailwind CSS with semantic tokens from `src/index.css`.

## Palette

Use the generated tokens first:

```tsx
<div className="bg-background text-foreground" />
<Card className="border-border bg-card text-card-foreground" />
<Button className="bg-primary text-primary-foreground" />
```

## Surfaces

- Use flat surfaces with subtle borders.
- Avoid heavy shadows.
- Avoid bright gradients for finance UI.
- Use accent color only for primary actions and selected states.

## Component variants

Use `tailwind-variants` for reusable variants:

```tsx
const amountVariants = tv({
  base: 'font-medium tabular-nums',
  variants: {
    tone: {
      income: 'text-emerald-600',
      expense: 'text-rose-600',
      neutral: 'text-muted-foreground',
    },
  },
})
```

## Forms

- Label every input.
- Helper text belongs below the input.
- Error text should be direct and close to the field.
- Preserve focus-visible states.

## Responsive checks

Dashboard cards should collapse into a single column on mobile.

Avoid fixed pixel widths. Use grid and max-width containers.
