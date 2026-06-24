# Project Start Checklist

Use this checklist when creating a new project from Reikujo.

## 1. Initialize

- [ ] Copy the boilerplate without local runtime state.
- [ ] Run `./scripts/init-project.sh "Project Name"`.
- [ ] Confirm `reikujo.json` has the right project name, variant, and package manager.
- [ ] Decide whether to initialize git now or after first project-specific edits.

## 2. Fill project context

- [ ] Complete `docs/project-brief.md`.
- [ ] Add real commands to `docs/validation.md`.
- [ ] Update `docs/coding-style.md` with stack-specific rules.
- [ ] Update `AGENTS.md` with project-specific gotchas.
- [ ] Record early decisions in `docs/decisions.md`.

## 3. Establish workflow

- [ ] Confirm shorthand meanings: `ccc`, `nnn`, `lll`, `rrr`, `gogogo`.
- [ ] Decide what belongs in `.agent-state/` and what stays out of git.
- [ ] Add any project-local semantic search/index rules.
- [ ] Add a handoff note if setup work pauses before implementation.

## 4. Validate the base

```bash
./scripts/check.sh
```

- [ ] Baseline check passes.
- [ ] Missing project-specific validation is documented clearly.

## 5. First implementation readiness

- [ ] Tech stack is chosen or explicitly deferred.
- [ ] Product scope is clear enough for the first task.
- [ ] Non-goals are written down.
- [ ] Open questions are visible.
- [ ] Next task has a small plan.
