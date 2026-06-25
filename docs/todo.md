# TODO

This file is the active project checklist for Reikujo. Keep it updated after each work chunk so the next step is visible without asking.

Legend:

- `[x]` done
- `[~]` in progress / partially done
- `[ ]` not started

## Current baseline

- [x] Create Reikujo workflow boilerplate repository.
- [x] Add `AGENTS.md`, base docs, templates, scripts, and `reikujo.json`.
- [x] Push repository to `github.com:KiattisakT/reikujo-workflow-boilerplate`.
- [x] Add `frontend-vite` variant docs and scaffold helper.
- [x] Add source-owned base components under `variants/frontend-vite/templates/src/components/ui/`.
- [x] Enforce exact dependency versions with `.npmrc` / `pnpm add -E`.
- [x] Configure frontend-vite scaffold with Tailwind CSS, TypeScript, Vitest, `@/*` alias, and `cn()`.
- [x] Switch Mahiro-style primitives from `cva` to `tailwind-variants`.
- [x] Add optional `tubelight-navbar` template/demo.
- [x] Add Mahiro reference docs from Eizypay patterns.
- [x] Add portable component and hook pattern docs.
- [x] Add `scripts/test-frontend-vite-smoke.sh` end-to-end smoke test.
- [x] Remove isolated landing site experiment.

## Next recommended work

### 1. Complete Mahiro pattern docs

- [x] Add `docs/patterns/services-pattern.md`.
  - Cover service ownership, static methods, typed payload/response, endpoint naming, fallback/error behavior.
  - Make clear that components/hooks should not bypass services for API calls.
- [x] Add `docs/patterns/query-state-pattern.md`.
  - Cover loading/error/empty/data rendering.
  - Document the future `QueryStateDefault`-style direction without forcing React Query into every project.
- [x] Link new pattern docs from `README.md`, `docs/usage.md`, and `docs/mahiro-reference.md`.

### 2. Improve generated project docs

- [x] Add generated docs templates for frontend projects:
  - `docs/project-overview.md`
  - `docs/development-commands.md`
  - `docs/file-organization.md`
  - `docs/styling.md`
- [x] Decide whether `scaffold-frontend-vite.sh` should copy those docs automatically or only document them as optional.
  - Decision: copy them automatically into generated `app/docs/` because they are lightweight and app-local.
- [x] Add examples of filled docs for a small frontend project.

### 3. Strengthen frontend-vite templates

- [ ] Add a service example template only after `services-pattern.md` is written.
- [ ] Add a query-state/example-loading template only after `query-state-pattern.md` is written.
- [ ] Add a simple form example that uses `Label`, `Input`, `Button`, and explicit helper/error copy.
- [ ] Decide whether `tubelight-navbar` should remain in the base copy helper or move to an optional animation pack.

### 4. Improve scripts and validation

- [ ] Make `scripts/check.sh` optionally run variant smoke tests via a flag, e.g. `./scripts/check.sh --with-variants`.
- [ ] Add a lighter docs-only check for links/references if the repo stays documentation-heavy.
- [ ] Keep `./scripts/test-frontend-vite-smoke.sh` as the required check after scaffold/template/dependency changes.

### 5. Roadmap cleanup

- [ ] Update `docs/roadmap.md` so completed frontend-vite/Mahiro work is reflected accurately.
- [ ] Revisit v0.1/v0.2 statuses after services/query-state docs land.
- [ ] Decide the next variant only after `frontend-vite` is stable.

## Later / optional

- [ ] Add `frontend-next` variant.
- [ ] Add docs-only variant templates.
- [ ] Add GitHub issue/PR templates.
- [ ] Add handoff examples for partial implementation work.
- [ ] Add `lll` status report template.
- [ ] Add `rrr` retrospective template.

## Validation checklist for future changes

For docs-only changes:

```bash
./scripts/check.sh
bash -n scripts/*.sh
```

For frontend-vite scaffold/template/dependency changes:

```bash
./scripts/check.sh
bash -n scripts/*.sh
./scripts/test-frontend-vite-smoke.sh
ccc index
```
