# Usage Guide

Use Reikujo as the first layer of a new project: workflow, docs, agent rules, and handoff structure before framework decisions.

For real project adoption, read `docs/adoption-guide.md` first.

## Start a new project

```bash
rsync -a --exclude .git --exclude .letta reikujo-workflow-boilerplate/ my-new-project/
cd my-new-project
./scripts/init-project.sh "My New Project" --package-manager pnpm --git
```

Then update the project-specific files:

1. `reikujo.json` — project metadata, workflow version, variant, and package manager.
2. `docs/project-brief.md` — what this project is and is not.
3. `docs/validation.md` — the real commands for quality checks.
4. `docs/coding-style.md` — local conventions once the stack exists.
5. `AGENTS.md` — project-specific instructions and gotchas.
6. `README.md` — public/user-facing overview.

Optional portable pattern docs live in `docs/patterns/`. Copy only the files that match the generated project's scope.

Useful init variants:

```bash
./scripts/init-project.sh "Docs Project" --variant docs-only
./scripts/init-project.sh "Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/init-project.sh "Agent Workspace" --variant agent-workspace --package-manager project-defined
```

For frontend variants, package installs should be exact:

```bash
pnpm add -E <package>
pnpm add -D -E <package>
```

## Use during daily work

### Explore

Use `ccc` when the codebase is unfamiliar or when the task could touch multiple areas.

Expected output:

- current architecture reality
- relevant files
- existing patterns
- risks and constraints

### Plan

Use `nnn` before non-trivial implementation.

Good plans include:

- goal
- scope
- likely files
- implementation steps
- validation
- open decisions

For larger tasks, copy `templates/task-plan.md` into `.agent-state/tasks/`.

### Implement

Use `gogogo`, `ต่อเลย`, or `ลงมือได้` after the plan is accepted.

Implementation rules:

- keep changes scoped
- preserve existing behavior during refactors
- follow local patterns first
- avoid adding a framework or dependency unless the project asks for it

### Validate

Run the commands listed in `docs/validation.md`.

Always report:

- command run
- pass/fail
- important error output if failed
- what was not validated

### Handoff

Create a handoff when stopping mid-stream or when context will reset:

```bash
./scripts/handoff.sh
```

Then fill the generated file in `.agent-state/handoffs/`.

## What to commit

Commit the reusable workflow files:

- `AGENTS.md`
- `README.md`
- `docs/`
- `templates/`
- `scripts/`
- `reikujo.json`
- `.agent-state/**/.gitkeep`

Do not commit local runtime files, secrets, generated caches, or external source symlinks.

## When to create a variant

Create a variant when the workflow needs stack-specific defaults.

Examples:

- `reikujo-frontend-vite` — Vite/React/Tailwind app baseline.
- `reikujo-next-app` — Next.js app baseline.
- `reikujo-docs-only` — documentation/research project baseline.
- `reikujo-agent-workspace` — agent-heavy workspace with stronger `.agent-state` conventions.

## Included variants

### frontend-vite

```bash
./scripts/init-project.sh "My Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps
```

Read:

- `docs/variants/frontend-vite.md`
- `variants/frontend-vite/README.md`
- `variants/frontend-vite/AGENTS.addon.md`
- `variants/frontend-vite/docs/base-components.md`
- `variants/frontend-vite/docs/mahiro-component-profile.md`
- `docs/patterns/component-conventions.md`
- `docs/patterns/hooks-pattern.md`
- `docs/patterns/services-pattern.md`
- `docs/patterns/query-state-pattern.md`

Filled docs example:

- `examples/frontend-vite/docs/project-overview.md`
- `examples/frontend-vite/docs/development-commands.md`
- `examples/frontend-vite/docs/file-organization.md`
- `examples/frontend-vite/docs/styling.md`

Runnable example app:

- `examples/frontend-vite/basic-app/`

Validate it with:

```bash
./scripts/test-frontend-vite-example.sh
```
