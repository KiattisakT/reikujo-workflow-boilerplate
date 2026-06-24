# frontend-vite Agent Add-on

Apply this add-on only when `reikujo.json` uses `workflow.variant = "frontend-vite"` or the project explicitly adopts this variant.

## Package manager

Use `pnpm` unless the project proves otherwise.

## Expected frontend checks

Run from `app/` unless the project documents a different app root:

```bash
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

Add Playwright/e2e or screenshot checks for layout-sensitive UI work.

## Implementation posture

- React components should stay owner-focused and readable.
- Use local UI primitives before raw one-off controls when primitives exist.
- Prefer explicit labels over placeholder-only forms.
- Keep route/page files as orchestration boundaries.
- Do not introduce shared components before reuse or ownership justifies them.
- Do not treat passing `pnpm build` as visual validation.
