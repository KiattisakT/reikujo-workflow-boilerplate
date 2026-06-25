# Source-Owned Base Components

This variant uses a shadcn-style source layout with a Mahiro-style implementation profile. It does not install the shadcn CLI or treat shadcn as a runtime component library.

The point is the pattern:

- components are copied into the app source and owned by the project
- `components/ui/*` contains small primitives, not business components
- `cn()` owns class composition with `clsx` + `tailwind-merge`
- variant classes live beside the component through `tailwind-variants` (`tv`)
- components expose typed variants through `VariantProps`
- polymorphic composition uses `asChild` + Radix `Slot` only where it earns value
- components include `data-slot` / `data-*` hooks for styling, grouping, and tests
- domain-specific behavior wraps primitives instead of leaking into primitives

The default generated app uses a shadcn-style source structure:

```text
app/src/components/ui/
app/src/lib/utils.ts
```

The scaffold also configures the `@/*` alias so examples can use imports like `@/components/ui/button` and `@/lib/utils`.

For Mahiro-specific component rules, also read `variants/frontend-vite/docs/mahiro-component-profile.md`.

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
│   ├── ui/                # base primitives: Button, Card, Input, Label, etc.
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

This copies source files into `app/src/` and installs only the runtime helpers needed by those source files:

```bash
pnpm add -E tailwind-variants clsx tailwind-merge @radix-ui/react-slot framer-motion lucide-react
```

It does not install shadcn/ui.

`@radix-ui/react-slot` is used only for the `asChild` composition pattern in the starter `Button`. Add other Radix packages only when the project adds primitives that need them.

`framer-motion` and `lucide-react` are included for the optional `tubelight-navbar` component/demo. If a project does not use that component, it may remove the component and dependencies.

Package installs should use exact versions. The helper writes `.npmrc` with `save-exact=true` and runs `pnpm add -E ...` so generated `package.json` entries do not use `^` or `~` ranges.

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

### Badge

A badge primitive should own small status/metadata labels.

- use `tailwind-variants`
- keep status-to-variant mapping in module/domain code
- avoid embedding business status copy in the primitive

### Input, Textarea, and Label

Inputs and labels should stay small and predictable.

- labels must be explicit for forms
- invalid state should have stable styling hooks
- placeholder-only UX is not enough

### Separator

Separators should be used for visual grouping, not layout spacing. Prefer semantic `role="separator"` only when the separator is meaningful to assistive technology.

### Skeleton

Skeletons should match the shape of the final content and reduce layout shift during loading states.

### Tubelight navbar

The starter includes `components/ui/tubelight-navbar.tsx` as a source-owned animated navigation example inspired by Magic UI-style components.

In Vite/React projects it uses normal `<a>` links. In Next.js projects, replace those with `next/link` if the app uses Next routing.

It requires:

```bash
pnpm add -E framer-motion lucide-react
```

Keep this component in `components/ui` only while it remains generic. If it starts carrying product-specific routes, permissions, or copy, wrap it in a domain/layout component instead.

## Review checklist

Before accepting a new base component:

1. Is it generic enough for `components/ui`?
2. Does it avoid business rules and product copy?
3. Are variants typed and locally owned?
4. Does it compose classes through `cn()`?
5. Does `asChild` add real value, or is a normal element enough?
6. Are accessibility and focus states covered?
7. Does a domain wrapper belong above this primitive?
