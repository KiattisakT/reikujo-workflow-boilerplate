# Source-Owned Base Components

This variant follows the `shadcn-ui/ui` component-writing style without installing the shadcn CLI or treating shadcn as a runtime component library.

The point is the pattern:

- components are copied into the app source and owned by the project
- `components/ui/*` contains small primitives, not business components
- `cn()` owns class composition with `clsx` + `tailwind-merge`
- variant classes live beside the component through `class-variance-authority`
- components expose typed variants through `VariantProps`
- polymorphic composition uses `asChild` + Radix `Slot` only where it earns value
- components include `data-slot` / `data-*` hooks for styling, grouping, and tests
- domain-specific behavior wraps primitives instead of leaking into primitives

## Primitive choice

Default to **Radix UI primitives** for this variant.

Reasons:

- Radix is the established base for the shadcn-style ecosystem.
- It has broad examples, docs, and community usage.
- It is stable for common app primitives such as Dialog, Popover, Select, Tabs, Tooltip, Dropdown Menu, and Slot.
- It keeps Reikujo's frontend starter predictable for agent-assisted work.

Use **Base UI** only when a project explicitly chooses it or already has Base UI as Current Reality.

Do not mix Radix and Base UI casually inside the same primitive layer. If a project migrates, document the decision in `docs/decisions.md` and migrate component-by-component with validation.

## Not the goal

Do not run `shadcn init` by default.
Do not install generated component packs by default.
Do not treat upstream shadcn files as immutable vendor code.
Do not put business rules into `components/ui`.

## Suggested folders

```text
app/src/
├── components/
│   ├── ui/                # base primitives: Button, Card, Input, Label
│   ├── modules/           # domain UI: invoice table, booking form, etc.
│   ├── layouts/           # app shell/layout components
│   └── sections/          # page sections when useful
└── lib/
    └── utils.ts           # cn()
```

## Optional copy helper

After a Vite app exists, copy the starter primitives:

```bash
./scripts/copy-frontend-base-components.sh app --install-deps
```

This copies source files into `app/src/` and installs only the small runtime helpers needed by those source files:

```bash
pnpm add class-variance-authority clsx tailwind-merge @radix-ui/react-slot
```

It does not install shadcn/ui.

`@radix-ui/react-slot` is used only for the `asChild` composition pattern in the starter `Button`. Add other Radix packages only when the project adds primitives that need them.

## Base primitive rules

### Button

A button primitive should own:

- base interaction classes
- variants: `default`, `secondary`, `outline`, `ghost`, `destructive`, `link`
- sizes: `default`, `sm`, `lg`, `icon`
- disabled/focus/invalid behavior
- icon child sizing rules
- optional `asChild`

A button primitive should not own:

- domain permission rules
- loading mutation behavior
- confirmation flow
- route navigation decisions
- product-specific copy

Wrap the primitive for domain needs:

```tsx
import { Button } from '@/components/ui/button'

export const DeleteInvoiceButton = () => {
  return <Button variant="destructive">Delete invoice</Button>
}
```

### Card

A card primitive should provide shell parts:

- `Card`
- `CardHeader`
- `CardTitle`
- `CardDescription`
- `CardContent`
- `CardFooter`

Do not create a new shared card type for every product layout. Prefer module-owned cards when the card carries domain meaning.

### Input and Label

Inputs and labels should stay small and predictable.

- labels must be explicit for forms
- invalid state should have stable styling hooks
- placeholder-only UX is not enough

## Review checklist

Before accepting a new base component:

1. Is it generic enough for `components/ui`?
2. Does it avoid business rules and product copy?
3. Are variants typed and locally owned?
4. Does it compose classes through `cn()`?
5. Does `asChild` add real value, or is a normal element enough?
6. Are accessibility and focus states covered?
7. Does a domain wrapper belong above this primitive?
