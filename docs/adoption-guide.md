# Adoption Guide

Use this guide when adopting Reikujo in a real project.

Reikujo is a workflow base. It should give a project durable agent rules, docs, validation habits, and handoff structure. It should not force a framework or business architecture onto a project that already has one.

## Choose the adoption path

### New project

Use this when the project does not exist yet or can start from a clean folder.

```bash
rsync -a --exclude .git --exclude .letta reikujo-workflow-boilerplate/ my-new-project/
cd my-new-project
./scripts/init-project.sh "My New Project" --package-manager pnpm --git
```

Then edit:

- `reikujo.json`
- `README.md`
- `docs/project-brief.md`
- `docs/validation.md`
- `docs/decisions.md`
- `AGENTS.md`
- `docs/todo.md`

### Existing repository

Use this when a real codebase already exists.

Copy only workflow files that help the repo:

```text
AGENTS.md
docs/
templates/
scripts/
reikujo.json
.agent-state/**/.gitkeep
```

Do not blindly overwrite an existing repo's:

- `README.md`
- `AGENTS.md`
- package manager files
- lint/build/test config
- app source layout
- CI/CD config

Instead, merge the useful sections manually and preserve repo reality.

## Choose a variant

### Base only

Use base Reikujo when the stack is not decided yet.

Run:

```bash
./scripts/check.sh
```

### frontend-vite

Use `frontend-vite` when the project should start as a React/Vite frontend app.

```bash
./scripts/init-project.sh "My Frontend App" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps
```

Then run:

```bash
./scripts/test-frontend-vite-smoke.sh
```

The generated app gets:

- React + TypeScript + Vite
- Tailwind CSS through the Vite plugin
- Vitest baseline
- `@/*` alias
- `src/lib/utils.ts` with `cn()`
- source-owned UI primitives
- Mahiro-style `tailwind-variants`
- example module, hook, service, type, and query-state templates
- app-local docs in `app/docs/`

## After adoption checklist

- [ ] Update project name and metadata in `reikujo.json`.
- [ ] Rewrite `docs/project-brief.md` for the actual product.
- [ ] Replace generic validation examples with real commands in `docs/validation.md`.
- [ ] Update `AGENTS.md` with project-specific rules and gotchas.
- [ ] Delete or rewrite docs that do not match the project.
- [ ] Update `docs/todo.md` with current/next work.
- [ ] Run `./scripts/check.sh`.
- [ ] Run variant smoke tests if a variant was scaffolded.

## What not to commit

Do not commit:

- secrets or `.env` files
- generated caches
- `node_modules/`
- build outputs
- local external source symlinks
- local agent scratch files that are not intended as durable handoff

Commit:

- docs and rules that future agents should read
- scripts that are safe to run repeatedly
- templates that are intentionally reusable
- `.agent-state/**/.gitkeep` placeholders
- handoff/task docs when they are useful durable project history

## Dry-run recommendation

Before using Reikujo as the base for an important project, do a real dry run in a temporary folder:

```bash
mkdir -p /tmp/reikujo-adoption-test
rsync -a --exclude .git --exclude .letta reikujo-workflow-boilerplate/ /tmp/reikujo-adoption-test/
cd /tmp/reikujo-adoption-test
./scripts/init-project.sh "Adoption Test" --variant frontend-vite --package-manager pnpm --git
./scripts/scaffold-frontend-vite.sh app
./scripts/copy-frontend-base-components.sh app --install-deps
./scripts/check.sh
./scripts/test-frontend-vite-smoke.sh
```

Review:

- Is the generated app too noisy?
- Are docs understandable without extra context?
- Are TODOs obvious?
- Are commands accurate?
- Does the generated structure feel easy to continue?

Fix Reikujo before using it broadly if the dry run feels confusing.
