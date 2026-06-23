# reikujo-workflow-boilerplate

A personal workflow boilerplate for agent-assisted projects.

This repo is not a framework starter. It is a working base for how a project should be explored, planned, implemented, validated, and handed off when humans and coding agents collaborate.

## What this gives you

- Project-local agent rules in `AGENTS.md`
- Docs-first workflow structure under `docs/`
- Reusable templates under `templates/`
- Local agent state folders under `.agent-state/`
- Simple scripts for checks, initialization, and handoff notes
- A default task lifecycle: explore → plan → implement → validate → handoff

## Quick start

```bash
cp -R reikujo-workflow-boilerplate my-new-project
cd my-new-project
./scripts/init-project.sh "My New Project"
```

Then fill in:

1. `docs/project-brief.md`
2. `docs/workflow.md`
3. `docs/validation.md`
4. `docs/decisions.md`
5. `AGENTS.md`

## Intended usage

Use this as the base layer before choosing a tech stack.

Later variants can extend it:

- `reikujo-frontend-vite`
- `reikujo-next-app`
- `reikujo-docs-only`
- `reikujo-fullstack-app`
- `reikujo-agent-workspace`

## Core commands

```bash
./scripts/check.sh
./scripts/handoff.sh
```

These scripts are intentionally small. Each real project should adapt them to its own package manager, build tools, test commands, and deployment flow.
