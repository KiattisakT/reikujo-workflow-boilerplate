# Coding Style

This file should be adapted per project. Until then, use these defaults.

Use `docs/mahiro-style.md` as the preferred fallback when this file or local code is silent. Local formatter, framework, and repeated repo patterns still win first.

## General

- Prefer clear, boring structure over clever abstractions.
- Preserve existing behavior during refactors.
- Follow local patterns before importing external best practices.
- Keep naming consistent with the surrounding code.
- Avoid dead placeholder actions in UI or scripts.
- Choose ownership before extraction. Smaller files are only better when the next edit location becomes clearer.

## TypeScript / JavaScript defaults

- Prefer TypeScript for new app code when the project uses it.
- Prefer small pure helpers for repeated logic.
- Keep IO, validation, and UI concerns separated when practical.
- Avoid broad `any` unless isolating unknown external data.

## UI defaults

- Use existing UI primitives/components.
- Do not create generic SaaS-looking UI by default.
- Use explicit labels for forms.
- Keep mobile and small-width layouts readable.
- Validate visually when layout is the point.
- Preserve product feel during refactors; cleaner structure with worse tone is still a regression.

## Docs

- Label assumptions clearly.
- Put product/business/UX docs in `docs/`.
- Keep implementation docs close to real commands and code paths.
