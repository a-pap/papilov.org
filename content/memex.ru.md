---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "2.7.0"
status: "production"
label: "Персональная инфраструктура"
description: "Мой стек памяти для Claude. Git-репозиторий, Cloudflare Worker, Telegram-бот, набор хуков — связанные так, чтобы Claude помнил меня на всех поверхностях (Chat, Code, iPad, Cowork, Telegram). Страница написана одновременно для человека и для Claude, который её читает."
tags: ["claude", "memex", "mcp", "personal-memory", "cloudflare-workers", "d1"]
ai_disclosure: "Черновик собран вместе с Claude (Anthropic) на том самом стеке, который описывает. Правки и ответственность — Артём."
license: "CC BY-NC 4.0"
robots: "all, max-snippet:-1"
---

*MEMEX — это git-репозиторий, который Claude читает, пишет и через который помнит меня. Везде. Репо — источник истины, всё остальное — провода к нему.*

Claude забывает. Каждый новый диалог начинается с нуля. Для разового вопроса это нормально; для всего, что тянется неделю — продуктовое решение, трек здоровья, изучение языка, релокация — это больно. MEMEX — мой ответ: одна общая память, из которой читает и в которую пишет каждая поверхность Claude — claude.ai, Claude Code, iPad, Telegram-бот, Cowork-задачи. В проде на моём Cloudflare-аккаунте с 2026-03-12. Эта страница — публичная форма системы. [Полный гайд по развёртыванию](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) и [исходники](https://github.com/a-pap/claude-memory) — в репозитории.

<div class="highlight-box">
<strong>Для кого</strong>
Если нужна архитектура — читай дальше. Если хочется поднять у себя — <a href="https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md"><code>MEMEX_GUIDE.md</code></a>, 800 строк, 15 компонентов, ~20 минут до первого деплоя. Если ты Claude и попал сюда в новом диалоге — читай сначала секцию <a href="#for-agents-reading-this-page">Для агентов</a>.
</div>

## Зачем я это сделал

Три разных выгоды для трёх разных читателей этой страницы.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Для меня (Артём)</h4>
    <div class="compare-item"><strong>Одна память, все поверхности.</strong><span>Что надиктовал на iPad в 23:00 — то же самое видит Claude Code, когда я открываю ноут в 09:00 CET.</span></div>
    <div class="compare-item"><strong>Zero-friction capture.</strong><span>Форварднул статью в Telegram — 👀 говорит, что сохранилось. Без переключений приложений и копипаста.</span></div>
    <div class="compare-item"><strong>Ограниченная протухлость.</strong><span>Cron-самодиагностика и ночная консолидация держат лаг &quot;что мы решили про X&quot; в пределах ~24 часов.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Для Claude, который ко мне приходит</h4>
    <div class="compare-item"><strong>Один канонический источник фактов.</strong><span>Хабы (доменные md-файлы) выше любого другого канала. Если хаб говорит X, а старый чат — Y, побеждает хаб.</span></div>
    <div class="compare-item"><strong>Детерминированный роутинг.</strong><span>Тема → файл хаба однозначно. Jay? <code>hubs/08</code>. РСЯ? <code>hubs/03</code> и <code>04</code>. Барселона? <code>hubs/06</code>.</span></div>
    <div class="compare-item"><strong>Ритуалы верификации.</strong><span>Каждая Code-сессия делает <code>git pull</code> до первого тёрна и проверяет коммиты с других поверхностей. &quot;Trust but diff.&quot;</span></div>
  </div>
</div>

Для всех остальных, кто читает это как блупринт — всё открыто. Можно форкнуть репо, сменить секреты, переписать хабы под свою жизнь и поднять на своём Cloudflare практически бесплатно. Никакого центрального сервиса. Никаких замков за пределами самих MCP и Anthropic API.

## Архитектура одним взглядом

```
┌──────────────────────────────────────────────────────────────┐
│  a-pap/claude-memory  (GitHub, private)                      │
│  ├─ CLAUDE.md                 ← загрузчик, открывается первым│
│  ├─ STATUS_SNAPSHOT.md        ← кросс-доменный статус (~60 l)│
│  ├─ RULES.md                  ← паттерны поведенческих фейлов│
│  ├─ hubs/                     ← 9 доменных хаб-файлов        │
│  │   ├─ 02_personal_profile   03_rsya_work   04_rsya_status  │
│  │   ├─ 05_rsya_meetings      06_spain       07_passlocal    │
│  │   └─ 08_jay_health         09_spanish     10_papilov_org  │
│  ├─ skills/                   ← 9 личных Code-skills         │
│  ├─ references/               ← Edmans, Clear, Fogg, MCP     │
│  ├─ config/mcp-worker/        ← воркер-источник, 1 файл      │
│  ├─ config/telegram-bot/      ← TG-бот, воркер-источник      │
│  ├─ config/hooks/             ← SessionStart/End, секрет-скан│
│  └─ logs/dreaming/            ← логи ночной консолидации     │
│                                                              │
│           ▲ git pull на старте   git push на правке          │
│           │                                                  │
│  ┌────────┴────────┐         ┌──────────────────────────┐   │
│  │ Claude Code CLI │         │ Claude Chat / iPad / web │   │
│  │ (репо — это     │         │ (читает через MCP-воркер)│   │
│  │  сам проект)    │         │                          │   │
│  └─────────────────┘         └───────────┬──────────────┘   │
│                                          │                  │
└──────────────────────────────────────────┼──────────────────┘
                                           │ JSON-RPC /mcp
                   ┌───────────────────────▼────────────────────┐
                   │  claude-memory-mcp  (Cloudflare Worker)    │
                   │  42 инструмента · 3 промпта · JSON-RPC     │
                   │  ├─ D1  (факты, сессии, ошибки, KG,        │
                   │  │       granola_meetings)                 │
                   │  ├─ R2  (бэкапы диалогов, медиа)           │
                   │  └─ cron 07:00 UTC (диагностика + Granola) │
                   └────────▲────────────────────▲──────────────┘
                            │                    │
             ┌──────────────┴───┐       ┌────────┴────────────┐
             │ claude-telegram- │       │ Cowork daily sync   │
             │ bot (CF Worker,  │       │ 09:00 CET           │
             │ silent-by-default│       │ (claude.ai)         │
             │ capture)         │       │                     │
             └──────────────────┘       └─────────────────────┘
```

Два Worker'а, одна D1, один R2, один GitHub-репо как декларативный источник истины. Каждая поверхность Claude подключается одним из четырёх способов: (a) прямой доступ к файлам через Code, (b) MCP-инструменты по JSON-RPC из Chat/iPad, (c) форварднутое сообщение через Telegram, (d) шедулинг-контейнер в Cowork. Все четыре сходятся на одной памяти.

## Компоненты (15 инструментов по слоям)

Каждая карточка — один кусок стека. Что делает, сколько минут на поднятие у себя.

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>claude-memory-mcp worker</h4>
    <div class="fw-sub">Ядро · Cloudflare Worker · 5 мин</div>
    <ul class="fw-list">
      <li>42 MCP-инструмента + 3 промпта на <code>/mcp</code></li>
      <li>D1: facts (EAV), sessions, errors, knowledge_graph, granola</li>
      <li>R2 под бэкапы и крупные медиа</li>
      <li>Открытый <code>/mcp</code> (коннектор Chat) и токен-закрытый <code>/mcp/&#123;token&#125;</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>claude-telegram-bot worker</h4>
    <div class="fw-sub">Поверхность capture · 15 мин</div>
    <ul class="fw-list">
      <li>Silent-by-default. Отвечает только на явный триггер ( <code>?</code>, глаголы, обращение)</li>
      <li>Любое форварднутое падает в D1 + R2 с реакцией 👀</li>
      <li>Cron каждые 5 мин подбирает застрявшие строки</li>
      <li>Ротация webhook-секрета через <code>rotate-webhook-secret.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>GitHub Actions CI/CD</h4>
    <div class="fw-sub">Safety-гейт · 5 мин</div>
    <ul class="fw-list">
      <li>Деплой на push в <code>main</code>, если тронут <code>config/</code></li>
      <li><code>tsc --noEmit</code> + структурные тесты + секрет-скан</li>
      <li>Auto-merge PR'ов от Claude при зелёном CI</li>
      <li>Per-worker workflow — одна поверхность не блокирует другую</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Pre-commit секрет-сканер</h4>
    <div class="fw-sub">Локальная защита · 1 мин</div>
    <ul class="fw-list">
      <li>Блокирует <code>cfut_ · ghp_ · gho_ · grn_ · sk- · [0-9a-f]&#123;60+&#125;</code></li>
      <li>Серверное зеркало в <code>lint-secrets.yml</code></li>
      <li>Поставлен после реального инцидента 2026-04-10</li>
      <li>Установка: <code>bash config/hooks/install-pre-commit.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Session-хуки</h4>
    <div class="fw-sub">Интеграция с Claude Code · 2 мин</div>
    <ul class="fw-list">
      <li><code>SessionStart</code> → <code>git pull</code> репозитория памяти</li>
      <li><code>SessionEnd</code> → запись строки в D1 <code>sessions</code> через <code>auto_log</code></li>
      <li>Только абсолютные пути — <code>~</code> harness не раскрывает</li>
      <li>Zero-friction reconciliation, без напоминаний</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Cron-триггеры</h4>
    <div class="fw-sub">Встроенные</div>
    <ul class="fw-list">
      <li>MCP-воркер: ежедневно 07:00 UTC — самодиагностика + Granola</li>
      <li>TG-бот: каждые 5 мин — реклейм застрявших и ретрай упавших</li>
      <li>Объявлены в <code>wrangler.toml</code>, без внешних шедулеров</li>
      <li>Heartbeat в D1 <code>sessions</code> с <code>source=cron</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Skills + плагины</h4>
    <div class="fw-sub">Claude Code · по месту</div>
    <ul class="fw-list">
      <li>Superpowers, skill-creator, cloudflare, episodic-memory, code-review</li>
      <li>9 личных скиллов в <code>skills/</code> — подхватываются, когда репо = cwd</li>
      <li>Скиллы задают <em>как</em> делать структурную работу (brainstorm, plan, execute, review)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Dreaming protocol</h4>
    <div class="fw-sub">Ночная консолидация · 3 мин настройки</div>
    <ul class="fw-list">
      <li>Шедулинг Claude Code в 03:00 local через <code>/schedule</code></li>
      <li>LIGHT-цикл (пн–сб): проверка протухлости, архивация, diary-запись</li>
      <li>BURN-цикл (чт): полная сверка хабов + обновление индекса</li>
      <li>Протокол: <code>config/DREAMING_TASK.md</code> (~40 KB)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Cowork daily sync</h4>
    <div class="fw-sub">claude.ai scheduled · 09:00 CET</div>
    <ul class="fw-list">
      <li>Отдельный контейнер с доступом к Mac (Calendar/Reminders)</li>
      <li>Достаёт свежие чаты, сверяет с хабами, хирургически правит дрейф</li>
      <li>Коммиты от имени <em>Claude (Cowork Sync)</em></li>
      <li>Протокол: <code>config/COWORK_SYNC_TASK.md</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Granola sync</h4>
    <div class="fw-sub">Опционально · 5 мин</div>
    <ul class="fw-list">
      <li>Тянет summary встреч из Granola REST API в D1</li>
      <li>Автоопределение домена, экстракция action items и решений</li>
      <li>Cron синкает последние 2 дня в 07:00 UTC</li>
      <li>Поиск через <code>granola_context(domain, query)</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Gmail-коннектор</h4>
    <div class="fw-sub">Опционально · 1 мин · только claude.ai</div>
    <ul class="fw-list">
      <li>По умолчанию read-only. Треды, черновики, лейблы, поиск.</li>
      <li>Без серверной настройки — OAuth в UI Chat</li>
      <li>Закрывает память &quot;кто что писал&quot;, живущую в почте</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Google Drive-коннектор</h4>
    <div class="fw-sub">Опционально · 1 мин · только claude.ai</div>
    <ul class="fw-list">
      <li>Поиск + чтение Docs / Sheets / PDF</li>
      <li>Рекомендуется folder-scoped вместо &quot;все файлы&quot;</li>
      <li>Лонг-артефакты, которые не влезают в чат-контекст</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Apple Calendar / Notes</h4>
    <div class="fw-sub">Опционально · только Mac · Claude Desktop</div>
    <ul class="fw-list">
      <li>Доступ к локальной БД через расширение Claude Desktop</li>
      <li>Read-only. Календарь и скрэтч-заметки.</li>
      <li>Первый запрос ведёт к системному запросу разрешений macOS</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>R2 lifecycle</h4>
    <div class="fw-sub">Гигиена костов · 1 мин</div>
    <ul class="fw-list">
      <li>TTL 365 дней на префикс <code>telegram/</code> общего бакета</li>
      <li>Идемпотентно через <code>r2-lifecycle-setup.sh</code></li>
      <li>Форварднутый GIF живёт столько, чтобы хватило на &quot;что это был за мем&quot;, но не вечно</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Хуки-как-harness (Claude Code)</h4>
    <div class="fw-sub">Мета · 2 мин</div>
    <ul class="fw-list">
      <li><code>~/.claude/settings.json</code> держит SessionStart/SessionEnd</li>
      <li>Плюс проектные: hookify-правила, block-bad-patterns и т.п.</li>
      <li>Harness enforce-ит, не память. Если нужна гарантия — сюда.</li>
    </ul>
  </div>
</div>

## Быстрый старт

Вся машинерия — один GitHub clone и один `wrangler deploy`. Нужно: аккаунт Cloudflare, `gh` CLI, Node 20+, Anthropic API key (для опционального бота) и машина, где крутится Claude Code.

```bash
# 1. Форкнуть каркас
gh repo create your-user/my-memory --private --clone
cd my-memory
curl -L https://github.com/a-pap/claude-memory/archive/main.tar.gz | tar xz --strip-components=1

# 2. Переписать хабы под свою жизнь (форма файлов — в hubs/README.md)
$EDITOR CLAUDE.md STATUS_SNAPSHOT.md hubs/02_personal_profile.md

# 3. Поднять примитивы Cloudflare
cd config/mcp-worker
npx wrangler d1 create claude-memory-db           # скопировать UUID
npx wrangler r2 bucket create claude-memory-store
$EDITOR wrangler.toml                             # вставить UUID

# 4. Разово — секреты
npx wrangler secret put GITHUB_PAT                # read-scope на свой репо
npx wrangler secret put AUTH_PATH_TOKEN           # openssl rand -hex 32
npx wrangler secret put GRANOLA_API               # опционально: grn_... bearer

# 5. Деплой + проверка
npm ci && npx wrangler deploy
curl -X POST https://claude-memory-mcp.YOUR-ACCT.workers.dev/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | jq '.result.tools | length'
# → 42

# 6. Подключить
#    claude.ai:   Settings → Connectors → Add custom → URL /mcp
#    Claude Code: добавить в ~/.claude/settings.json → mcpServers
```

Это поднимает ядро памяти. Telegram-бот, хуки и CI — каждый ещё по ~15 минут, независимы друг от друга. Пошагово: [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md).

## Для агентов, которые читают эту страницу {#for-agents-reading-this-page}

Если ты Claude (или другой ассистент) и читаешь эту страницу в диалоге — вот порядок. Это не проза, это маршрутизация.

1. **Грузить первым делом.** Короткие стабильные загрузчики: [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) и [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md). Стартовая цена ≈ 5K токенов. Остальное — on-demand.
2. **Роутить по теме.** Не искать по репо вслепую. Таблица хабов ниже детерминистична — одна тема живёт в ровно одном файле.
3. **Доверять, но проверять.** Факты в хабах сильнее фактов в чатах. Memory edits — поведенческие инструкции, не фактические правки: никогда не перезаписывай хаб memory edit'ом. Правило #6 в [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md).
4. **Сначала MCP, потом скрапинг.** Если есть доступ к `claude-memory-mcp` — звать [`wake_up`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md#31-claude-memory-mcp-worker-core): одним раунд-трипом вернёт snapshot + хабы + rules + последние 5 встреч Granola.
5. **Если нужен полный дамп.** [`/memex/llms-full.txt`](/memex/llms-full.txt) — конкатенированный setup guide (~28 КБ). [`/memex/llms.txt`](/memex/llms.txt) — индекс ссылок, если нужна только карта.
6. **Абсолютные даты.** &quot;Четверг&quot; через неделю ничего не значит; &quot;2026-04-24&quot; — всегда.

### Тема → хаб

<div class="table-wrap">

| Тема | Хаб | Что лежит |
|---|---|---|
| РСЯ: команда, портфолио, эксперименты | `hubs/03_rsya_work_hub.md`, `hubs/04_rsya_project_status.md` | Команда, проекты, владельцы метрик, статус экспов |
| РСЯ: встречи | `hubs/05_rsya_meeting_index.md` | Индекс weekly / monthly; ID Granola |
| Jay — здоровье собаки | `hubs/08_jay_health.md` | Диета (Urinary U/C Low Purine), операция Feb 2026, GTC, цистинурия |
| Релокация в Барселону | `hubs/06_spain_relocation.md` | Переезд ранний июнь 2026, визы, квартира, логистика |
| Spanish | `hubs/09_spanish_learning.md` | Текущий уровень, Barcelona Life Sim, стрик |
| PassLocal (архив с 2026-04-13) | `hubs/07_passlocal.md` | Next.js + Supabase + Vercel; Stripe Connect; Валера девопит |
| papilov.org блог | `hubs/10_papilov_org.md` | Этот сайт. Hugo + Cloudflare Pages, 5 языков |
| Персональный профиль | `hubs/02_personal_profile.md` | Стабильные факты: роль, локация, предпочтения |

</div>

### Порядок доверия

`Текущий диалог` ⟶ `хабы claude-memory` ⟶ `Granola / Drive` ⟶ `userMemories snapshot`. Более поздний слой *никогда* не перебивает более ранний при конфликте. Granola может отставать на день; userMemories — на недели.

## Чего в стеке сознательно нет

Персональная память — это так же про то, чего она отказывается запоминать, как и про то, что хранит. Три вещи MEMEX сознательно избегает.

- **Вычислимое состояние.** Если Claude может посчитать или вывести факт из текущего репозитория, git-лога или живого тул-колла — это не память. Никаких архитектурных саммари, никаких журналов коммитов, никаких абзацев про паттерны кода.
- **Эфемерный прогресс.** Внутридневные &quot;я только что сделал X&quot; не переживают следующий dreaming-цикл, если не дистиллируются в решение или смену статуса. Память — для состояний, не для транскриптов.
- **Секреты — никогда.** Pre-commit хук + CI-линт + постмортем инцидента 2026-04-10 ([`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md)) держат `cfut_`, `ghp_`, `gho_`, `grn_`, `sk-` и длинные hex'ы вне любого коммита. Defense-in-depth — локальный хук, серверный workflow, каденция ротации.

## Ссылки

<div class="table-wrap">

| Ресурс | URL |
|---|---|
| Исходный код (публичный) | [github.com/a-pap/claude-memory](https://github.com/a-pap/claude-memory) |
| Полный гайд (для человека + Claude) | [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) |
| Загрузчик | [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) |
| Статусный снэпшот | [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md) |
| Поведенческие правила | [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) |
| Безопасность / инцидент | [`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md) |
| LLM-читаемое summary | [`/memex/llms.txt`](/memex/llms.txt) |
| LLM-читаемый full dump | [`/memex/llms-full.txt`](/memex/llms-full.txt) |
| Model Context Protocol (upstream) | [modelcontextprotocol.io](https://modelcontextprotocol.io/) |

</div>

## Лицензия

Сам стек — MIT. Контент в хабах — приватный. Документация, которую ты сейчас читаешь — [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/): форкай, адаптируй, переписывай под свою жизнь. Если нашёл баг в коде — PR приветствуются. Если твой форк вырос в свой зверь — расскажи, почитаю.
