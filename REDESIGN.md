# Design System v2 — Editorial Minimal

## Context

Redesign applied March 2026. Replaced dark-only startup aesthetic with editorial/academic design.

**Reference points:** NYT, Apple, academic papers. Typography-driven. No decorative elements.

**What changed:**
- Dark-only → light/dark with system preference detection
- Orange/gradient accents → monochrome (black/white + greys)
- Sticky frosted-glass header → simple thin header
- `max-width: 1100px` → `720px` (reading column)
- Decorative elements (gradients, glow, backdrop-filter) → removed entirely
- Font loading: trimmed to only used weights (Playfair 700, DM Sans 400/500/600, JetBrains 400)

## Theme System

1. On load: inline `<script>` in `<head>` reads `localStorage.theme` and sets `data-theme` attribute on `<html>` — prevents flash of wrong theme
2. If no stored preference: CSS `@media (prefers-color-scheme: dark)` takes over via `:root:not([data-theme="light"])` selector
3. Toggle button `◐` in nav calls JS that flips `data-theme` and stores in `localStorage`

**CSS variable cascade:** `:root` = light defaults, `[data-theme="dark"]` = explicit dark, `@media prefers-color-scheme: dark` with `:root:not([data-theme="light"])` = system dark.

## Design Tokens

| Token | Light | Dark |
|-------|-------|------|
| --bg | #ffffff | #111111 |
| --text | #1a1a1a | #e0e0e0 |
| --text-secondary | #555555 | #999999 |
| --text-tertiary | #888888 | #666666 |
| --border | #e0e0e0 | #2a2a2a |
| --link | #1a1a1a | #e0e0e0 |

## Status

- Subscription article marked `in-progress` (was `finished`)
- Infographic still uses the old dark-only design — needs separate update
- Future: consider updating infographic to respect site theme via `prefers-color-scheme` or `postMessage`

## For Claude Code

When making further CSS changes:
- All styles in single file: `themes/cosmos/static/css/main.css`
- Use CSS variables, never hardcode colors
- Both themes must look good — test by toggling `data-theme` attribute
- Container is 720px — keep it narrow for reading
- No decorative CSS (gradients, shadows, noise, blur) — whitespace and typography only
