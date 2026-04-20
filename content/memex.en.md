---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "1.0"
status: "published"
label: "Notes"
description: "A short write-up of the personal-memory pattern I use with Claude: a private git repository of Markdown notes, one Cloudflare Worker exposing them as MCP tools, and two Claude Code session hooks. The code is mine and private; this page is the public sketch of the idea."
tags: ["claude", "mcp", "personal-memory"]
ai_disclosure: "Written with Claude."
license: "CC BY-NC 4.0"
robots: "all"
---

*A sketch, not a guide. A git repo plus one worker is enough to give Claude a memory that outlives the conversation.*

The setup has three parts and is deliberately small. A private git repository holds short Markdown notes — a tiny bootloader at the root, a cross-domain status file under sixty lines, and a rules file for behaviour I don't want to re-explain every session. A single-file Cloudflare Worker speaks Model Context Protocol at `/mcp`, backed by D1 for structured rows and R2 for occasional backups. Two Claude Code session hooks wire it in: `SessionStart` runs `git pull`, so the first turn of every session sees fresh data; `SessionEnd` writes one row of usage via an `auto_log` tool. Optional add-ons — a capture bot, a nightly consolidation task, a couple of managed connectors — each take about fifteen minutes and are independent of the core.

Four invariants turn this from a toy into something I trust. Keep the bootloader small so start-up stays under a few thousand tokens. Make topic routing deterministic — one topic lives in one file, never two. Treat committed Markdown as stronger than anything in a chat log when facts disagree. Never put secrets in the repo; a local pre-commit scanner and a server-side lint make sure a slip cannot reach the public internet.

Adjacent tools worth a look if you want to build your own: the [Model Context Protocol](https://modelcontextprotocol.io/) itself; managed alternatives [mem0](https://mem0.ai/) and [Letta](https://www.letta.com/); Simon Willison's `llm` CLI and [Datasette](https://datasette.io/) for the file-as-primitive school. Nothing on this page is callable — the code is private and no endpoints are published. The pattern is the point.
