# Design System v3 — Editorial Minimal, Multilingual

## Changes (March 2026)

### v3 — Soft palette + multilingual + inline data viz
- Light theme: warm paper (#faf9f7) instead of bleach white (#ffffff)
- Dark theme: warm charcoal (#1c1b1a) instead of pitch black (#111111)
- All color values warmed — less eye strain on phones
- Three languages: English (default), Russian (/ru/), Spanish (/es/)
- Infographic converted from iframe to inline HTML using site CSS variables
- Data viz elements auto-adapt to light/dark theme

### v2 — Editorial minimal
- Replaced dark-only startup aesthetic with editorial/academic design
- Added light/dark toggle with system preference detection
- Monochrome palette, typography-driven hierarchy

## Theme System

CSS variable cascade: `:root` = light, `[data-theme="dark"]` = explicit dark, `@media prefers-color-scheme: dark` = system dark. Inline script in `<head>` prevents flash.

## Multilingual System

Hugo filename-based: `index.en.md`, `index.ru.md`, `index.es.md`. English at root, others at `/ru/`, `/es/`. i18n strings in `/i18n/*.yaml`. Template uses `{{ i18n "key" }}` for UI strings. `hreflang` tags auto-generated.

## Inline Data Visualization Classes

CSS classes for article data viz that auto-adapt to theme:
- `.metrics` / `.metric` — key stat grid
- `.bars` / `.bar-row` — horizontal bar chart
- `.compare` / `.compare-col` — two-column comparison
- `.case-box` — case study container
- `.psych-grid` / `.psych-card` — psychology insight cards
- `.fw-grid` / `.fw-card` — framework model cards
- `.timeline` / `.tl-item` — vertical timeline

All use CSS variables. No hardcoded colors.
