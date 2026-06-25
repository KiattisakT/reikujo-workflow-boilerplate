# File Organization

This app starts small. Add folders only when ownership becomes clear.

## Default shape

```text
src/
├── components/
│   ├── ui/
│   └── modules/
├── hooks/
├── lib/
├── assets/
├── App.tsx
├── main.tsx
└── index.css
```

## Components

```text
src/components/ui/        # generic source-owned primitives
src/components/modules/   # feature/domain components
src/components/layouts/   # app shell/layout components, when needed
src/components/sections/  # page sections, when useful
```

Rules:

- Keep `components/ui/*` generic.
- Put business behavior in modules or route/page owners.
- Use kebab-case filenames.
- Export component types alongside components.

## Hooks

```text
src/hooks/use-example-toggle.ts
```

Rules:

- Use `use-` prefix in filenames.
- Keep each hook focused on one behavior.
- Use section comments when the hook has matching concerns.

## Services

Add `src/services/` only when the app starts calling APIs.

```text
src/services/example.ts
src/types/example.ts
```

Services own transport and payload mapping. Hooks own query/mutation wiring.

## Imports

The app configures `@/*` to resolve to `src/*`.

```ts
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'
```
