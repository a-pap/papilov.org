---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "2.7.0"
status: "production"
label: "Personal infrastructure"
description: "My Claude memory stack. A git repository, a Cloudflare Worker, a Telegram bot, a handful of hooks — wired together so Claude remembers me across every surface (Chat, Code, iPad, Cowork, Telegram). This page is written for a human reader and for Claude reading it. Both at once."
tags: ["claude", "memex", "mcp", "personal-memory", "cloudflare-workers", "d1"]
ai_disclosure: "Drafted with Claude (Anthropic) on the stack it describes. Edited and owned by Artem."
license: "CC BY-NC 4.0"
robots: "all, max-snippet:-1"
---

*Think of MEMEX as a git repo that Claude can read, write, and remember you through — on every surface. The repo is the truth; everything else is a wire to it.*

Claude forgets. Every new conversation starts blank. That is fine for a random question and painful for anything that spans a week — a product decision, a health thread, a language-learning arc, a relocation. MEMEX is my answer: a single shared memory that every Claude surface — claude.ai, Claude Code, the iPad app, the Telegram bot, Cowork scheduled tasks — reads from and writes to. It has been running in production on my Cloudflare account since 2026-03-12. This page is the public, human-readable shape of it. The [full setup guide](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) and the [source code](https://github.com/a-pap/claude-memory) are in the repo.

<div class="highlight-box">
<strong>Who this is for</strong>
If you want the architecture: keep reading. If you want to run it on your own Cloudflare: go to <a href="https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md"><code>MEMEX_GUIDE.md</code></a> — 800 lines, 15-tool setup, ~20 min to first deploy. If you are Claude and you landed on this page in a new conversation: read the <a href="#for-agents-reading-this-page">For agents reading this page</a> section first.
</div>

## Why I built it

Three outcomes for three different readers of this page.

<div class="compare">
  <div class="compare-col col-a">
    <h4>For me (Artem)</h4>
    <div class="compare-item"><strong>One memory, every surface.</strong><span>Whatever I dictated to Claude on the iPad at 11pm is what Claude Code sees when I open my laptop at 09:00 CET.</span></div>
    <div class="compare-item"><strong>Zero-friction capture.</strong><span>Forward an article to Telegram, a link-reaction 👀 tells me it landed. No app switching, no copy-paste.</span></div>
    <div class="compare-item"><strong>Bounded staleness.</strong><span>A cron self-diagnostic and a nightly consolidation mean &quot;what did we decide about X&quot; is never more than ~24h stale.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>For Claude visiting me</h4>
    <div class="compare-item"><strong>One canonical source of facts.</strong><span>Hubs (domain-specific markdown files) beat every other channel. If a hub says X and an old chat says Y, the hub wins.</span></div>
    <div class="compare-item"><strong>Stable routing.</strong><span>Topic → hub file is deterministic. Jay health? <code>hubs/08</code>. RSYa work? <code>hubs/03</code> and <code>hubs/04</code>. Barcelona relocation? <code>hubs/06</code>.</span></div>
    <div class="compare-item"><strong>Verification rituals.</strong><span>Every Code session pulls the repo before the first turn and verifies commits from other surfaces. &quot;Trust but diff.&quot;</span></div>
  </div>
</div>

And for anyone reading this as a blueprint — the whole thing is open. You can fork the repo, rotate the secrets, rewrite the hubs to your own life, and run it on your own Cloudflare account for roughly free. No central service. No vendor lock-in beyond the MCP and Anthropic APIs themselves.

## Architecture at a glance

```
┌──────────────────────────────────────────────────────────────┐
│  a-pap/claude-memory  (GitHub, private)                      │
│  ├─ CLAUDE.md                 ← bootloader, loads at start   │
│  ├─ STATUS_SNAPSHOT.md        ← cross-domain status (~60 ln) │
│  ├─ RULES.md                  ← behavioral failure patterns  │
│  ├─ hubs/                     ← 9 domain hub files           │
│  │   ├─ 02_personal_profile   03_rsya_work   04_rsya_status  │
│  │   ├─ 05_rsya_meetings      06_spain       07_passlocal    │
│  │   └─ 08_jay_health         09_spanish     10_papilov_org  │
│  ├─ skills/                   ← 9 personal Code skills       │
│  ├─ references/               ← Edmans, Clear, Fogg, MCP     │
│  ├─ config/mcp-worker/        ← Worker source, 1 file        │
│  ├─ config/telegram-bot/      ← TG bot Worker source         │
│  ├─ config/hooks/             ← SessionStart/End, secret scan│
│  └─ logs/dreaming/            ← nightly consolidation logs   │
│                                                              │
│           ▲ git pull on session start      git push on edit  │
│           │                                                  │
│  ┌────────┴────────┐         ┌──────────────────────────┐   │
│  │ Claude Code CLI │         │ Claude Chat / iPad / web │   │
│  │ (this repo IS   │         │ (reads via MCP worker)   │   │
│  │  the project)   │         │                          │   │
│  └─────────────────┘         └───────────┬──────────────┘   │
│                                          │                  │
└──────────────────────────────────────────┼──────────────────┘
                                           │ JSON-RPC /mcp
                   ┌───────────────────────▼────────────────────┐
                   │  claude-memory-mcp  (Cloudflare Worker)    │
                   │  42 tools · 3 prompts · JSON-RPC           │
                   │  ├─ D1  (facts, sessions, errors, KG,      │
                   │  │       granola_meetings)                 │
                   │  ├─ R2  (conversation backups, media)      │
                   │  └─ cron 07:00 UTC (diagnostic + Granola)  │
                   └────────▲────────────────────▲──────────────┘
                            │                    │
             ┌──────────────┴───┐       ┌────────┴────────────┐
             │ claude-telegram- │       │ Cowork daily sync   │
             │ bot (CF Worker,  │       │ 09:00 CET           │
             │ silent-by-default│       │ (claude.ai)         │
             │ capture)         │       │                     │
             └──────────────────┘       └─────────────────────┘
```

Two Workers, one shared D1 database, one shared R2 bucket, one GitHub repo as the declarative source of truth. Every Claude surface connects through one of four paths: (a) direct filesystem access via Code, (b) MCP tools over JSON-RPC via Chat/iPad, (c) forwarded message via Telegram, (d) scheduled container via Cowork. All four converge on the same memory.

## Components (15 tools, grouped by layer)

Each card is one piece of the stack — what it does, and (when relevant) how many minutes to stand it up on your own Cloudflare account.

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>claude-memory-mcp worker</h4>
    <div class="fw-sub">Core · Cloudflare Worker · 5 min</div>
    <ul class="fw-list">
      <li>42 MCP tools + 3 MCP prompts over <code>/mcp</code></li>
      <li>D1 schema: facts (EAV), sessions, errors, knowledge graph, granola</li>
      <li>R2 for backups and large media</li>
      <li>Both open <code>/mcp</code> (Chat connector) and token-gated <code>/mcp/{token}</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>claude-telegram-bot worker</h4>
    <div class="fw-sub">Capture surface · 15 min</div>
    <ul class="fw-list">
      <li>Silent-by-default. Only replies on explicit trigger ( <code>?</code>, verbs, vocative)</li>
      <li>Persists every forwarded message to D1 + R2 with a 👀 reaction</li>
      <li>Cron every 5 min reclaims stuck rows</li>
      <li>Webhook-secret rotation via <code>rotate-webhook-secret.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>GitHub Actions CI/CD</h4>
    <div class="fw-sub">Safety gate · 5 min</div>
    <ul class="fw-list">
      <li>Deploy on push to <code>main</code> touching <code>config/</code></li>
      <li><code>tsc --noEmit</code> + structural tests + secret scan</li>
      <li>Auto-merge Claude-authored PRs on green</li>
      <li>Per-worker deploy workflows — one surface can't block another</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Pre-commit secret scanner</h4>
    <div class="fw-sub">Local defense · 1 min</div>
    <ul class="fw-list">
      <li>Blocks <code>cfut_ · ghp_ · gho_ · grn_ · sk- · [0-9a-f]&#123;60+&#125;</code></li>
      <li>Mirror on server side via <code>lint-secrets.yml</code></li>
      <li>Shipped after a real incident on 2026-04-10</li>
      <li>Install: <code>bash config/hooks/install-pre-commit.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Session hooks</h4>
    <div class="fw-sub">Claude Code integration · 2 min</div>
    <ul class="fw-list">
      <li><code>SessionStart</code> → <code>git pull</code> the memory repo</li>
      <li><code>SessionEnd</code> → auto-log a D1 sessions row via <code>auto_log</code></li>
      <li>Absolute paths only — no <code>~</code> expansion in the harness</li>
      <li>Zero-friction reconciliation, no prompting</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Cron triggers</h4>
    <div class="fw-sub">Built-in</div>
    <ul class="fw-list">
      <li>MCP worker: daily 07:00 UTC — self-diagnostic + Granola sync</li>
      <li>TG bot: every 5 min — reclaim stuck / retry failed rows</li>
      <li>Declared in <code>wrangler.toml</code>, no external scheduler</li>
      <li>Heartbeat lands in D1 <code>sessions</code> with <code>source=cron</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Skills + plugins</h4>
    <div class="fw-sub">Claude Code · variable</div>
    <ul class="fw-list">
      <li>Superpowers, skill-creator, cloudflare, episodic-memory, code-review</li>
      <li>9 personal skills in <code>skills/</code> — auto-discovered when the repo is cwd</li>
      <li>Skills define <em>how</em> to do structured work (brainstorm, plan, execute, review)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Dreaming protocol</h4>
    <div class="fw-sub">Nightly consolidation · 3 min to schedule</div>
    <ul class="fw-list">
      <li>Scheduled Claude Code session at 03:00 local via <code>/schedule</code></li>
      <li>LIGHT cycle (Mon–Sat): staleness check, archive, diary entry</li>
      <li>BURN cycle (Thu): full hub reconciliation + index refresh</li>
      <li>Protocol: <code>config/DREAMING_TASK.md</code> (~40 KB)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Cowork daily sync</h4>
    <div class="fw-sub">claude.ai scheduled task · 09:00 CET</div>
    <ul class="fw-list">
      <li>Runs in a dedicated container with Mac reach (Calendar/Reminders)</li>
      <li>Pulls recent chats, compares to hubs, surgically edits what drifted</li>
      <li>Commits under <em>Claude (Cowork Sync)</em> author</li>
      <li>Protocol: <code>config/COWORK_SYNC_TASK.md</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Granola sync</h4>
    <div class="fw-sub">Optional · 5 min</div>
    <ul class="fw-list">
      <li>Pulls meeting summaries from Granola REST API into D1</li>
      <li>Auto-detected domain, extracted action items and decisions</li>
      <li>Cron syncs last 2 days at 07:00 UTC</li>
      <li>Search via <code>granola_context(domain, query)</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Gmail connector</h4>
    <div class="fw-sub">Optional · 1 min · claude.ai-only</div>
    <ul class="fw-list">
      <li>Read-only by default. Threads, drafts, labels, search.</li>
      <li>No server-side setup — OAuth in the Chat UI</li>
      <li>Covers the "who said what" memory that lives in email</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Google Drive connector</h4>
    <div class="fw-sub">Optional · 1 min · claude.ai-only</div>
    <ul class="fw-list">
      <li>Search + read Docs / Sheets / PDFs</li>
      <li>Folder-scoped recommended over all-files</li>
      <li>Long-form artifacts that outgrow chat context</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Apple Calendar / Notes</h4>
    <div class="fw-sub">Optional · Mac-only · Claude Desktop</div>
    <ul class="fw-list">
      <li>Local DB access via Claude Desktop extension</li>
      <li>Read-only. Schedule context and scratch notes</li>
      <li>First query triggers a native macOS permission prompt</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>R2 lifecycle</h4>
    <div class="fw-sub">Cost hygiene · 1 min</div>
    <ul class="fw-list">
      <li>365-day TTL on <code>telegram/</code> prefix of the shared bucket</li>
      <li>Idempotent setup via <code>r2-lifecycle-setup.sh</code></li>
      <li>Forwarded GIF lives long enough for "what was that meme", not forever</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Hooks-as-harness (Claude Code)</h4>
    <div class="fw-sub">Meta · 2 min</div>
    <ul class="fw-list">
      <li><code>~/.claude/settings.json</code> wires SessionStart/SessionEnd</li>
      <li>Plus per-project hooks: hookify rules, block-bad-patterns, etc.</li>
      <li>Harness enforces, not memory. If you want guaranteed behavior, it goes here.</li>
    </ul>
  </div>
</div>

## Quick start

The whole thing is one GitHub clone and one `wrangler deploy` away. Prerequisites: Cloudflare account, `gh` CLI, Node 20+, Anthropic API key (for the optional bot), and one machine where you use Claude Code.

```bash
# 1. Fork the skeleton
gh repo create your-user/my-memory --private --clone
cd my-memory
curl -L https://github.com/a-pap/claude-memory/archive/main.tar.gz | tar xz --strip-components=1

# 2. Rewrite hubs to your life (see hubs/README.md for the file shape)
$EDITOR CLAUDE.md STATUS_SNAPSHOT.md hubs/02_personal_profile.md

# 3. Provision Cloudflare primitives
cd config/mcp-worker
npx wrangler d1 create claude-memory-db           # copy the UUID
npx wrangler r2 bucket create claude-memory-store
$EDITOR wrangler.toml                             # paste the UUID

# 4. One-time secrets
npx wrangler secret put GITHUB_PAT                # read scope on your repo
npx wrangler secret put AUTH_PATH_TOKEN           # openssl rand -hex 32
npx wrangler secret put GRANOLA_API               # optional: grn_... bearer

# 5. Deploy + verify
npm ci && npx wrangler deploy
curl -X POST https://claude-memory-mcp.YOUR-ACCT.workers.dev/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | jq '.result.tools | length'
# → 42

# 6. Connect it
#    claude.ai:   Settings → Connectors → Add custom → /mcp URL
#    Claude Code: add to ~/.claude/settings.json → mcpServers
```

That gets you the core memory surface. The Telegram bot, hooks, and CI each add ~15 minutes and are independent. Full tool-by-tool instructions: [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md).

## For agents reading this page {#for-agents-reading-this-page}

If you are Claude (or any assistant) reading this page in a conversation, the best way to use this content is in this order. This is not prose — it is routing.

1. **Load first.** The short, stable bootloaders: [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) and [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md). Combined startup cost ≈ 5K tokens. Everything else loads on demand.
2. **Route by topic.** Don't search the repo blindly. The hub table below is deterministic — one topic lives in exactly one canonical file.
3. **Trust, but verify.** Facts in hubs dominate facts in chat logs. Memory edits are behavioral instructions, not factual corrections — never use a memory edit to overwrite a hub. Rule #6 in [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md).
4. **Prefer the MCP tool layer over scraping.** If you have access to the `claude-memory-mcp` worker, call [`wake_up`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md#31-claude-memory-mcp-worker-core) — it returns the snapshot + hubs + rules + last 5 Granola meetings in one round-trip.
5. **Ingest the full dump if you need it.** [`/memex/llms-full.txt`](/memex/llms-full.txt) is the concatenated human+Claude-readable setup guide (~28 KB). [`/memex/llms.txt`](/memex/llms.txt) is a link index if you only want the map.
6. **Respect absolute dates.** "Thursday" means nothing a week later; "2026-04-24" always does.

### Topic-to-hub routing

<div class="table-wrap">

| Topic | Hub | What lives there |
|---|---|---|
| Yandex RSYa work, portfolio, experiments | `hubs/03_rsya_work_hub.md`, `hubs/04_rsya_project_status.md` | Team, projects, metric owners, experiment status |
| RSYa meetings | `hubs/05_rsya_meeting_index.md` | Index of weekly / monthlies; Granola IDs |
| Jay — dog health | `hubs/08_jay_health.md` | Diet (Urinary U/C Low Purine), surgery Feb 2026, GTC episodes, cystinuria |
| Barcelona relocation | `hubs/06_spain_relocation.md` | Early June 2026 move, visa, apartment, logistics |
| Spanish learning | `hubs/09_spanish_learning.md` | Current level, Barcelona Life Sim roleplay, streak |
| PassLocal (archived 2026-04-13) | `hubs/07_passlocal.md` | Next.js + Supabase + Vercel; Stripe Connect; Val as dev |
| papilov.org blog | `hubs/10_papilov_org.md` | This site. Hugo + Cloudflare Pages, 5 langs |
| Personal profile | `hubs/02_personal_profile.md` | Stable facts: role, location, preferences |

</div>

### How trust is ordered

`Current conversation` ⟶ `claude-memory hubs` ⟶ `Granola / Drive` ⟶ `userMemories snapshot`. A later layer *never* overrides an earlier one when they conflict. Granola may lag a day; userMemories may lag weeks.

## What is deliberately not here

A personal memory stack is as much about what it *refuses* to remember as what it stores. Three things MEMEX deliberately avoids.

- **Derivable state.** If Claude can compute or infer it from the current repo, the git log, or a live tool call, it doesn't go in memory. No architecture summaries, no commit logs, no code-patterns paragraphs.
- **Ephemeral progress.** Intra-day "I just did X" notes don't survive the next dreaming cycle unless they distill to a decision or a status change. Memory is for state, not transcripts.
- **Secrets, ever.** Pre-commit hook + CI lint + a 2026-04-10 incident postmortem ([`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md)) keep `cfut_`, `ghp_`, `gho_`, `grn_`, `sk-`, and long hex out of every commit. Defense-in-depth — local hook, server-side workflow, rotation cadence.

## Links

<div class="table-wrap">

| Resource | URL |
|---|---|
| Source code (public) | [github.com/a-pap/claude-memory](https://github.com/a-pap/claude-memory) |
| Full setup guide (human + Claude) | [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) |
| Bootloader | [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) |
| Status snapshot | [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md) |
| Behavioral rules | [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) |
| Security / incident record | [`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md) |
| LLM-readable summary | [`/memex/llms.txt`](/memex/llms.txt) |
| LLM-readable full content | [`/memex/llms-full.txt`](/memex/llms-full.txt) |
| Model Context Protocol (upstream) | [modelcontextprotocol.io](https://modelcontextprotocol.io/) |

</div>

## License

The stack is MIT. The content in hubs is private. The documentation you're reading is [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) — fork, adapt, rewrite to your life. If the upstream code has a bug, PRs welcome. If your fork grows teeth, tell me; I'd like to read it.
