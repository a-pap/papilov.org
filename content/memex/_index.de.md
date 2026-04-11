---
title: "Memex"
description: "Persistenter, strukturierter und oberflächenübergreifender Speicher für Claude — gestützt auf ein privates GitHub-Repository."
tagline: "Persistenter Speicher für Claude"
summary: "Claude vergisst zwischen den Gesprächen alles. Memex gibt dir strukturierten, oberflächenübergreifenden Speicher, den du kontrollierst — ein privates GitHub-Repository als einzige Quelle der Wahrheit."
meta: "git-gestützt · Markdown · 26 MCP-Tools · ~5 Min. Setup"
---

Claude vergisst zwischen den Gesprächen alles. Der eingebaute Speicher wird automatisch generiert, ist unstrukturiert und hinkt tagelang hinterher.

**Memex gibt dir strukturierten, oberflächenübergreifenden Speicher, den du kontrollierst** — ein privates GitHub-Repository als einzige Quelle der Wahrheit. Dein Kontext lebt als menschenlesbare Markdown-Dateien, versioniert in git, bei Bedarf geladen. Dasselbe Repository ist das Gehirn für Claude.ai, Claude Code, die Mobile-App und geplante Hintergrundaufgaben.

## Was du bekommst

- **Kontinuität über Oberflächen hinweg.** Du entscheidest morgens etwas am Handy; am Nachmittag weiß Claude Code auf deinem Laptop bereits Bescheid.
- **Menschenlesbarer Speicher.** Markdown in git, kein undurchsichtiges SQLite. Jede Änderung ist ein Commit, den du lesen, vergleichen und zurücknehmen kannst.
- **Abgestuftes Laden des Kontexts.** ~3K Tokens beim Start, mehr nur wenn das Thema es verlangt. Keine 50K Tokens Verlauf in jedem Gespräch.
- **Vollständige Wiederherstellung nach Katastrophen.** Ein frischer Claude ohne Memory Edits baut seinen gesamten Kontext in etwa zwei Minuten aus dem Repository wieder auf.
- **26 MCP-Tools über Cloudflare Workers.** Optional, für Oberflächen, die kein git ausführen können — das Kernprinzip funktioniert allein aus dem Repository.

## Den Blueprint lesen

Memex ist öffentlich und selbst hostbar. Das Repository enthält die vollständige Architektur, die Installationsanleitung und Beispiele.

**→ [github.com/a-pap/memex](https://github.com/a-pap/memex)**

Lizenz: MIT (Code), CC BY 4.0 (Dokumentation). Gebaut mit [Claude](https://claude.ai).
