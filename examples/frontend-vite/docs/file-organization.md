# File Organization: Pocket Ledger

Keep ownership clear. Add folders only when the feature exists.

## Current shape

```text
src/
├── components/
│   ├── ui/
│   │   ├── button.tsx
│   │   ├── card.tsx
│   │   ├── input.tsx
│   │   └── label.tsx
│   └── modules/
│       └── dashboard/
│           ├── balance-summary.tsx
│           ├── pocket-list.tsx
│           └── recent-activity.tsx
├── hooks/
│   └── use-example-toggle.ts
├── lib/
│   └── utils.ts
├── App.tsx
├── main.tsx
└── index.css
```

## Component ownership

- `components/ui/*`: generic primitives only
- `components/modules/dashboard/*`: dashboard-specific layout and behavior
- `hooks/*`: reusable behavior, not screen markup
- `services/*`: add later when backend/API exists
- `types/*`: add when domain shapes are reused

## Naming

- Files: kebab-case
- Components: PascalCase
- Props interfaces: `I...Props`
- Named exports for components and hooks

## Import examples

```ts
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { cn } from '@/lib/utils'
```

## Refactor rule

Do not move dashboard behavior into `components/ui`. Create a module component instead.
