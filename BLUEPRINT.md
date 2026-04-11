# BLUEPRINT — Build a Research Site Like This One

> **See also:** [Memex blueprint](https://github.com/a-pap/memex) — the persistent memory system that keeps Claude on the same page across every session on this site. Same author, same philosophy (git-native, markdown-first, openly licensed), complementary artifact.

> **What this is:** A complete blueprint for deploying a multilingual, AI-co-authored research site using Hugo + Cloudflare Pages + GitHub. Cost: ~$10/year (domain only). Build time with Claude: one evening.
>
> **What this is NOT:** A step-by-step tutorial. This document is designed to be fed directly to [Claude](https://claude.ai) (or any capable LLM) as a prompt. Give it this file and your domain name — it will build everything.
>
> Live example: [papilov.org](https://papilov.org) · Source: [github.com/a-pap/papilov.org](https://github.com/a-pap/papilov.org)

---

## Architecture

```
You write markdown
    ↓
Hugo generates static HTML (5 languages, dark/light themes, SEO metadata)
    ↓
git push to GitHub (public repo)
    ↓
Cloudflare Pages auto-builds from GitHub
    ↓
Cloudflare edge network serves globally (~320ms TTFB)
    ↓
Your domain via DNS or Worker proxy
```

**Total stack cost:** ~$10/year (domain registration). Everything else is free tier.

**What you get:**
- Static site with near-zero latency (Cloudflare edge)
- Multilingual content (as many languages as you want)
- Light/dark theme with system preference detection
- Academic SEO (Google Scholar, Dublin Core, PRISM, JSON-LD)
- AI discoverability (llms.txt, robots.txt allowing all AI crawlers)
- RSS feeds per language
- Research articles with version tracking, confidence levels, AI disclosure
- Interactive data visualizations (inline HTML, no JavaScript frameworks)
- Citation infrastructure (CITATION.cff, BibTeX)

**What you don't get (by design):**
- No CMS, no admin panel, no database
- No JavaScript frameworks, no build toolchain beyond Hugo
- No comments, no analytics cookies, no tracking
- No subscription paywalls, no ads

---

## For Claude: Deployment Prompt

**If you are Claude (or another LLM) and someone gave you this file — here is what to do.**

The human will provide:
1. Their domain name (e.g., `example.org`)
2. Their name and one-line bio
3. Their GitHub username
4. Their Cloudflare account (or you'll help them create one)
5. What languages they want (default: just English)

You will:
1. Scaffold the Hugo project structure (below)
2. Create the theme with all templates
3. Create the CSS with light/dark themes
4. Set up multilingual config
5. Create SEO infrastructure (head.html, robots.txt, llms.txt, sitemap, etc.)
6. Create starter content (homepage, colophon, one research article)
7. Push to GitHub
8. Guide them through Cloudflare Pages setup (manual — requires dashboard clicks)
9. Set up DNS or Worker proxy

**Do NOT ask clarifying questions for things you can assume.** Use this blueprint's structure as the default. The human will customize later.

---

## File Structure

```
your-site/
├── BLUEPRINT.md               # This file (delete or keep, your call)
├── CITATION.cff               # Machine-readable citation metadata
├── CLAUDE.md                  # Instructions for Claude Code (optional)
├── LICENSE                    # MIT for code
├── README.md                  # Project README
├── hugo.toml                  # Hugo config (languages, menus, params)
├── archetypes/
│   └── default.md             # Default content archetype
├── content/
│   ├── _index.en.md           # Homepage (per language)
│   ├── colophon.en.md         # "How this site works" page
│   ├── work-with-me.en.md     # Optional: consulting/contact page
│   └── research/
│       ├── _index.en.md       # Research listing page
│       └── your-first-article/
│           ├── index.en.md    # Article content
│           └── index.ru.md    # Translation (if multilingual)
├── i18n/
│   ├── en.yaml                # UI strings in English
│   └── ru.yaml                # UI strings per additional language
├── static/
│   ├── _headers               # Cloudflare Pages HTTP headers
│   ├── _redirects             # Cloudflare Pages redirects
│   ├── favicon.svg            # SVG favicon
│   ├── humans.txt             # humans.txt standard
│   ├── robots.txt             # Crawl permissions (open by default)
│   ├── llms.txt               # AI discoverability summary
│   ├── llms-full.txt          # Full content for AI indexing
│   └── img/
│       └── og-default.png     # Open Graph fallback image (1200×630)
└── themes/your-theme/
    ├── hugo.toml              # Theme metadata
    ├── layouts/
    │   ├── _default/
    │   │   ├── baseof.html    # Base template (HTML skeleton)
    │   │   ├── single.html    # Default single page
    │   │   └── list.html      # Default list page
    │   ├── index.html         # Homepage template
    │   ├── 404.html           # 404 page
    │   ├── research/
    │   │   ├── single.html    # Research article template
    │   │   └── list.html      # Research listing template
    │   └── partials/
    │       ├── head.html      # <head> (SEO, fonts, structured data)
    │       ├── header.html    # Site header + navigation
    │       └── footer.html    # Footer + theme toggle + analytics
    ├── static/
    │   └── css/
    │       └── main.css       # All styles (single file)
    └── archetypes/
        └── research.md        # Research article archetype
```

---

## Hugo Configuration (hugo.toml)

This is the core config. Adjust `baseURL`, `title`, language list, and menu items.

```toml
baseURL = "https://YOUR-DOMAIN.org/"
title = "Your Name"
theme = "your-theme"
defaultContentLanguage = "en"
defaultContentLanguageInSubdir = false

[params]
  description = "Your one-line site description for SEO."
  author = "Your Name"
  email = "you@YOUR-DOMAIN.org"
  github = "your-github-username"
  linkedin = "your-linkedin"
  # Cloudflare Web Analytics (free, no cookies, GDPR-compliant)
  # Get token from: Cloudflare dashboard → Web Analytics → Add site
  cfWebAnalyticsToken = ""

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      # REQUIRED: allows raw HTML in markdown (for inline data visualizations)
      unsafe = true
  [markup.highlight]
    style = "monokailight"
    lineNos = false

[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS"]

[services]
  [services.rss]
    limit = 50

# ── LANGUAGES ──
# English at root (/), others at /xx/ prefixes.
# Add or remove language blocks as needed.
# Hugo uses filename-based multilingual: index.en.md, index.ru.md, etc.

[languages]
  [languages.en]
    languageCode = "en"
    languageName = "EN"
    weight = 1
    [languages.en.params]
      description = "Your description in English."
    [[languages.en.menu.main]]
      name = "Research"
      url = "/research/"
      weight = 1
    [[languages.en.menu.main]]
      name = "Colophon"
      url = "/colophon/"
      weight = 2

  # Add more languages by duplicating this block:
  # [languages.ru]
  #   languageCode = "ru"
  #   languageName = "RU"
  #   weight = 2
  #   [[languages.ru.menu.main]]
  #     name = "Исследования"
  #     url = "/ru/research/"
  #     weight = 1

[taxonomies]
  tag = "tags"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"
```

---

## Theme: Templates

### baseof.html — HTML skeleton

Every page extends this. Keep it minimal.

```html
<!DOCTYPE html>
<html lang="{{ .Language.Lang }}">
<head>
  {{ partial "head.html" . }}
</head>
<body>
  {{ partial "header.html" . }}
  <main>
    {{ block "main" . }}{{ end }}
  </main>
  {{ partial "footer.html" . }}
</body>
</html>
```

### _default/single.html — Generic single pages (colophon, etc.)

```html
{{ define "main" }}
<div class="container">
  <h1>{{ .Title }}</h1>
  <div class="article-body">
    {{ .Content }}
  </div>
</div>
{{ end }}
```

### _default/list.html — Generic list pages

```html
{{ define "main" }}
<div class="container">
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
  <article>
    <h2><a href="{{ .Permalink }}">{{ .Title }}</a></h2>
    {{ with .Description }}<p>{{ . }}</p>{{ end }}
  </article>
  {{ end }}
</div>
{{ end }}
```

### head.html — SEO, fonts, structured data

This is the most important template. It handles:
- Basic meta tags + description
- Robots directives (noindex for taxonomy pages — thin content)
- Google Scholar / Highwire Press citation tags (for research pages)
- Dublin Core metadata (for research pages)
- Canonical URLs + hreflang for all translations
- Open Graph + Twitter Cards
- RSS autodiscovery
- Font loading
- JSON-LD structured data (Person + WebSite on home, ScholarlyArticle on research)
- Theme restoration from localStorage (prevents flash)

```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{{ if .IsHome }}{{ .Site.Title }} — {{ .Site.Params.description }}{{ else }}{{ .Title }} — {{ .Site.Title }}{{ end }}</title>
<meta name="description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta name="author" content="{{ .Site.Params.author }}">
{{ if .Params.robots }}<meta name="robots" content="{{ .Params.robots }}">
{{ else if or (eq .Kind "term") (eq .Kind "taxonomy") }}<meta name="robots" content="noindex, follow">
{{ end }}
{{ with .Params.tags }}<meta name="keywords" content="{{ delimit . ", " }}">{{ end }}

<!-- AI discoverability -->
<link rel="ai-agent" href="/llms.txt">
<link rel="alternate" type="text/plain" href="/llms.txt" title="LLM-readable summary">

{{ if and .IsPage (eq .Section "research") }}
<!-- Google Scholar / Highwire Press citation tags -->
<meta name="citation_title" content="{{ .Title }}">
<meta name="citation_author" content="YOUR NAME HERE">
<meta name="citation_publication_date" content="{{ .Date.Format "2006/01/02" }}">
<meta name="citation_online_date" content="{{ .Date.Format "2006/01/02" }}">
<meta name="citation_journal_title" content="YOUR PUBLICATION NAME">
<meta name="citation_language" content="{{ .Language.LanguageCode }}">
<meta name="citation_public_url" content="{{ .Permalink }}">
{{ with .Params.description }}<meta name="citation_abstract" content="{{ . }}">{{ end }}
{{ range .Params.tags }}<meta name="citation_keywords" content="{{ . }}">{{ end }}

<!-- Dublin Core -->
<meta name="DC.title" content="{{ .Title }}">
<meta name="DC.creator" content="YOUR NAME HERE">
<meta name="DC.date" content="{{ .Date.Format "2006-01-02" }}">
<meta name="DC.description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Summary | plainify | truncate 200 }}{{ end }}">
<meta name="DC.language" content="{{ .Language.LanguageCode }}">
<meta name="DC.rights" content="CC BY-NC 4.0">
<meta name="DC.type" content="Text">
<meta name="DC.format" content="text/html">
{{ end }}

<!-- Canonical + hreflang -->
<link rel="canonical" href="{{ .Permalink }}">
{{ range .AllTranslations }}
<link rel="alternate" hreflang="{{ .Language.LanguageCode }}" href="{{ .Permalink }}">
{{ end }}
{{ if .IsTranslated }}{{ range .AllTranslations }}{{ if eq .Lang "en" }}
<link rel="alternate" hreflang="x-default" href="{{ .Permalink }}">
{{ end }}{{ end }}{{ else }}
<link rel="alternate" hreflang="x-default" href="{{ .Permalink }}">
{{ end }}

<!-- Open Graph -->
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
<meta property="og:url" content="{{ .Permalink }}">
<meta property="og:site_name" content="{{ .Site.Title }}">
{{ with .Params.og_image }}<meta property="og:image" content="https://YOUR-DOMAIN.org{{ . }}">
{{ else }}<meta property="og:image" content="https://YOUR-DOMAIN.org/img/og-default.png">{{ end }}
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">

<!-- Twitter / X -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ .Title }}">
<meta name="twitter:description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">

<!-- RSS autodiscovery -->
{{ with .OutputFormats.Get "rss" }}
{{ printf `<link rel=%q type=%q href=%q title=%q>` .Rel .MediaType.Type .Permalink site.Title | safeHTML }}
{{ end }}

<!-- Fonts: swap these for your preferred stack -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,400;0,6..72,500;0,6..72,600;0,6..72,700;1,6..72,400;1,6..72,500&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/main.css">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">

<!-- JSON-LD -->
{{ if .IsHome }}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "name": "{{ .Site.Title }}",
      "url": "{{ .Site.BaseURL }}",
      "inLanguage": [{{ range $i, $l := .Site.Languages }}{{ if $i }},{{ end }}"{{ $l.Lang }}"{{ end }}],
      "publisher": { "@id": "{{ .Site.BaseURL }}#person" }
    },
    {
      "@type": "Person",
      "@id": "{{ .Site.BaseURL }}#person",
      "name": "{{ .Site.Params.author }}",
      "url": "{{ .Site.BaseURL }}"
    }
  ]
}
</script>
{{ else if and .IsPage (eq .Section "research") }}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": ["Article", "ScholarlyArticle"],
  "headline": "{{ .Title }}",
  "datePublished": "{{ .PublishDate.Format "2006-01-02T15:04:05-07:00" }}",
  "dateModified": "{{ .Lastmod.Format "2006-01-02T15:04:05-07:00" }}",
  "author": { "@type": "Person", "name": "{{ .Site.Params.author }}" },
  "inLanguage": "{{ .Language.LanguageCode }}",
  "license": "https://creativecommons.org/licenses/by-nc/4.0/",
  "isAccessibleForFree": true,
  "wordCount": {{ .WordCount }}
}
</script>
{{ end }}

<!-- Theme: restore from localStorage before render to prevent flash -->
<script>
(function(){
  var t = localStorage.getItem('theme');
  if (t === 'dark' || t === 'light') {
    document.documentElement.setAttribute('data-theme', t);
  }
})();
</script>
```

### header.html

```html
<header class="site-header">
  <div class="container">
    <div class="header-left">
      <a href="{{ .Site.Home.RelPermalink }}" class="site-name">{{ .Site.Title }}</a>
      <nav class="site-nav">
        {{ range .Site.Menus.main }}
          <a href="{{ .URL }}"{{ if and (not $.IsHome) (hasPrefix $.RelPermalink .URL) }} class="active"{{ end }}>{{ .Name }}</a>
        {{ end }}
      </nav>
    </div>
    <div class="header-utils">
      <button class="theme-toggle" id="theme-toggle" aria-label="Toggle theme">◐</button>
    </div>
  </div>
</header>
```

### footer.html

```html
<footer class="site-footer">
  <div class="container">
    <p>
      © {{ now.Year }} <a href="{{ .Site.Home.RelPermalink }}">{{ .Site.Params.author }}</a> ·
      Text under <a href="https://creativecommons.org/licenses/by-nc/4.0/">CC BY-NC 4.0</a> ·
      Code under <a href="https://opensource.org/licenses/MIT">MIT</a><br>
      AI-assisted research with <a href="https://claude.ai">Claude</a> (Anthropic) ·
      <a href="{{ "colophon" | relLangURL }}/">How this site works</a>
    </p>
    <!-- Language switcher -->
    {{ if .IsTranslated }}
    <div class="lang-switch">
      {{ range .AllTranslations }}
        <a href="{{ .RelPermalink }}"{{ if eq $.Language.Lang .Lang }} class="active"{{ end }}>{{ .Language.LanguageName }}</a>
      {{ end }}
    </div>
    {{ end }}
  </div>
</footer>

<!-- Theme toggle script -->
<script>
(function(){
  var btn = document.getElementById('theme-toggle');
  if (!btn) return;
  function getEffective() {
    var attr = document.documentElement.getAttribute('data-theme');
    if (attr) return attr;
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }
  btn.addEventListener('click', function(){
    var next = getEffective() === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('theme', next);
  });
})();
</script>

<!-- Cloudflare Web Analytics (optional, free, no cookies) -->
{{ with .Site.Params.cfWebAnalyticsToken }}
<script defer src='https://static.cloudflareinsights.com/beacon.min.js' data-cf-beacon='{"token": "{{ . }}"}'></script>
{{ end }}
```

### index.html — Homepage

```html
{{ define "main" }}
<div class="container home-container">
  <article class="home-grid">
    <div class="home-intro">
      <h1>{{ .Title }}</h1>
      {{ .Content }}
      <div class="home-links">
        <a href="{{ "research" | relLangURL }}/">Research →</a>
        {{ with .Site.Params.github }}<a href="https://github.com/{{ . }}">GitHub</a>{{ end }}
        {{ with .Site.Params.linkedin }}<a href="https://linkedin.com/in/{{ . }}">LinkedIn</a>{{ end }}
        {{ with .Site.Params.email }}<a href="mailto:{{ . }}">{{ . }}</a>{{ end }}
      </div>
    </div>

    {{ $research := where .Site.RegularPages "Section" "research" }}
    {{ with $research }}
    <aside class="home-section">
      <h2 class="home-section-title">Research</h2>
      {{ range . }}
      <article class="research-card">
        <a href="{{ .Permalink }}" class="research-card-link">
          <div class="research-card-meta">
            <span>{{ .Date.Format "Jan 2006" }}</span>
            <span>{{ .ReadingTime }} min read</span>
          </div>
          <h3>{{ .Title }}</h3>
          {{ with .Params.description }}<p class="research-card-desc">{{ . }}</p>{{ end }}
        </a>
      </article>
      {{ end }}
    </aside>
    {{ end }}
  </article>
</div>
{{ end }}
```

### research/single.html — Article page

```html
{{ define "main" }}
<div class="container">
  <div class="article-header">
    <div class="label">Research{{ with .Params.series }} · {{ . }}{{ end }}</div>
    <h1>{{ .Title }}</h1>
    {{ with .Params.description }}<p class="description">{{ . }}</p>{{ end }}
    <div class="meta">
      <span>{{ .Date.Format "2006-01-02" }}</span>
      {{ if and .Params.lastmod (ne (.Params.lastmod.Format "2006-01-02") (.Date.Format "2006-01-02")) }}
      <span>updated {{ .Params.lastmod.Format "2006-01-02" }}</span>
      {{ end }}
      {{ with .Params.version }}<span>v{{ . }}</span>{{ end }}
      <span>{{ $.ReadingTime }} min read</span>
      {{ with .Params.license }}<span>{{ . }}</span>{{ end }}
    </div>

    {{ if .IsTranslated }}
    <div class="article-langs">
      {{ range .AllTranslations }}
        {{ if eq $.Language.Lang .Lang }}
          <span class="active">{{ .Language.LanguageName }}</span>
        {{ else }}
          <a href="{{ .RelPermalink }}">{{ .Language.LanguageName }}</a>
        {{ end }}
      {{ end }}
    </div>
    {{ end }}
  </div>

  {{ if .TableOfContents }}
  <nav class="article-toc">
    <details open>
      <summary class="toc-toggle">Contents</summary>
      <div class="toc-body">{{ .TableOfContents }}</div>
    </details>
  </nav>
  {{ end }}

  <div class="article-body">
    {{ .Content }}
    {{ with .Params.ai_disclosure }}
    <div class="ai-disclosure">
      <strong>AI Disclosure:</strong> {{ . }}
    </div>
    {{ end }}
  </div>
</div>
{{ end }}
```

### research/list.html — Research index

```html
{{ define "main" }}
<div class="container">
  <div class="research-list">
    <h1>{{ .Title }}</h1>
    {{ range .Pages.ByDate.Reverse }}
    <article class="research-card">
      <a href="{{ .Permalink }}" class="research-card-link">
        <div class="research-card-meta">
          <span>{{ .Date.Format "Jan 2006" }}</span>
          <span>{{ .ReadingTime }} min read</span>
        </div>
        <h2>{{ .Title }}</h2>
        {{ with .Params.description }}<p class="research-card-desc">{{ . }}</p>{{ end }}
        {{ with .Params.tags }}
        <div class="research-card-tags">
          {{ range . }}<span class="tag">{{ . }}</span>{{ end }}
        </div>
        {{ end }}
      </a>
    </article>
    {{ end }}
  </div>
</div>
{{ end }}
```

### 404.html

```html
{{ define "main" }}
<div class="container" style="padding: 4rem 0; text-align: center;">
  <h1>404</h1>
  <p>This page doesn't exist. Maybe it will someday.</p>
  <p><a href="{{ .Site.Home.RelPermalink }}">← Home</a></p>
</div>
{{ end }}
```

### Research archetype (archetypes/research.md)

When you run `hugo new research/your-topic/index.md`, Hugo uses this template to pre-fill front matter. Place this file at `themes/your-theme/archetypes/research.md`:

```markdown
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
lastmod: {{ .Date }}
version: "1.0"
status: "draft"
confidence: "possible"
description: ""
tags: []
series: ""
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---
```

Also create a minimal `archetypes/default.md` in the project root:

```markdown
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
---
```

**Note on dates:** Hugo does not build content with future dates by default. If your article's `date:` is after today, it simply won't appear. Use `hugo server --buildFuture` during development, or keep dates at today or earlier.

---

## Theme: CSS

Single file. CSS variables for light/dark. No frameworks, no preprocessors.

The key design decisions:
- **Serif body text** (Newsreader) — signals "this is writing, not a SaaS landing page"
- **Monospace for data** (JetBrains Mono) — numbers and code get their own voice
- **Warm palette** — not pure white/black, but warm paper (#faf9f7) and warm charcoal (#1c1b1a)
- **720px measure** — optimal line length for reading
- **System preference detection** — respects user's OS setting, with manual override

### Critical lesson learned (from production)

CSS-variable-driven HTML visualizations can render as **valid but invisible HTML** if contrast is too low. Before deploying any inline visualizations:

- Bar chart tracks need explicit borders + sufficient opacity (not just `rgba(0,0,0,0.06)`)
- Timeline dots must be filled with solid color, minimum 12px
- Metric display values need minimum `font-size: 1.6rem; font-weight: 600`
- Card components need explicit `background-color` (don't rely on transparent)
- **Test on BOTH light and dark themes** before pushing

### main.css (full reference)

The CSS is ~570 lines. Here's the structural overview — see [the live source](https://github.com/a-pap/papilov.org/blob/main/themes/cosmos/static/css/main.css) for the complete file.

```css
/* ── VARIABLES ── */

:root {
  --font-body: 'Newsreader', Georgia, serif;
  --font-mono: 'JetBrains Mono', 'Consolas', monospace;
  --measure: 38em;  /* ~720px at 19px base */
}

/* Light theme (default) */
:root, [data-theme="light"] {
  --bg: #faf9f7;
  --bg-secondary: #f3f2ef;
  --surface: #eceae6;
  --border: #ddd9d3;
  --text: #2c2c2c;
  --text-secondary: #5c5c5c;
  --text-tertiary: #8c8c8c;
  --link: #2c2c2c;
  --link-hover: #111111;
  --code-bg: #f0eeea;
  --bar-muted: rgba(0,0,0,0.08);
  --bar-accent: #2c2c2c;
}

/* Dark theme (explicit) */
[data-theme="dark"] {
  --bg: #1c1b1a;
  --bg-secondary: #222120;
  --surface: #2a2928;
  --border: #3a3836;
  --text: #cec9c1;
  --text-secondary: #96918a;
  --text-tertiary: #6e6a64;
  --link: #cec9c1;
  --link-hover: #e8e4dc;
  --code-bg: #252423;
  --bar-muted: rgba(255,255,255,0.12);
  --bar-accent: #c8bfb2;
}

/* Dark theme (system preference, not overridden) */
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    /* Same values as [data-theme="dark"] above */
  }
}

/* ── STRUCTURE ── */
/* html: 19px base, antialiased */
/* body: font-body, line-height 1.75, flex column, min-height 100dvh */
/* .container: max-width var(--measure), padding inline 1.5rem, margin auto */
/* .site-header: border-bottom, flex row, space-between */
/* .site-footer: border-top, margin-top auto */
/* .article-body: standard prose styling (headings, lists, links, code, blockquote) */
/* .research-card: clickable card with hover state */
/* .home-grid: two-column on desktop, single on mobile */

/* See full source: github.com/a-pap/papilov.org/blob/main/themes/cosmos/static/css/main.css */
```

### Inline Data Visualization CSS Classes

These go in the same main.css. They use CSS variables so they work in both themes.

```css
/* ── INLINE DATA VIZ ── */

/* Metric grid: key numbers in a row */
.metrics { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 1rem; margin: 1.5rem 0; }
.metric { padding: 1rem; border: 1px solid var(--border); border-radius: 6px; background: var(--bg-secondary); }
.metric .value { font-size: 1.6rem; font-weight: 600; font-family: var(--font-mono); }
.metric .label { font-size: 0.85rem; color: var(--text-secondary); }

/* Horizontal bar chart */
.bars { margin: 1.5rem 0; }
.bar-row { margin-bottom: 0.75rem; }
.bar-row .bar-label { font-size: 0.85rem; margin-bottom: 0.25rem; }
.bar-row .bar-track { height: 24px; background: var(--bar-muted); border: 1px solid var(--border); border-radius: 4px; overflow: hidden; }
.bar-row .bar-fill { height: 100%; background: var(--bar-accent); border-radius: 4px 0 0 4px; }
.bar-row .bar-value { font-family: var(--font-mono); font-size: 0.85rem; font-weight: 600; margin-top: 0.15rem; }

/* Timeline */
.timeline { position: relative; padding-left: 2rem; margin: 1.5rem 0; border-left: 2px solid var(--border); }
.tl-item { position: relative; margin-bottom: 1.5rem; }
.tl-item::before { content: ''; position: absolute; left: -2rem; top: 0.5rem; width: 12px; height: 12px; border-radius: 50%; background: var(--bar-accent); transform: translateX(-5px); }

/* Comparison columns */
.compare { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1.5rem 0; }
.compare-col { padding: 1rem; border: 1px solid var(--border); border-radius: 6px; background: var(--bg-secondary); }

/* Case study box */
.case-box { padding: 1.5rem; border: 1px solid var(--border); border-radius: 8px; background: var(--bg-secondary); margin: 1.5rem 0; }

/* Card grids (for frameworks, psychology concepts, etc.) */
.fw-grid, .psych-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1rem; margin: 1.5rem 0; }
.fw-card, .psych-card { padding: 1rem; border: 1px solid var(--border); border-radius: 6px; background: var(--bg-secondary); }

/* Mobile: stack everything */
@media (max-width: 640px) {
  .compare { grid-template-columns: 1fr; }
  .metrics { grid-template-columns: 1fr 1fr; }
}
```

---

## Content: Front Matter

Every research article uses this front matter:

```yaml
---
title: "Your Article Title"
date: 2026-03-05
lastmod: 2026-03-05
version: "1.0"
status: "finished"        # draft | in-progress | finished
confidence: "likely"      # possible | likely | certain
description: "One-line summary for SEO and cards."
tags: ["economics", "subscriptions"]
series: ""                # Group related articles
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
og_image: "/img/og-your-article.png"  # Optional
---
```

**Status** and **confidence** are metadata fields inspired by [Gwern](https://gwern.net). They signal intellectual honesty — not everything you publish needs to be "definitive."

---

## Content: i18n Strings

`i18n/en.yaml`:

```yaml
research_label: "Research"
ai_disclosure_label: "AI Disclosure"
footer_research: "Text under"
footer_code: "Code under"
footer_ai: "AI-assisted research with"
footer_how: "How this site works"
error_404: "This page doesn't exist. Maybe it will someday."
updated_label: "updated"
changelog_label: "changelog"
research_section: "Research"
toc_label: "Contents"
min_read: "min read"
related_label: "More Research"
```

For each additional language, create `i18n/xx.yaml` with translated strings.

---

## Static Files

### robots.txt — Open by default

```
# Maximum discoverability — all crawlers welcome

User-agent: Googlebot
Allow: /

User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: *
Allow: /

Sitemap: https://YOUR-DOMAIN.org/sitemap.xml
```

**Important:** If using Cloudflare, go to Dashboard → your domain → Security → Bots → **turn OFF "Managed robots.txt"**. When enabled, Cloudflare overrides your custom robots.txt and blocks AI crawlers.

### _headers — Cloudflare Pages HTTP headers

```
/*
  X-Frame-Options: SAMEORIGIN
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: interest-cohort=()

/*.html
  Cache-Control: public, max-age=3600, stale-while-revalidate=86400

/css/*
  Cache-Control: public, max-age=31536000, immutable

/img/*
  Cache-Control: public, max-age=2592000
```

### _redirects

```
# Legacy URL redirects (if you rename sections)
/blog/*  /research/:splat  301
```

### llms.txt — AI discoverability

```
# Your Site Name

> One-line description of your site and what it covers.

## Author
- Name: Your Name
- Site: https://YOUR-DOMAIN.org
- GitHub: https://github.com/your-username

## Research Articles

### Article Title (Month Year)
- URL: https://YOUR-DOMAIN.org/research/article-slug/
- Topics: topic1, topic2
- Summary: One paragraph describing the article.
```

### favicon.svg

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <text y=".9em" font-size="90">📐</text>
</svg>
```

Pick any emoji. It scales to any size.

---

## Deployment: Cloudflare Pages

### First-time setup (manual — requires dashboard clicks)

1. **Buy domain** at any registrar (Cloudflare Registrar is fine, ~$10/year for .org)
2. **Create Cloudflare account** at [dash.cloudflare.com](https://dash.cloudflare.com)
3. **Add your domain** to Cloudflare (if bought elsewhere, point nameservers to Cloudflare)
4. **Connect GitHub repo:**
   - Dashboard → Workers & Pages → Create → Pages → Connect to Git
   - Select your repository
   - Build settings: Framework = Hugo, Build command = `hugo --minify`, Output directory = `public`
   - Environment variable: `HUGO_VERSION` = `0.143.1` (or latest)
5. **Custom domain:**
   - Pages project → Custom domains → Add `your-domain.org`
   - Cloudflare auto-creates the DNS record

### The Locked CNAME Problem (Cloudflare Registrar only)

If you bought your domain through Cloudflare Registrar, it creates a CNAME record (`your-domain.org → default-page.cloudflareregistrar.com`) that **cannot be edited or deleted.** This is a known issue.

**Workaround: Cloudflare Worker proxy.**

Create a Worker (`your-site-proxy`) with this code:

```javascript
export default {
  async fetch(request) {
    const url = new URL(request.url);
    url.hostname = "your-project.pages.dev";
    return fetch(url.toString(), {
      method: request.method,
      headers: request.headers,
      body: request.body,
    });
  }
}
```

Then add Worker Routes:
- `your-domain.org/*` → your-site-proxy
- `www.your-domain.org/*` → your-site-proxy

No performance penalty — same Cloudflare edge network.

### Subsequent deploys

```bash
# Write content → commit → push → done
git add -A
git commit -m "feat: add new article"
git push

# Cloudflare Pages auto-builds in ~30 seconds
# Cache purge (if needed):
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_CACHE_PURGE_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

---

## SEO & Indexing

### What's built in
- JSON-LD structured data (WebSite + Person on home, ScholarlyArticle on articles)
- Google Scholar citation tags (Highwire Press format)
- Dublin Core metadata
- Open Graph + Twitter Cards
- hreflang for multilingual
- XML sitemap (auto-generated, tag pages excluded)
- Canonical URLs
- RSS feeds per language

### Manual steps after launch
1. **Google Search Console:** verify via DNS TXT record, submit sitemap
2. **Bing Webmaster Tools:** import from GSC
3. **Yandex Webmaster:** verify via DNS TXT record (if targeting Russian audience)
4. **IndexNow:** submit URLs to `api.indexnow.org` for faster Bing/Yandex indexing. **Do not** use `www.bing.com/indexnow` — it returns 403 from cloud IPs
5. **Google Scholar:** wait 2–6 weeks. Highwire Press + Dublin Core metadata does the work

### Indexing reality check

A new domain with zero external links will take **weeks** to get indexed, even with all metadata perfect. The bottleneck isn't SEO — it's backlinks. Your first external link (a Dev.to cross-post, a Hacker News submission, a tweet from someone with followers) matters more than any meta tag.

---

## Adding a New Article

```bash
# 1. Create directory
mkdir -p content/research/your-topic

# 2. Create content files (one per language)
# Use the archetype or copy front matter from above
cat > content/research/your-topic/index.en.md << 'EOF'
---
title: "Your Article Title"
date: 2026-03-01          # IMPORTANT: must be today or earlier — Hugo skips future dates
lastmod: 2026-03-01
version: "1.0"
status: "finished"
confidence: "likely"
description: "One-line summary."
tags: ["tag1", "tag2"]
ai_disclosure: "Research conducted with Claude (Anthropic)."
license: "CC BY-NC 4.0"
---

Your content here. Markdown with inline HTML for visualizations.
EOF

# 3. Deploy
git add -A && git commit -m "feat: add your-topic research" && git push
```

### Inline data visualization example

Because Hugo renders with `unsafe = true`, you can embed HTML directly in markdown:

```html
<div class="metrics">
  <div class="metric">
    <div class="value">172%</div>
    <div class="label">Disney+ price increase since 2019</div>
  </div>
  <div class="metric">
    <div class="value">$14.99</div>
    <div class="label">WoW monthly fee (unchanged since 2004)</div>
  </div>
</div>
```

This renders as a responsive metric grid that works in both light and dark themes.

---

## Distribution Checklist (per article)

1. ☐ Publish on your site (this is the canonical URL)
2. ☐ Wait 3–7 days for Google to index
3. ☐ Cross-post to Dev.to (with `canonical_url` in front matter)
4. ☐ Cross-post to Medium (set canonical URL in settings)
5. ☐ Post to Habr.com (if Russian-language version exists)
6. ☐ Submit to Hacker News (if English, data-heavy, opinionated)
7. ☐ LinkedIn article or post (key findings + link)
8. ☐ Twitter/X thread (8–10 posts with key data points)

**The canonical URL matters.** Dev.to and Medium both respect it — your site gets the SEO credit.

---

## What Makes This Different From a Standard Hugo Setup

| Feature | Standard Hugo | This Blueprint |
|---------|--------------|----------------|
| Academic SEO | ✗ | Google Scholar, Dublin Core, PRISM, JSON-LD ScholarlyArticle |
| AI discoverability | ✗ | llms.txt, robots.txt allowing all AI crawlers, `rel="ai-agent"` |
| Inline data viz | ✗ | CSS-variable-driven HTML components, theme-aware |
| AI co-authoring | ✗ | Explicit disclosure in front matter, footer, and colophon |
| Article versioning | ✗ | `version`, `status`, `confidence` fields + Git changelog link |
| 5-language ready | ✗ | Full multilingual with hreflang, i18n strings, per-language RSS |
| Worker proxy | ✗ | Workaround for Cloudflare Registrar locked CNAME |
| Citation infra | ✗ | CITATION.cff, BibTeX in README, Highwire Press tags |

---

## License

This blueprint itself is MIT-licensed. Use it however you want.

The research content model (CC BY-NC 4.0 for text, MIT for code) is what we use on [papilov.org](https://papilov.org) — adopt it or pick your own.

---

## Questions

**Why Hugo and not Astro/Next.js/Ghost/WordPress?**
Hugo is the fastest static site generator (~320ms builds for small sites), has zero runtime dependencies (single binary), and the simplest possible deploy pipeline. For a research site, you want the tool to disappear — not to become the project.

**Why Cloudflare Pages and not Vercel/Netlify?**
Free tier is genuinely free (no soft limits, no "hobby" tier), includes web analytics without cookies, and the edge network is the same one used by the CDN. Plus you can buy the domain there.

**Why not just use Medium/Substack?**
You don't own the URL. You don't control the design. You can't add structured metadata for Google Scholar. You can't embed interactive visualizations. You can't put `llms.txt` at your root. And they can change their business model anytime. A $10/year domain is forever.

**Do I need to know Hugo/HTML/CSS to use this?**
No. Give this file to Claude and describe what you want. It will generate the code. You need to be comfortable with: (1) a GitHub account, (2) a Cloudflare account, (3) running `git push` from a terminal. That's it.
