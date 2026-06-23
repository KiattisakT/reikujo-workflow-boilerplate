# Coding Style

This file should be adapted per project. Until then, use these defaults.

## General

- Prefer clear, boring structure over clever abstractions.
- Preserve existing behavior during refactors.
- Follow local patterns before importing external best practices.
- Keep naming consistent with the surrounding code.
- Avoid dead placeholder actions in UI or scripts.

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

## Docs

- Label assumptions clearly.
- Put product/business/UX docs in `docs/`.
- Keep implementation docs close to real commands and code paths.
