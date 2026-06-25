# Project Overview: Pocket Ledger

Pocket Ledger is a small personal finance dashboard for tracking monthly income, expenses, and wallet pockets.

This is a filled example for the `frontend-vite` variant. It demonstrates the level of specificity expected in generated project docs.

## Product

- Name: Pocket Ledger
- Audience: solo users who want a quiet monthly money overview
- Primary goal: show remaining balance, recent transactions, and pocket allocation status in one page
- Non-goals: bank sync, multi-user teams, accounting exports, investment tracking

## Stack

- React
- TypeScript
- Vite
- Tailwind CSS
- Vitest
- pnpm with exact dependency versions
- source-owned UI primitives in `src/components/ui/`

## Source layout

```text
src/
├── components/
│   ├── ui/                  # Button, Card, Input, Label
│   └── modules/
│       └── dashboard/       # dashboard summary/list components
├── hooks/                   # owner-local stateful behavior
├── lib/
│   └── utils.ts             # cn()
├── services/                # add only when API exists
├── types/                   # domain types when API/data shape exists
├── App.tsx
├── main.tsx
└── index.css
```

## UI direction

- calm finance app
- flat surfaces
- restrained borders
- primary action uses brand accent only where needed
- no decorative metric wall
- use `tailwind-variants` for component-owned variants
- use explicit labels in forms

## Current screens

- Dashboard overview
- Add transaction form
- Wallet pockets panel
- Recent activity list

## Validation

Use `docs/development-commands.md` as source of truth.

Before claiming a UI change is finished, run the app and check mobile/desktop layout manually.
