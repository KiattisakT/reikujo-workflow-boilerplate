# Landing Page Plan

## Goal

Create a static landing page for Reikujo that explains the project as a workflow system for agent-assisted projects, not a generic framework starter.

## Placement

The landing page lives in `site/` so the root repository stays a workflow boilerplate.

```text
site/
├── package.json
├── astro.config.mjs
├── src/pages/index.astro
├── src/styles/global.css
└── public/
```

## Message

Reikujo is a reusable workflow base for projects built with humans and coding agents.

It provides:

- repo-local agent rules
- docs-first project memory
- task lifecycle: explore → plan → implement → validate → handoff
- Mahiro Style as a fallback implementation/review lens
- frontend-vite variant for React/Vite apps
- source-owned shadcn-style base components
- exact package install policy

## Site posture

The landing page should feel closer to a component/workflow catalog like React Bits than a normal marketing page.

That means:

- show the actual "bits" Reikujo gives a project
- include component previews and source snippets
- make workflow pieces feel browsable
- keep every example static and framework-light inside Astro
- avoid turning the site into a runtime component playground until there is a clear need

## Visual direction

High-end editorial technical landing page.

- dark graphite / warm paper contrast
- premium self-hosted typography: Space Grotesk for display, Geist for body, Geist Mono for code
- large whitespace
- asymmetric bento layout
- double-bezel cards
- floating island nav
- source-code inspired details without looking like a generic developer template

## Sections

1. Hero — Reikujo Workflow Boilerplate, one sentence, GitHub/start CTAs.
2. What it is — workflow base, not a framework starter.
3. Workflow loop — explore, plan, implement, validate, handoff.
4. Mahiro Style — repo reality first, ownership-first code, product-specific restraint.
5. frontend-vite — React/Vite, Radix-first primitives, source-owned components, exact versions.
6. Bits gallery — show workflow docs, scripts, templates, and frontend primitives as browsable blocks.
7. Component examples — show source-owned Button/Card/Input/Label pattern and the difference between primitive and domain wrapper.
8. Start commands — copy/init/scaffold/copy base components.
9. Footer — GitHub and current version.

## Non-goals

- Do not turn the root boilerplate into a web app.
- Do not make the site own project workflow logic.
- Do not add backend, CMS, auth, or dynamic app behavior.
- Do not install shadcn/ui for the landing page.
