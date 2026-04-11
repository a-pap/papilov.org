---
title: "Memex"
description: "Persistent, structured, cross-surface memory for Claude — backed by a private GitHub repo."
tagline: "Persistent memory for Claude"
summary: "Claude forgets everything between conversations. Memex gives you structured, cross-surface memory that you control — using a private GitHub repo as the single source of truth."
meta: "git-backed · markdown-native · 26 MCP tools · ~5 min setup"
---

Claude forgets everything between conversations. Built-in memory is auto-generated, unstructured, and lags by days.

**Memex gives you structured, cross-surface memory that you control** — using a private GitHub repo as the single source of truth. Your context lives as human-readable markdown files, versioned in git, loaded on demand. The same repo is the brain for Claude.ai chat, Claude Code, the mobile app, and scheduled background tasks.

## What you get

- **Cross-surface continuity.** Decide something on your phone in the morning; Claude Code on your laptop already knows about it that afternoon.
- **Human-readable storage.** Markdown in git, not opaque SQLite. Every change is a commit you can read, diff, and roll back.
- **Graduated context loading.** ~3K tokens at startup, more only when the topic demands it. No dumping 50K tokens of history into every conversation.
- **Full disaster recovery.** A fresh Claude with no memory edits can rebuild its entire context from the repo in about two minutes.
- **26 MCP tools over Cloudflare Workers.** Optional, for surfaces that can't run git — but the core design works from the repo alone.

## Read the blueprint

Memex is public and self-hostable. The repo contains the full architecture, setup guide, and examples.

**→ [github.com/a-pap/memex](https://github.com/a-pap/memex)**

License: MIT (code), CC BY 4.0 (docs). Built with [Claude](https://claude.ai).
