# Hooks Pattern

Use this document as a portable Mahiro-style hook baseline when the target repo has no stronger local convention.

Local project rules and current code always win.

## File and export shape

Prefer:

- kebab-case filenames with `use-` prefix: `use-example-toggle.ts`, `use-fetch-cart.tsx`
- named exports
- owner-local types until reuse creates a shared owner
- `import type` for type-only imports

```ts
import { useCallback, useState } from 'react'

const useExampleToggle = (defaultOpen = false) => {
  // _State
  const [isOpen, setIsOpen] = useState(defaultOpen)

  // _Callback
  const open = useCallback(() => {
    setIsOpen(true)
  }, [])

  const close = useCallback(() => {
    setIsOpen(false)
  }, [])

  return { isOpen, open, close }
}

export { useExampleToggle }
```

## Section comments

Use section comments when the hook has matching concerns:

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

- do not add empty markers
- preserve existing markers when editing
- put browser subscriptions and cleanup under `_Effect`
- put exposed handlers under `_Callback` or `_Event` depending on repo convention

## State boundaries

Prefer:

- local `useState` / `useReducer` for isolated UI state
- project query abstraction or React Query for server state
- Zustand only when client state is shared broadly
- services for API transport and payload mapping

Avoid:

- hooks that fetch directly while bypassing service/query owners
- hooks that mix unrelated UI state and server mutation behavior
- global state for one component's private toggle

## Query and mutation hooks

When a project has React Query or a wrapper, keep query/mutation wiring in hooks:

```ts
import { useMutation } from '@tanstack/react-query'

import ExampleService from '@/services/example'

const useCreateExample = () => {
  // _Mutation
  return useMutation({
    mutationFn: ExampleService.create,
  })
}

export { useCreateExample }
```

Prefer centralized loading/error/empty/data rendering when the project has a reusable query-state component.

## Effect safety

For effects:

- clean up event listeners and timers
- avoid reading `window` outside browser-safe effects
- keep dependency arrays honest
- do not use effects for values that can be derived during render

## Review checklist

Before accepting a hook:

1. Does it own one clear behavior?
2. Is server state handled by the project query layer?
3. Are side effects cleaned up?
4. Are returned handlers stable when needed?
5. Is state local unless shared ownership exists?
6. Are section comments present only where useful?
