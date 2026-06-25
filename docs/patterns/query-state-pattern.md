# Query State Pattern

Use this document as a portable Mahiro-style baseline for loading, error, empty, fetching, and data UI.

Local project rules and current code always win.

## Goal

Avoid scattering manual ternaries across feature screens:

```tsx
{isLoading ? <Spinner /> : error ? <Error /> : items.length === 0 ? <Empty /> : <List />}
```

Prefer a centralized query-state owner when a project has repeated async UI patterns.

## States to cover

A complete query UI should define:

- loading: first load, no data yet
- error: first load failed
- empty: loaded successfully but no useful data
- data: loaded successfully with data
- fetching/refetching: background refresh while data may still exist
- refetch error: background refresh failed while old data may still exist

## Component shape

A reusable query-state component can accept render props:

```tsx
interface IQueryStateViewProps<TData> {
  isLoading: boolean
  isFetching?: boolean
  error?: unknown
  data?: TData
  isEmpty?: (data: TData) => boolean
  renderLoading: () => React.ReactNode
  renderError: (error: unknown) => React.ReactNode
  renderEmpty: () => React.ReactNode
  renderData: (data: TData) => React.ReactNode
}
```

Generated projects do not need this component immediately. Add it when at least two screens repeat the same query-state branching.

## Usage example

```tsx
<QueryStateView
  query={invoiceQuery}
  isEmpty={(data) => data.items.length === 0}
  renderLoading={() => <InvoiceTableSkeleton />}
  renderError={() => <InlineError message="Could not load invoices." />}
  renderEmpty={() => <EmptyInvoices />}
  renderData={(data) => <InvoiceTable items={data.items} />}
/>
```

## Loading states

Prefer skeletons that match the final layout over generic spinners.

Good loading states:

- preserve table row height
- preserve card shape
- preserve form field rhythm
- avoid layout jump

Use spinner-only loading for tiny inline actions, not full screens.

## Error states

Error copy should be direct and actionable:

- "Could not load invoices. Try again."
- "Connection failed. Check your network and retry."

Avoid vague copy such as "Oops" or unrelated apologies.

## Empty states

Empty states should say:

- what is empty
- why it matters
- what the user can do next, if any

Keep empty states calm. Do not add a CTA if there is no real next action.

## Refetching

When existing data is visible and a background refetch starts:

- do not replace the whole screen with loading
- show subtle fetching state if useful
- preserve scroll and selection when possible

When background refetch fails:

- preserve old data
- surface non-blocking error if needed

## Relationship to services and hooks

- services fetch and map data
- hooks connect services to query/mutation libraries
- query-state components render async UI states
- feature modules decide empty-state copy and layout

## Review checklist

Before accepting query UI:

1. Are loading, error, empty, and data states covered?
2. Does loading preserve final layout size?
3. Does error copy name the problem clearly?
4. Does empty state explain the next useful action?
5. Does refetching preserve existing data when possible?
6. Is query-state branching centralized when repeated?
7. Are services and hooks still the data owners?
