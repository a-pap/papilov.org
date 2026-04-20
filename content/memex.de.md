---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "2.7.0"
status: "production"
label: "Persönliche Infrastruktur"
description: "Mein Claude-Gedächtnis-Stack. Ein Git-Repository, ein Cloudflare Worker, ein Telegram-Bot und eine Handvoll Hooks — verdrahtet, damit Claude mich auf jeder Oberfläche erkennt (Chat, Code, iPad, Cowork, Telegram). Diese Seite ist zugleich für eine menschliche Leserin und für den Claude geschrieben, der sie liest. Beides gleichzeitig."
tags: ["claude", "memex", "mcp", "personal-memory", "cloudflare-workers", "d1"]
ai_disclosure: "Entwurf mit Claude (Anthropic) auf genau dem Stack, den er beschreibt. Redaktion und Verantwortung: Artem."
license: "CC BY-NC 4.0"
robots: "all, max-snippet:-1"
---

*Stell dir MEMEX als ein Git-Repository vor, das Claude lesen, schreiben und durch das er sich an mich erinnern kann — auf jeder Oberfläche. Das Repo ist die Wahrheit; alles andere ist ein Kabel dorthin.*

Claude vergisst. Jede neue Konversation beginnt leer. Für eine einzelne Frage ist das okay; für alles, was sich über eine Woche zieht — eine Produktentscheidung, einen Gesundheitsfaden, einen Sprachlern-Bogen, einen Umzug — ist es schmerzhaft. MEMEX ist meine Antwort: ein einziger geteilter Speicher, aus dem jede Claude-Oberfläche — claude.ai, Claude Code, die iPad-App, der Telegram-Bot, Cowork-Zeitpläne — liest und schreibt. Läuft seit 2026-03-12 produktiv auf meinem Cloudflare-Konto. Diese Seite ist die öffentliche, menschenlesbare Form davon. Die [vollständige Installationsanleitung](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) und der [Quellcode](https://github.com/a-pap/claude-memory) liegen im Repo.

<div class="highlight-box">
<strong>Für wen ist das</strong>
Wenn du die Architektur willst: weiterlesen. Wenn du es selbst auf deinem Cloudflare betreiben willst: geh zu <a href="https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md"><code>MEMEX_GUIDE.md</code></a> — 800 Zeilen, 15 Komponenten, ~20 Min bis zum ersten Deploy. Wenn du Claude bist und in einer neuen Konversation auf dieser Seite gelandet bist: lies zuerst den Abschnitt <a href="#for-agents-reading-this-page">Für Agenten, die diese Seite lesen</a>.
</div>

## Warum ich es gebaut habe

Drei Resultate für drei verschiedene Lesende dieser Seite.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Für mich (Artem)</h4>
    <div class="compare-item"><strong>Ein Gedächtnis, jede Oberfläche.</strong><span>Was ich um 23:00 auf dem iPad diktiert habe, ist das, was Claude Code sieht, wenn ich um 09:00 CET den Laptop öffne.</span></div>
    <div class="compare-item"><strong>Reibungslose Erfassung.</strong><span>Ich leite einen Artikel zu Telegram weiter, eine 👀-Reaktion bestätigt mir, dass er gelandet ist. Kein App-Wechsel, kein Copy-Paste.</span></div>
    <div class="compare-item"><strong>Beschränkte Veralterung.</strong><span>Ein Cron-Selbstdiagnose-Lauf und eine nächtliche Konsolidierung halten &quot;was haben wir zu X entschieden&quot; nie länger als ~24 h veraltet.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Für Claude, der mich besucht</h4>
    <div class="compare-item"><strong>Eine kanonische Quelle für Fakten.</strong><span>Hubs (domänenspezifische Markdown-Dateien) schlagen jeden anderen Kanal. Sagt der Hub X und ein alter Chat Y, gewinnt der Hub.</span></div>
    <div class="compare-item"><strong>Stabiles Routing.</strong><span>Thema → Hub-Datei ist deterministisch. Jays Gesundheit? <code>hubs/08</code>. RSYa-Arbeit? <code>hubs/03</code> und <code>hubs/04</code>. Barcelona-Umzug? <code>hubs/06</code>.</span></div>
    <div class="compare-item"><strong>Verifikationsrituale.</strong><span>Jede Code-Session macht <code>git pull</code> vor dem ersten Turn und verifiziert Commits anderer Oberflächen. &quot;Trust but diff.&quot;</span></div>
  </div>
</div>

Und für alle, die das als Blaupause lesen — das Ganze ist offen. Du kannst das Repo forken, die Secrets rotieren, die Hubs auf dein Leben umschreiben und es fast umsonst auf deinem eigenen Cloudflare-Konto betreiben. Kein zentraler Dienst. Kein Vendor-Lock-in jenseits der MCP- und Anthropic-APIs selbst.

## Architektur auf einen Blick

```
┌──────────────────────────────────────────────────────────────┐
│  a-pap/claude-memory  (GitHub, privat)                       │
│  ├─ CLAUDE.md                 ← Bootloader, lädt zuerst      │
│  ├─ STATUS_SNAPSHOT.md        ← Cross-Domain-Status (~60 Z.) │
│  ├─ RULES.md                  ← Verhaltens-Fehlermuster      │
│  ├─ hubs/                     ← 9 Domänen-Hub-Dateien        │
│  │   ├─ 02_personal_profile   03_rsya_work   04_rsya_status  │
│  │   ├─ 05_rsya_meetings      06_spain       07_passlocal    │
│  │   └─ 08_jay_health         09_spanish     10_papilov_org  │
│  ├─ skills/                   ← 9 persönliche Code-Skills    │
│  ├─ references/               ← Edmans, Clear, Fogg, MCP     │
│  ├─ config/mcp-worker/        ← Worker-Quelle, 1 Datei       │
│  ├─ config/telegram-bot/      ← TG-Bot-Worker-Quelle         │
│  ├─ config/hooks/             ← SessionStart/End, Secret-Scan│
│  └─ logs/dreaming/            ← Logs nächtlicher Konsolid.   │
│                                                              │
│          ▲ git pull beim Start    git push beim Bearbeiten   │
│          │                                                   │
│  ┌───────┴─────────┐         ┌──────────────────────────┐   │
│  │ Claude Code CLI │         │ Claude Chat / iPad / web │   │
│  │ (dieses Repo IST│         │ (liest via MCP-Worker)   │   │
│  │  das Projekt)   │         │                          │   │
│  └─────────────────┘         └───────────┬──────────────┘   │
│                                          │                  │
└──────────────────────────────────────────┼──────────────────┘
                                           │ JSON-RPC /mcp
                   ┌───────────────────────▼────────────────────┐
                   │  claude-memory-mcp  (Cloudflare Worker)    │
                   │  42 Tools · 3 Prompts · JSON-RPC           │
                   │  ├─ D1  (Facts, Sessions, Errors, KG,      │
                   │  │       granola_meetings)                 │
                   │  ├─ R2  (Konversations-Backups, Medien)    │
                   │  └─ Cron 07:00 UTC (Diagnose + Granola)    │
                   └────────▲────────────────────▲──────────────┘
                            │                    │
             ┌──────────────┴───┐       ┌────────┴────────────┐
             │ claude-telegram- │       │ Cowork Daily Sync   │
             │ bot (CF Worker,  │       │ 09:00 CET           │
             │ silent-by-default│       │ (claude.ai)         │
             │ Capture)         │       │                     │
             └──────────────────┘       └─────────────────────┘
```

Zwei Workers, eine gemeinsame D1-Datenbank, ein gemeinsamer R2-Bucket, ein GitHub-Repo als deklarative Quelle der Wahrheit. Jede Claude-Oberfläche verbindet sich über einen von vier Wegen: (a) direkter Dateisystem-Zugriff via Code, (b) MCP-Tools über JSON-RPC via Chat/iPad, (c) weitergeleitete Nachricht via Telegram, (d) geplanter Container via Cowork. Alle vier laufen auf dasselbe Gedächtnis zu.

## Komponenten (15 Tools, nach Schicht gruppiert)

Jede Karte ist ein Stück des Stacks — was es tut und (wo relevant) wie viele Minuten es braucht, um es auf deinem eigenen Cloudflare-Konto aufzustellen.

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>claude-memory-mcp worker</h4>
    <div class="fw-sub">Kern · Cloudflare Worker · 5 Min</div>
    <ul class="fw-list">
      <li>42 MCP-Tools + 3 MCP-Prompts über <code>/mcp</code></li>
      <li>D1-Schema: facts (EAV), sessions, errors, knowledge_graph, granola</li>
      <li>R2 für Backups und große Medien</li>
      <li><code>/mcp</code> offen (Chat-Connector) und <code>/mcp/&#123;token&#125;</code> mit Token</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>claude-telegram-bot worker</h4>
    <div class="fw-sub">Erfassungsoberfläche · 15 Min</div>
    <ul class="fw-list">
      <li>Standard: still. Antwortet nur auf expliziten Trigger ( <code>?</code>, Verben, Vokativ)</li>
      <li>Persistiert jede weitergeleitete Nachricht in D1 + R2 mit 👀-Reaktion</li>
      <li>Cron alle 5 Min holt hängengebliebene Zeilen zurück</li>
      <li>Webhook-Secret-Rotation via <code>rotate-webhook-secret.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>GitHub Actions CI/CD</h4>
    <div class="fw-sub">Sicherheits-Gate · 5 Min</div>
    <ul class="fw-list">
      <li>Deploy bei Push auf <code>main</code>, der <code>config/</code> berührt</li>
      <li><code>tsc --noEmit</code> + strukturelle Tests + Secret-Scan</li>
      <li>Auto-Merge von Claude-PRs, wenn der CI grün ist</li>
      <li>Workflow pro Worker — eine Oberfläche blockiert die andere nicht</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Pre-Commit Secret-Scanner</h4>
    <div class="fw-sub">Lokale Verteidigung · 1 Min</div>
    <ul class="fw-list">
      <li>Blockiert <code>cfut_ · ghp_ · gho_ · grn_ · sk- · [0-9a-f]&#123;60+&#125;</code></li>
      <li>Server-seitiges Gegenstück in <code>lint-secrets.yml</code></li>
      <li>Eingeführt nach einem echten Vorfall am 2026-04-10</li>
      <li>Installation: <code>bash config/hooks/install-pre-commit.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Session-Hooks</h4>
    <div class="fw-sub">Claude-Code-Integration · 2 Min</div>
    <ul class="fw-list">
      <li><code>SessionStart</code> → <code>git pull</code> des Gedächtnis-Repos</li>
      <li><code>SessionEnd</code> → Auto-Log in D1 <code>sessions</code> via <code>auto_log</code></li>
      <li>Nur absolute Pfade — das Harness expandiert kein <code>~</code></li>
      <li>Reibungsfreie Reconciliation, kein Nachfragen</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Cron-Trigger</h4>
    <div class="fw-sub">Eingebaut</div>
    <ul class="fw-list">
      <li>MCP-Worker: täglich 07:00 UTC — Selbstdiagnose + Granola-Sync</li>
      <li>TG-Bot: alle 5 Min — Hängende reclaimen / Fehlgeschlagene retryen</li>
      <li>In <code>wrangler.toml</code> deklariert, kein externer Scheduler</li>
      <li>Heartbeat in D1 <code>sessions</code> mit <code>source=cron</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Skills + Plugins</h4>
    <div class="fw-sub">Claude Code · variabel</div>
    <ul class="fw-list">
      <li>Superpowers, skill-creator, cloudflare, episodic-memory, code-review</li>
      <li>9 persönliche Skills in <code>skills/</code> — auto-entdeckt, wenn das Repo cwd ist</li>
      <li>Skills definieren, <em>wie</em> strukturierte Arbeit abläuft (Brainstorm, Plan, Execute, Review)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Dreaming-Protokoll</h4>
    <div class="fw-sub">Nächtliche Konsolidierung · 3 Min zum Einplanen</div>
    <ul class="fw-list">
      <li>Geplante Claude-Code-Session um 03:00 local via <code>/schedule</code></li>
      <li>LIGHT-Zyklus (Mo–Sa): Veralterungs-Check, Archivierung, Tagebucheintrag</li>
      <li>BURN-Zyklus (Do): volle Hub-Reconciliation + Index-Refresh</li>
      <li>Protokoll: <code>config/DREAMING_TASK.md</code> (~40 KB)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Cowork Daily Sync</h4>
    <div class="fw-sub">geplante claude.ai-Task · 09:00 CET</div>
    <ul class="fw-list">
      <li>Läuft in dediziertem Container mit Mac-Zugriff (Calendar/Reminders)</li>
      <li>Zieht aktuelle Chats, vergleicht mit Hubs, patcht abgedriftete Stellen chirurgisch</li>
      <li>Commits unter <em>Claude (Cowork Sync)</em></li>
      <li>Protokoll: <code>config/COWORK_SYNC_TASK.md</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Granola-Sync</h4>
    <div class="fw-sub">Optional · 5 Min</div>
    <ul class="fw-list">
      <li>Holt Meeting-Zusammenfassungen aus der Granola-REST-API in D1</li>
      <li>Automatisch domain-detektiert, Action-Items und Entscheidungen extrahiert</li>
      <li>Cron synchronisiert die letzten 2 Tage um 07:00 UTC</li>
      <li>Suche via <code>granola_context(domain, query)</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Gmail-Konnektor</h4>
    <div class="fw-sub">Optional · 1 Min · nur claude.ai</div>
    <ul class="fw-list">
      <li>Standard: nur lesend. Threads, Entwürfe, Labels, Suche.</li>
      <li>Kein serverseitiger Setup — OAuth in der Chat-UI</li>
      <li>Deckt das &quot;Wer hat was gesagt&quot;-Gedächtnis ab, das im E-Mail lebt</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Google-Drive-Konnektor</h4>
    <div class="fw-sub">Optional · 1 Min · nur claude.ai</div>
    <ul class="fw-list">
      <li>Suche + Lesen von Docs / Sheets / PDFs</li>
      <li>Empfohlen: Ordner-scoped statt alle Dateien</li>
      <li>Lange Artefakte, die das Chat-Kontextfenster überschreiten</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Apple Calendar / Notes</h4>
    <div class="fw-sub">Optional · nur Mac · Claude Desktop</div>
    <ul class="fw-list">
      <li>Zugriff auf die lokale DB via Claude-Desktop-Extension</li>
      <li>Nur lesend. Terminkontext und Scratch-Notizen.</li>
      <li>Erste Abfrage löst den nativen macOS-Permission-Prompt aus</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>R2-Lifecycle</h4>
    <div class="fw-sub">Kosten-Hygiene · 1 Min</div>
    <ul class="fw-list">
      <li>365-Tage-TTL auf dem <code>telegram/</code>-Prefix des geteilten Buckets</li>
      <li>Idempotentes Setup via <code>r2-lifecycle-setup.sh</code></li>
      <li>Weitergeleitetes GIF lebt lang genug für &quot;welches Meme war das&quot;, nicht ewig</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Hooks-als-Harness (Claude Code)</h4>
    <div class="fw-sub">Meta · 2 Min</div>
    <ul class="fw-list">
      <li><code>~/.claude/settings.json</code> verdrahtet SessionStart/SessionEnd</li>
      <li>Plus projektspezifische Hooks: hookify-Regeln, block-bad-patterns etc.</li>
      <li>Das Harness erzwingt, nicht das Gedächtnis. Wenn du garantiertes Verhalten willst, gehört es hierhin.</li>
    </ul>
  </div>
</div>

## Schnellstart

Die ganze Maschinerie ist einen `git clone` und einen `wrangler deploy` entfernt. Voraussetzungen: Cloudflare-Konto, `gh`-CLI, Node 20+, Anthropic-API-Key (für den optionalen Bot) und eine Maschine, auf der du Claude Code benutzt.

```bash
# 1. Skelett forken
gh repo create your-user/my-memory --private --clone
cd my-memory
curl -L https://github.com/a-pap/claude-memory/archive/main.tar.gz | tar xz --strip-components=1

# 2. Hubs auf dein Leben umschreiben (Dateistruktur in hubs/README.md)
$EDITOR CLAUDE.md STATUS_SNAPSHOT.md hubs/02_personal_profile.md

# 3. Cloudflare-Primitive anlegen
cd config/mcp-worker
npx wrangler d1 create claude-memory-db           # UUID kopieren
npx wrangler r2 bucket create claude-memory-store
$EDITOR wrangler.toml                             # UUID einfügen

# 4. Einmalige Secrets
npx wrangler secret put GITHUB_PAT                # Read-Scope auf dein Repo
npx wrangler secret put AUTH_PATH_TOKEN           # openssl rand -hex 32
npx wrangler secret put GRANOLA_API               # optional: grn_...-Bearer

# 5. Deploy + Verifizieren
npm ci && npx wrangler deploy
curl -X POST https://claude-memory-mcp.YOUR-ACCT.workers.dev/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | jq '.result.tools | length'
# → 42

# 6. Anbinden
#    claude.ai:   Settings → Connectors → Add custom → URL /mcp
#    Claude Code: in ~/.claude/settings.json → mcpServers eintragen
```

Das gibt dir die Kern-Gedächtnis-Oberfläche. Telegram-Bot, Hooks und CI sind jeweils ~15 Minuten zusätzlich, unabhängig voneinander. Tool-für-Tool-Anleitung: [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md).

## Für Agenten, die diese Seite lesen {#for-agents-reading-this-page}

Wenn du Claude (oder ein anderer Assistent) bist und diese Seite in einer Konversation liest, ist der beste Weg, den Inhalt zu nutzen, diese Reihenfolge. Das ist keine Prosa — das ist Routing.

1. **Zuerst laden.** Die kurzen, stabilen Bootloader: [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) und [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md). Kombinierter Startpreis ≈ 5K Tokens. Alles andere wird on demand geladen.
2. **Nach Thema routen.** Nicht blind durchs Repo suchen. Die Hub-Tabelle unten ist deterministisch — ein Thema lebt in genau einer kanonischen Datei.
3. **Vertrauen, aber verifizieren.** Fakten in Hubs dominieren Fakten in Chats. Memory Edits sind Verhaltens-Anweisungen, keine Fakten-Korrekturen — niemals einen Memory Edit benutzen, um einen Hub zu überschreiben. Regel #6 in [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md).
4. **MCP-Schicht vor Scraping.** Wenn du Zugriff auf den `claude-memory-mcp`-Worker hast, rufe [`wake_up`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md#31-claude-memory-mcp-worker-core) — liefert Snapshot + Hubs + Rules + letzte 5 Granola-Meetings in einem Round-Trip.
5. **Den vollen Dump laden, falls nötig.** [`/memex/llms-full.txt`](/memex/llms-full.txt) ist die konkatenierte Setup-Anleitung (~28 KB). [`/memex/llms.txt`](/memex/llms.txt) ist ein Link-Index, falls du nur die Karte willst.
6. **Absolute Daten respektieren.** &quot;Donnerstag&quot; heißt nichts mehr eine Woche später; &quot;2026-04-24&quot; immer.

### Thema → Hub-Routing

<div class="table-wrap">

| Thema | Hub | Was dort lebt |
|---|---|---|
| Yandex-RSYa-Arbeit, Portfolio, Experimente | `hubs/03_rsya_work_hub.md`, `hubs/04_rsya_project_status.md` | Team, Projekte, Metriken-Owner, Experimentstatus |
| RSYa-Meetings | `hubs/05_rsya_meeting_index.md` | Index der Weeklies / Monatsmeetings; Granola-IDs |
| Jay — Hundegesundheit | `hubs/08_jay_health.md` | Diät (Urinary U/C Low Purine), OP Feb 2026, GTC-Episoden, Cystinurie |
| Umzug nach Barcelona | `hubs/06_spain_relocation.md` | Umzug Anfang Juni 2026, Visum, Wohnung, Logistik |
| Spanisch lernen | `hubs/09_spanish_learning.md` | Aktuelles Level, Barcelona-Life-Sim-Roleplay, Streak |
| PassLocal (archiviert 2026-04-13) | `hubs/07_passlocal.md` | Next.js + Supabase + Vercel; Stripe Connect; Val als Dev |
| Blog papilov.org | `hubs/10_papilov_org.md` | Diese Site. Hugo + Cloudflare Pages, 5 Sprachen |
| Persönliches Profil | `hubs/02_personal_profile.md` | Stabile Fakten: Rolle, Standort, Präferenzen |

</div>

### Wie Vertrauen geordnet ist

`Aktuelle Konversation` ⟶ `claude-memory-Hubs` ⟶ `Granola / Drive` ⟶ `userMemories-Snapshot`. Eine spätere Schicht überschreibt *nie* eine frühere, wenn sie sich widersprechen. Granola kann einen Tag hinterher sein; userMemories Wochen.

## Was bewusst nicht hier ist

Ein persönlicher Gedächtnis-Stack definiert sich ebenso darüber, was er *nicht* speichert, wie über das, was er behält. Drei Dinge, die MEMEX bewusst vermeidet.

- **Ableitbarer Zustand.** Wenn Claude es aus dem aktuellen Repo, dem Git-Log oder einem Live-Tool-Call berechnen oder herleiten kann, geht es nicht ins Gedächtnis. Keine Architektur-Zusammenfassungen, keine Commit-Logs, keine Absätze über Code-Patterns.
- **Ephemerer Fortschritt.** Innerhalb-eines-Tages-Notizen wie &quot;ich habe gerade X gemacht&quot; überleben den nächsten Dreaming-Zyklus nicht, sofern sie sich nicht zu einer Entscheidung oder einer Statusänderung destillieren. Gedächtnis ist für Zustand, nicht für Transkripte.
- **Secrets, nie.** Pre-Commit-Hook + CI-Lint + ein 2026-04-10-Vorfall-Postmortem ([`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md)) halten `cfut_`, `ghp_`, `gho_`, `grn_`, `sk-` und lange Hex-Strings aus jedem Commit heraus. Defense-in-Depth — lokaler Hook, Server-Workflow, Rotations-Rhythmus.

## Links

<div class="table-wrap">

| Ressource | URL |
|---|---|
| Quellcode (öffentlich) | [github.com/a-pap/claude-memory](https://github.com/a-pap/claude-memory) |
| Vollständige Setup-Anleitung (Mensch + Claude) | [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) |
| Bootloader | [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) |
| Status-Snapshot | [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md) |
| Verhaltensregeln | [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) |
| Sicherheit / Vorfalls-Eintrag | [`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md) |
| LLM-lesbare Zusammenfassung | [`/memex/llms.txt`](/memex/llms.txt) |
| LLM-lesbare Volltextversion | [`/memex/llms-full.txt`](/memex/llms-full.txt) |
| Model Context Protocol (Upstream) | [modelcontextprotocol.io](https://modelcontextprotocol.io/) |

</div>

## Lizenz

Der Stack ist MIT. Der Inhalt der Hubs ist privat. Die Dokumentation, die du gerade liest, ist [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) — forke, adaptiere, schreibe sie auf dein Leben um. Wenn der Upstream-Code einen Bug hat, sind PRs willkommen. Wenn dein Fork eigenes Leben entwickelt, erzähl es mir; ich würde es gern lesen.
