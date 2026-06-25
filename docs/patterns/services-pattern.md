# Services Pattern

Use this document as a portable Mahiro-style service baseline when the target repo has no stronger local convention.

Local project rules and current code always win.

## Ownership

Services own API transport and mapping concerns:

- endpoint names and URLs
- request payload shape
- response typing
- response fallback behavior
- auth/header behavior when the project has a base transport layer
- low-level fetch/client errors

Services should not own:

- React component state
- route rendering
- toast copy unless the project already centralizes it there
- form state
- permission UI
- query cache invalidation

Components and hooks should not call `fetch` directly when a service layer exists.

## File shape

Prefer a folder per domain when the service has helpers or many methods:

```text
src/services/
├── base.ts
├── invoice/
│   ├── index.ts
│   └── utils.ts
└── customer/
    ├── index.ts
    └── utils.ts
```

For small apps, a single file per domain is enough:

```text
src/services/invoice.ts
src/services/customer.ts
```

## Static methods

Mahiro-style service classes should use static methods when a class-based base service exists.

```ts
import BaseService from '@/services/base'
import type { IRequestConfig } from '@/types/base'
import type { IInvoiceListPayload, IInvoiceListResponse } from '@/types/invoice'

export default class InvoiceService extends BaseService {
  /**
   * Get invoice list.
   */
  static list(payload: IInvoiceListPayload, config?: IRequestConfig<IInvoiceListResponse>) {
    return this._post<IInvoiceListResponse>('/invoice.list', payload, {
      ...config,
      fallback: {
        items: [],
        total: 0,
      },
    })
  }
}
```

If a project does not use class-based services, keep the same ownership boundary with plain exported functions.

## Types

Define payload and response types near the project's type owner:

```text
src/types/invoice.ts
src/services/invoice/index.ts
```

Prefer `I`-prefixed interfaces when the project follows Mahiro-style TypeScript:

```ts
export interface IInvoiceListPayload {
  page: number
  limit: number
  status?: string
}

export interface IInvoiceListItem {
  id: string
  code: string
  total: number
}

export interface IInvoiceListResponse {
  items: IInvoiceListItem[]
  total: number
}
```

## Method naming

Use boring, predictable verbs:

- `list` / `get` / `detail` / `me` for reads
- `create` / `add` for creates
- `update` / `edit` for updates
- `remove` / `delete` for deletes
- domain verbs for real actions, e.g. `confirm`, `cancel`, `recalculate`

Match backend endpoint wording when it is already established.

## Error and fallback behavior

Fallbacks should be explicit and close to the service method when the project supports request fallback config.

Use fallbacks for safe read paths:

```ts
fallback: {
  items: [],
  total: 0,
}
```

Avoid hiding write failures with fallbacks unless the product explicitly wants best-effort behavior.

## Hooks consume services

Hooks wire services into query/mutation libraries:

```ts
import { useQuery } from '@tanstack/react-query'

import InvoiceService from '@/services/invoice'
import type { IInvoiceListPayload } from '@/types/invoice'

const useFetchInvoices = (payload: IInvoiceListPayload) => {
  // _Query
  return useQuery({
    queryKey: ['invoices', payload],
    queryFn: () => InvoiceService.list(payload),
  })
}

export { useFetchInvoices }
```

Keep cache invalidation, optimistic updates, and UI messages in hooks or module owners unless the target repo has a different established owner.

## Review checklist

Before accepting a service:

1. Does the service own transport and mapping only?
2. Are payload and response types explicit?
3. Are method names predictable and aligned with backend endpoints?
4. Are fallbacks safe and intentional?
5. Are write errors surfaced instead of hidden?
6. Are components/hooks using the service instead of raw fetch calls?
7. Is auth/header behavior centralized in the base transport when applicable?
