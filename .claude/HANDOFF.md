# Handoff log — papilov.org

This file is the coordination protocol between Claude Code sessions and Claude chat sessions.

**Claude Code:** Update this file at the END of every session before your last commit.
**Claude chat:** Read this file at the START of every session involving papilov.org.

---

## Last session

**Date:** 2026-03-28
**Agent:** Claude chat (papilov.org project)
**What was done:**
- Reverted all "factcheck corrections" from 2026-03-27 Claude Code sessions (subscription-pricing: CPI, WoW inflation, MoviePass, EVE freeze, Prime spend, cancellation stat; prebid: publisher share, MFA, PMP, supply chain losses, Texas settlement, Future plc attribution) — across EN + all translations
- Set auction-mechanics RU/DE/ES/ZH stubs to `draft: true`
- Created `.claude/RULES.md` (hard constraints for AI agents)
- Created this file (`.claude/HANDOFF.md`)

**What was NOT done:**
- Prebid and auction articles were NOT factchecked via web search — all numbers remain from Claude Code's training data and need human/web verification before the site is promoted
- Ads-cft DE/ZH are ~58% of EN length — functional but incomplete
- Design v5 (Inter font, per-article accents, drop caps) was kept as-is — not visually verified in browser on both themes
- No CF cache purge yet (will happen on deploy)

## Unverified claims

### prebid-js-explainer (ALL languages)
- "$595B programmatic market (2024)" — needs source
- "10,000+ companies use Prebid" — needs source
- "84% of top 10K US sites" — needs source, possibly stale (2022)
- "€2.95B EU fine" — HIGH RISK: may conflate Google Shopping 2017 fine with adtech case
- "$26.8B annual supply chain losses" — needs derivation
- "Google found guilty April 2025" — verify timeline
- All ANA study numbers (47.1% publisher share, 0.8% MFA, 87.8% PMP) — from training data

### auction-mechanics (EN only, translations are draft)
- "NZ$250M expected vs NZ$36M actual" — likely correct but verify
- "$81B C-band auction" — verify
- "€245B EU ETS since 2013" — verify
- "599M allowances sold in 2024" — LOW confidence
- "voice.com sold for $30M" — verify
- "$23T+ US debt" — stale, needs update

### subscription-pricing-models (ALL languages)
- Original numbers restored. These were previously verified by human author — considered baseline-trusted but a web-search pass would still improve confidence.

## Pending work
- Full factcheck of prebid + auction via web search
- Expand auction translations (RU/DE/ES/ZH) to match EN, then remove `draft: true`
- Expand ads-cft DE/ZH to match EN
- Visually verify design v5 on both themes, all breakpoints
- Verify SVG diagrams render correctly in dark mode across articles
