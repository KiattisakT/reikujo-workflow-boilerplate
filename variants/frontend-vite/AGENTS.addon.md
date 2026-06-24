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
- Base primitives should follow the source-owned `shadcn-ui/ui` writing pattern: `components/ui`, `cn()`, `cva`, typed variants, `data-slot`, and domain wrappers above primitives.
- Prefer Radix UI primitives for new headless UI needs. Use Base UI only when the project explicitly chooses it or already uses it.
- Do not run shadcn CLI or install generated component packs unless the human explicitly asks.
- Prefer explicit labels over placeholder-only forms.
- Keep route/page files as orchestration boundaries.
- Do not introduce shared components before reuse or ownership justifies them.
- Do not treat passing `pnpm build` as visual validation.
