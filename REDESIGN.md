# Design System v4 — Newsreader Editorial

## Changes (March 2026)

### v4 — Dario-inspired editorial redesign
- Body font: Newsreader (optical-size serif) replaces DM Sans (sans-serif) + Source Serif 4 (headings)
- Single font family for everything: Newsreader 400/500/600/700 + italic
- Base font-size: 19px (was 17px), line-height: 1.75
- Homepage: text-first layout with expandable bio + bullet-list research links (no cards, no badges, no tags)
- Header: name + nav left, theme toggle right; language switcher moved to footer
- Selection color: blue tint (matching darioamodei.com) instead of solid beige
- Removed status badges from homepage
- Research section on homepage: simple "Title (Year)" bullet list

### v3 — Soft palette + multilingual + inline data viz
- Light theme: warm paper (#faf9f7) instead of bleach white (#ffffff)
- Dark theme: warm charcoal (#1c1b1a) instead of pitch black (#111111)
- All color values warmed — less eye strain on phones
- Five languages: EN, RU, ES, DE, ZH
- Infographic converted from iframe to inline HTML using site CSS variables
- Data viz elements auto-adapt to light/dark theme

### v2 — Editorial minimal
- Replaced dark-only startup aesthetic with editorial/academic design
- Added light/dark toggle with system preference detection
- Monochrome palette, typography-driven hierarchy

## Theme System

CSS variable cascade: `:root` = light, `[data-theme="dark"]` = explicit dark, `@media prefers-color-scheme: dark` = system dark. Inline script in `<head>` prevents flash.

## Font Stack

| Role | Font | Weights |
|------|------|---------|
| Body + headings | Newsreader | 400, 500, 600, 700, 400i, 500i |
| Code/data | JetBrains Mono | 400, 500 |

## Multilingual System

Hugo filename-based: `index.en.md`, `index.ru.md`, `index.es.md`, `index.de.md`, `index.zh.md`. English at root, others at `/ru/`, `/es/`, `/de/`, `/zh/`. i18n strings in `/i18n/*.yaml`. Language switcher in footer.

## Inline Data Visualization Classes

CSS classes for article data viz that auto-adapt to theme:
- `.metrics` / `.metric` — key stat grid
- `.bars` / `.bar-row` — horizontal bar chart
- `.compare` / `.compare-col` — two-column comparison
- `.case-box` — case study container
- `.psych-grid` / `.psych-card` — psychology insight cards
- `.fw-grid` / `.fw-card` — framework model cards
- `.timeline` / `.tl-item` — vertical timeline
- `.highlight-box` — key insight callout

All use CSS variables. No hardcoded colors.
