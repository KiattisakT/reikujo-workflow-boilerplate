# Agent Instructions

This project follows the Reikujo workflow: repo reality first, plan before implementation, preserve behavior, validate changes, and leave clean handoff notes.

## Operating rules

1. Read this file before editing.
2. Read `docs/project-brief.md`, `docs/workflow.md`, and `docs/validation.md` before starting non-trivial work.
3. Do not assume a framework, package manager, architecture, or deployment target. Verify from files first.
4. Keep changes scoped to the requested task.
5. Preserve existing business logic and conditions during refactors unless explicitly asked to change them.
6. Prefer small, reviewable changes over broad rewrites.
7. Run the relevant validation commands from `docs/validation.md` before claiming completion.
8. Update docs or handoff notes when the next agent/person would otherwise lose context.

## Workflow shorthand

- `ccc` — inspect/understand the current codebase first.
- `nnn` — plan before implementation.
- `lll` — report latest status: done, touched files, validation, blockers, next step.
- `rrr` — retrospective: what changed, lessons, remaining work.
- `gogogo` / `ต่อเลย` / `ลงมือได้` — execute the agreed plan.

## Task lifecycle

1. Explore repo reality.
2. Identify constraints and existing patterns.
3. Write or state a concise plan.
4. Implement in scoped steps.
5. Validate with project commands.
6. Report concrete status and propose the next step.

## Documentation map

- `docs/project-brief.md` — product/project purpose and scope.
- `docs/workflow.md` — collaboration and implementation process.
- `docs/coding-style.md` — project coding conventions.
- `docs/validation.md` — commands and quality gates.
- `docs/decisions.md` — architectural/product decisions.
- `docs/handoff.md` — current state and next work.

## Agent state

`.agent-state/` is local workflow memory. Do not commit sensitive data.

- `.agent-state/learn/` — external repo learning notes.
- `.agent-state/memory/` — local project memory notes.
- `.agent-state/tasks/` — task plans and progress.
- `.agent-state/handoffs/` — session handoffs.
