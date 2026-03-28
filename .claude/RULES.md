# Rules for AI agents working on papilov.org

Read this file at the START of every session. No exceptions.

## Hard constraints

### Never do without explicit request:
- Create new articles or pages
- Change any number, date, percentage, or dollar amount in existing content
- Change fonts, colors, layout, or visual design
- Add new dependencies (fonts, JS libraries, npm packages)
- Create CI/CD pipelines, GitHub Actions, or test suites
- Restructure content (e.g. move infographics inline, convert tables to cards)

### Never do at all:
- "Factcheck" by replacing one training-data number with another training-data number. If asked to factcheck, use web search for EVERY claim. If you cannot verify a number via web search, flag it — do not change it.
- Push to main without completing the full verification checklist (see verification.md)
- Make multiple rapid commits without individual verification
- Commit with message "fix: correct factual errors" when source is training data

### Factual content rules:
- Every number in an article must have a source URL or be flagged as "unverified — from author's domain expertise"
- When asked to factcheck: search the web, cite the source URL, present old→new with source. Author approves before any change lands.
- Translations must match the source language article. If source changes, all translations change in the same commit.

### Deployment rules:
- After CSS/template changes: visually verify in browser (both themes) before pushing
- After pushing: wait for CF Pages build, purge cache, verify live site
- Stub translations (<30% of source article length) must have `draft: true`

## When in doubt

Ask. A 10-second question is better than a 30-commit cleanup.

## Session protocol

1. Read this file + verification.md + HANDOFF.md at session start
2. At session end, update HANDOFF.md with what you did
3. If you created/changed content with unverified facts, list them in HANDOFF.md § Unverified claims
