# Roadmap

This roadmap keeps Reikujo focused: start as a workflow base, then grow into stack-specific variants only when the base is stable.

## v0 — Workflow base

Status: current

Goal: provide a clean, framework-agnostic starting point for agent-assisted projects.

Included:

- `AGENTS.md` operating rules
- docs-first structure
- Mahiro Style fallback guidance
- task lifecycle documentation
- reusable templates
- baseline scripts
- `.agent-state` directory placeholders

## v0.1 — Usability pass

Goal: make the boilerplate easier to copy, initialize, and adapt.

Status: in progress

Included:

- `reikujo.json` project/workflow manifest
- richer `init-project.sh` with variant, package manager, and optional git init
- project start checklist
- release checklist

Remaining:

- improve `init-project.sh` so it can replace more project placeholders
- add examples of filled docs
- add optional GitHub issue/PR templates

## v0.2 — Agent workflow hardening

Goal: make multi-agent work safer and easier to resume.

Planned:

- stronger `.agent-state/tasks/` conventions
- handoff examples for partial implementation work
- learn-doc conventions for external repos
- reusable status report template for `lll`
- retrospective template for `rrr`

## v0.3 — Landing site

Goal: present Reikujo clearly as a workflow system while keeping site dependencies isolated from the root boilerplate.

Planned:

- Astro static landing site in `site/`
- landing page copy/spec in `docs/landing-page.md`
- visual QA pass for mobile and desktop
- deployment note for GitHub Pages or another static host

## v1 — Stable base template

Goal: the base template is stable enough to use for real projects without rethinking the workflow each time.

Acceptance:

- docs are coherent and non-overlapping
- scripts are safe and useful
- agent instructions are clear but not overbearing
- validation baseline catches missing workflow files
- no framework assumptions leak into the base

## Future variants

Create these only after v1 is stable.

### reikujo-frontend-vite

Status: first variant started in this repo as `frontend-vite`.

For React/Vite frontend projects.

Possible defaults:

- pnpm
- React + TypeScript
- Tailwind/shadcn-style UI conventions
- Vitest/Playwright validation docs
- frontend design workflow docs

### reikujo-next-app

For Next.js app projects.

Possible defaults:

- App Router conventions
- server/client boundary notes
- env and deployment checklist
- e2e smoke test baseline

### reikujo-docs-only

For product planning, research, and documentation-heavy projects.

Possible defaults:

- PRD template
- owner questions
- decision records
- research notes
- scope tracker

### reikujo-agent-workspace

For projects where agent workflow is the product or the primary development method.

Possible defaults:

- stronger `.agent-state` conventions
- learn/handoff automation
- local mod/statusline notes
- multi-agent task partitioning docs

## Non-goals

- Do not turn the base into a framework starter.
- Do not add heavy dependencies to the base.
- Do not encode one project’s business logic as a universal rule.
- Do not make agents follow ceremony when a task is small.
