---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "1.0"
status: "published"
label: "Notiz"
description: "Eine kurze Notiz zum Muster persönlicher Erinnerung, das ich mit Claude benutze: ein privates Git-Repository mit Markdown-Notizen, ein Cloudflare Worker, der sie als MCP-Tools exponiert, und zwei Session-Hooks von Claude Code. Der Code ist meiner und privat; diese Seite ist die öffentliche Skizze der Idee."
tags: ["claude", "mcp", "personal-memory"]
ai_disclosure: "Geschrieben mit Claude."
license: "CC BY-NC 4.0"
robots: "all"
---

*Eine Skizze, kein Leitfaden. Ein Git-Repo plus ein Worker reicht, um Claude ein Gedächtnis zu geben, das die Konversation überdauert.*

Das Setup hat drei Teile und ist bewusst klein. Ein privates Git-Repository hält kurze Markdown-Notizen — ein winziger Bootloader im Root, eine cross-Domain-Statusdatei unter sechzig Zeilen und eine Regeln-Datei für Verhalten, das ich nicht in jeder Sitzung neu erklären will. Ein Cloudflare Worker aus einer Datei spricht Model Context Protocol auf `/mcp`, gestützt auf D1 für strukturierte Zeilen und R2 für gelegentliche Backups. Zwei Session-Hooks von Claude Code verdrahten das Ganze: `SessionStart` führt `git pull` aus, damit der erste Turn frische Daten sieht; `SessionEnd` schreibt eine Zeile Nutzung über ein `auto_log`-Tool. Optionale Erweiterungen — ein Capture-Bot, eine nächtliche Konsolidierung, ein paar Managed Connectors — sind jeweils ~fünfzehn Minuten und unabhängig vom Kern.

Vier Invarianten machen daraus mehr als ein Spielzeug. Den Bootloader klein halten, damit die Startkosten unter wenigen tausend Tokens bleiben. Themen-Routing deterministisch machen — ein Thema lebt in einer Datei, nie in zweien. Committed Markdown als stärker betrachten als alles in einem Chatlog, wenn Fakten sich widersprechen. Niemals Secrets ins Repo legen; ein lokaler Pre-Commit-Scanner und ein serverseitiges Lint sorgen dafür, dass ein Ausrutscher nicht ins öffentliche Internet gelangt.

Benachbarte Werkzeuge, die sich anzuschauen lohnt, wenn du etwas Eigenes baust: das [Model Context Protocol](https://modelcontextprotocol.io/) selbst; die Managed-Alternativen [mem0](https://mem0.ai/) und [Letta](https://www.letta.com/); Simon Willisons `llm`-CLI und [Datasette](https://datasette.io/) für die Datei-als-Primitiv-Schule. Auf dieser Seite gibt es nichts aufzurufen — der Code ist privat, es werden keine Endpunkte veröffentlicht. Das Muster ist der Punkt.
