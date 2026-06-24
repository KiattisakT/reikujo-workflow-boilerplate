# Release Checklist

Use this checklist before tagging or publishing a Reikujo boilerplate release.

## Docs

- [ ] `README.md` explains the current workflow clearly.
- [ ] `docs/usage.md` matches the scripts.
- [ ] `docs/roadmap.md` reflects completed and planned work.
- [ ] `docs/mahiro-style.md` remains fallback guidance, not forced current reality.
- [ ] Templates are still generic enough for new projects.

## Scripts

- [ ] `./scripts/check.sh` passes.
- [ ] `./scripts/init-project.sh "Example Project"` works in a throwaway copy.
- [ ] `./scripts/handoff.sh` creates a handoff file under `.agent-state/handoffs/`.
- [ ] Scripts do not require project-specific dependencies.

## Git hygiene

- [ ] `.letta/` and local runtime files are ignored.
- [ ] `.agent-state/**/.gitkeep` placeholders are tracked.
- [ ] `.agent-state/learn/**/origin` symlinks are ignored.
- [ ] No secrets, environment files, generated caches, or external source clones are staged.

## Versioning

- [ ] `reikujo.json` workflow version is updated.
- [ ] `docs/decisions.md` records meaningful workflow changes.
- [ ] Release notes summarize user-visible changes.

## Final validation

```bash
./scripts/check.sh
git status --short
```

- [ ] Check passes.
- [ ] Git status contains only intentional release changes.
