# Mahiro Style

Mahiro Style is the preferred implementation and review lens for Reikujo projects when the target repo has not already decided a stronger local rule.

It is not a blind override. Project reality still wins first.

## Precedence

Use this winner order for every style, structure, and review decision:

1. `AGENTS.md`
2. Other repo-local instruction files, such as `CLAUDE.md`
3. Established repo patterns
4. Mahiro Style fallback

If a local rule conflicts with Mahiro Style, the local rule wins.

## Truth labels

Use these labels when writing docs, plans, reviews, or migration notes:

- **Current Reality** — proven by this repo's docs, config, scripts, imports, or repeated code patterns.
- **Preferred Direction** — Mahiro Style fallback for new work when repo reality is silent or drifting.
- **Not Established Yet** — a layer or pattern the repo has not earned.
- **Adoption Triggers** — concrete conditions that justify introducing the preferred shape later.

Do not describe Mahiro preference as Current Reality unless the repo proves it.

## Code style defaults

When the repo is silent, prefer:

- formatter-led consistency over manual formatting arguments
- 2-space indentation for TypeScript, JavaScript, JSON, Markdown, and config
- single quotes in TypeScript/JavaScript unless tooling says otherwise
- no semicolons unless tooling requires them
- readable line width around 100-120 characters
- `import type` for type-only imports when supported
- named exports for reusable components, hooks, services, stores, constants, and utilities
- colocated local contracts until reuse creates a clearer owner

Do not add formatter configs, path aliases, barrels, or lint rules just to satisfy taste.

## Project structure defaults

Mahiro Style prefers ownership-first structure.

The core question is not "how do we make this file smaller?" The question is:

> Which owner makes the next edit easier to find, understand, and validate?

Common ownership homes when the repo has earned them:

- routes / pages — URL, loader/action, layout, orchestration
- components — renderable UI and domain sections
- hooks — reusable stateful behavior, query/mutation wiring
- services — transport, backend operations, request/response shaping
- stores — long-lived client state
- constants — shared runtime value lists and stable maps
- types — shared API/domain contracts
- providers — app-wide composition and context
- utils/libs — focused helpers or configured clients, not vague dumping grounds

Add a folder only when the ownership exists. Do not copy a tree from another project as ceremony.

## Extraction rules

Prefer extraction that improves ownership, searchability, naming, and reviewability together.

Good extraction:

- keeps route/page files thin and orchestration-focused
- moves transport to services or established transport owners
- moves reusable query/mutation logic to hooks only when reuse or clarity exists
- keeps one-owner data/config close to the owning component or module
- promotes types/constants only when multiple owners need the same contract

Bad extraction:

- makes a large file smaller but ownership more confusing
- creates generic `utils`, `helpers`, `data`, or `config` buckets without domain meaning
- moves route-local state into a hook only to reduce line count
- promotes one-off UI into shared primitives before reuse exists
- adds wrapper layers that do not own layout, semantics, state, accessibility, or a real boundary

## Naming

Names should reveal domain meaning.

Prefer:

- `OrderFilterForm` over `FilterForm` when exported outside the order module
- `customerRows` over `data`
- `invoiceStatusOptions` over `options`
- `ICreateInviteParams` over `IParams`

Avoid vague names when the business concept is known: `data`, `items`, `list`, `meta`, `config`, `helper`, `common`.

## UI style and product feel

Mahiro Style is restrained and product-specific.

Prefer:

- local UI primitives first
- shallow, explicit structure
- copy that helps the next user action
- spacing and density that match the product tone
- owner-local styling over fragile descendant overrides

Avoid:

- generic AI dashboard polish
- decorative metric-card walls
- fake-premium gradients
- pill overload
- gratuitous motion
- verbose helper copy that explains implementation instead of helping the user act

Refactors must preserve product feel. A structurally cleaner screen that becomes louder, heavier, or less intentional is still a regression.

## Review checklist

When reviewing a change, ask:

1. Which rule source wins here: local docs, repeated repo pattern, or Mahiro fallback?
2. Did the change preserve behavior and business conditions?
3. Did ownership become clearer, or did code just move?
4. Are route/page files still orchestration-focused?
5. Are services, hooks, stores, constants, and types owned by the right layer?
6. Did naming become more domain-specific?
7. Did UI structure earn every wrapper/component layer?
8. Did the product feel survive the refactor?
9. Was validation run with the repo's real commands?

## Adoption triggers

Introduce stronger Mahiro-shaped structure when:

- the same contract is imported by multiple owners
- route/page files mix orchestration, rendering, config, types, and transport
- repeated query/mutation behavior needs a shared owner
- generic naming starts hurting search and review
- UI primitives begin carrying domain business rules
- formatter/style drift creates review noise
- handoffs repeatedly lose the same context

Until then, keep the base lean.
