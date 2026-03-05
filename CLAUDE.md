# CLAUDE.md — papilov.org

## Project Overview

Personal research site for Artem Papilov. Hugo 0.143.1 static site with custom "Cosmos" theme, hosted on Cloudflare Pages, proxied through a Cloudflare Worker.

- **Live URL:** https://papilov.org
- **Pages URL:** https://papilov-org.pages.dev
- **Repo:** `a-pap/papilov.org` (public)
- **TTFB:** ~320ms

## Development

```bash
# Local dev server (includes drafts)
hugo server --buildDrafts

# Build for production
hugo --minify

# Deployment: push to main → Cloudflare Pages auto-builds
```

## Repo Structure

```
content/              # Markdown content
  _index.md           # Homepage
  research/           # Research articles (each in own directory)
  colophon.md
  work-with-me.md
themes/cosmos/        # Custom theme
  layouts/            # Hugo templates
  static/css/main.css # All styles
  archetypes/research.md  # New article template
static/               # Static assets (copied as-is to output)
  _headers             # Cloudflare Pages headers
  _redirects           # Cloudflare Pages redirects
hugo.toml             # Site config
```

## Adding a Research Article

```bash
mkdir -p content/research/topic-name
hugo new research/topic-name/index.md    # Uses archetype
# If infographic: cp infographic.html static/research/topic-name/
git add -A && git commit -m "feat: add topic-name research" && git push
```

### Front Matter

```yaml
---
title: "Title"
date: 2026-03-05
lastmod: 2026-03-05
version: "1.0"
status: "draft"           # draft | in-progress | finished
confidence: "possible"    # possible | likely | certain
description: "One-line summary"
tags: ["tag1", "tag2"]
series: ""
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---
```

## Design System

| Token           | Value            |
|-----------------|------------------|
| Background      | `#0a0a0f`        |
| Surface         | `#12121a`        |
| Border          | `#2a2a3a`        |
| Text            | `#e8e6e3`        |
| Text dim        | `#8a8a9a`        |
| Accent (orange) | `#ff6b35`        |
| Accent (teal)   | `#00d4aa`        |
| Accent (indigo) | `#6366f1`        |
| Headings font   | Playfair Display |
| Body font       | DM Sans          |
| Data/code font  | JetBrains Mono   |
| Container       | 740px (narrow), 1100px (wide) |

All styles live in `themes/cosmos/static/css/main.css`.

## Cloudflare Infrastructure

### Credentials (scoped token)

```
Token: 81Shka0WopPUSiDyMHuhpj0fxjuEVLJhLP5XWQWz
Zone ID: ff4fccc07f94931bf783b5fa988c272c
Account ID: 591f28ffddda0db48e961f1427310923
```

Permissions: DNS Read/Write, Pages Read/Write, Workers Scripts Read/Write.

### Common API Calls

```bash
# List DNS records
curl -s "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "Authorization: Bearer $TOKEN"

# Trigger Pages deployment
curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/pages/projects/papilov-org/deployments" \
  -H "Authorization: Bearer $TOKEN"

# Purge cache (after content changes)
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/purge_cache" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

### Worker Proxy

A Cloudflare Worker (`papilov-org-proxy`) intercepts all traffic on `papilov.org/*` and `www.papilov.org/*` and proxies it to `papilov-org.pages.dev`. This exists because Cloudflare Registrar created a locked CNAME record (`papilov.org → default-page.cloudflareregistrar.com`) that cannot be edited or deleted. The Worker is the workaround — transparent, no performance penalty (same edge network).

| Route Pattern      | Script            |
|--------------------|-------------------|
| `papilov.org/*`    | papilov-org-proxy |
| `www.papilov.org/*`| papilov-org-proxy |

### DNS Records

| Type  | Name            | Content                              | Proxied |
|-------|-----------------|--------------------------------------|---------|
| CNAME | papilov.org     | default-page.cloudflareregistrar.com | Yes (locked, bypassed by Worker) |
| CNAME | www.papilov.org | papilov-org.pages.dev                | Yes     |
| CNAME | sig1._domainkey | sig1.dkim…icloudmailadmin.com        | DNS only |
| MX    | papilov.org     | mx01.mail.icloud.com                 | -       |
| MX    | papilov.org     | mx02.mail.icloud.com                 | -       |
| TXT   | papilov.org     | v=spf1 include:icloud.com ~all       | -       |
| TXT   | papilov.org     | apple-domain=rf3C0dlJEfcWJtuh        | -       |

### Cloudflare Settings

SSL: Full (Strict), HSTS enabled (1yr, preload), Always HTTPS, HTTP/3, 0-RTT, TLS 1.3 (min 1.2), Brotli, Early Hints, HTTPS Rewrites, aggressive caching (browser TTL 30d), hotlink protection, email obfuscation.

## Backlog

1. Enable Cloudflare Web Analytics (manual dashboard click)
2. Common Knowledge research article
3. Cal.com setup for /work-with-me/
4. WHOIS contact update (Belgrade → Barcelona)
