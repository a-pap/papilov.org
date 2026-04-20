---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "2.7.0"
status: "production"
label: "Infraestructura personal"
description: "Mi stack de memoria para Claude. Un repositorio Git, un Cloudflare Worker, un bot de Telegram y un puñado de hooks — conectados para que Claude me recuerde en cada superficie (Chat, Code, iPad, Cowork, Telegram). Esta página está escrita a la vez para una lectora humana y para Claude cuando la lee. Ambos a la vez."
tags: ["claude", "memex", "mcp", "personal-memory", "cloudflare-workers", "d1"]
ai_disclosure: "Redactado con Claude (Anthropic) sobre el stack que describe. Edición y responsabilidad: Artem."
license: "CC BY-NC 4.0"
robots: "all, max-snippet:-1"
---

*Piensa en MEMEX como un repositorio Git que Claude puede leer, escribir, y a través del cual me recuerda — en cada superficie. El repo es la verdad; todo lo demás son cables hacia él.*

Claude olvida. Cada conversación nueva empieza en blanco. Está bien para una pregunta puntual y duele para cualquier cosa que dure una semana — una decisión de producto, un hilo de salud, un arco de aprendizaje de idioma, una reubicación. MEMEX es mi respuesta: una memoria compartida que todas las superficies de Claude — claude.ai, Claude Code, la app de iPad, el bot de Telegram, las tareas programadas de Cowork — leen y escriben. Lleva en producción en mi cuenta de Cloudflare desde el 2026-03-12. Esta página es la forma pública y legible para humanos del sistema. La [guía completa de instalación](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) y el [código fuente](https://github.com/a-pap/claude-memory) están en el repositorio.

<div class="highlight-box">
<strong>Para quién es esto</strong>
Si quieres la arquitectura: sigue leyendo. Si quieres ponerlo a correr en tu propio Cloudflare: ve a <a href="https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md"><code>MEMEX_GUIDE.md</code></a> — 800 líneas, 15 componentes, ~20 min hasta el primer despliegue. Si eres Claude y caíste en esta página en una conversación nueva: lee primero la sección <a href="#for-agents-reading-this-page">Para agentes que leen esta página</a>.
</div>

## Por qué lo construí

Tres resultados para tres lectores distintos de esta página.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Para mí (Artem)</h4>
    <div class="compare-item"><strong>Una memoria, cada superficie.</strong><span>Lo que le dicté a Claude en el iPad a las 23:00 es lo que Claude Code ve cuando abro el portátil a las 09:00 CET.</span></div>
    <div class="compare-item"><strong>Captura sin fricción.</strong><span>Reenvío un artículo a Telegram, una reacción 👀 me confirma que quedó guardado. Sin cambiar de app, sin copiar y pegar.</span></div>
    <div class="compare-item"><strong>Obsolescencia acotada.</strong><span>Un cron de autodiagnóstico y una consolidación nocturna mantienen &quot;qué decidimos sobre X&quot; en un máximo de ~24 h de desfase.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Para Claude cuando me visita</h4>
    <div class="compare-item"><strong>Una fuente canónica de hechos.</strong><span>Los hubs (archivos Markdown por dominio) ganan sobre cualquier otro canal. Si el hub dice X y un chat viejo dice Y, gana el hub.</span></div>
    <div class="compare-item"><strong>Ruteo estable.</strong><span>Tema → archivo de hub es determinista. ¿Salud de Jay? <code>hubs/08</code>. ¿Trabajo en RSYa? <code>hubs/03</code> y <code>hubs/04</code>. ¿Mudanza a Barcelona? <code>hubs/06</code>.</span></div>
    <div class="compare-item"><strong>Rituales de verificación.</strong><span>Cada sesión de Code hace <code>git pull</code> antes del primer turno y verifica los commits hechos desde otras superficies. &quot;Trust but diff.&quot;</span></div>
  </div>
</div>

Y para quien lea esto como plano de construcción — todo está abierto. Puedes forkear el repo, rotar los secretos, reescribir los hubs a tu propia vida y ponerlo a correr en tu cuenta de Cloudflare prácticamente gratis. Sin servicio central. Sin bloqueo de proveedor más allá de las APIs de MCP y Anthropic.

## Arquitectura de un vistazo

```
┌──────────────────────────────────────────────────────────────┐
│  a-pap/claude-memory  (GitHub, privado)                      │
│  ├─ CLAUDE.md                 ← bootloader, se carga primero │
│  ├─ STATUS_SNAPSHOT.md        ← estado cross-dominio (~60 ln)│
│  ├─ RULES.md                  ← patrones de fallo conductual │
│  ├─ hubs/                     ← 9 archivos de hub por dominio│
│  │   ├─ 02_personal_profile   03_rsya_work   04_rsya_status  │
│  │   ├─ 05_rsya_meetings      06_spain       07_passlocal    │
│  │   └─ 08_jay_health         09_spanish     10_papilov_org  │
│  ├─ skills/                   ← 9 skills personales de Code  │
│  ├─ references/               ← Edmans, Clear, Fogg, MCP     │
│  ├─ config/mcp-worker/        ← fuente del worker, 1 archivo │
│  ├─ config/telegram-bot/      ← fuente del bot de Telegram   │
│  ├─ config/hooks/             ← SessionStart/End, scan secret│
│  └─ logs/dreaming/            ← logs de consolidación nocturna│
│                                                              │
│           ▲ git pull al empezar sesión   git push al editar  │
│           │                                                  │
│  ┌────────┴────────┐         ┌──────────────────────────┐   │
│  │ Claude Code CLI │         │ Claude Chat / iPad / web │   │
│  │ (este repo ES   │         │ (lee vía el MCP worker)  │   │
│  │  el proyecto)   │         │                          │   │
│  └─────────────────┘         └───────────┬──────────────┘   │
│                                          │                  │
└──────────────────────────────────────────┼──────────────────┘
                                           │ JSON-RPC /mcp
                   ┌───────────────────────▼────────────────────┐
                   │  claude-memory-mcp  (Cloudflare Worker)    │
                   │  42 tools · 3 prompts · JSON-RPC           │
                   │  ├─ D1  (hechos, sesiones, errores, KG,    │
                   │  │       granola_meetings)                 │
                   │  ├─ R2  (backups de conversación, medios)  │
                   │  └─ cron 07:00 UTC (diagnóstico + Granola) │
                   └────────▲────────────────────▲──────────────┘
                            │                    │
             ┌──────────────┴───┐       ┌────────┴────────────┐
             │ claude-telegram- │       │ Cowork daily sync   │
             │ bot (CF Worker,  │       │ 09:00 CET           │
             │ captura silencio-│       │ (claude.ai)         │
             │ sa por defecto)  │       │                     │
             └──────────────────┘       └─────────────────────┘
```

Dos Workers, una base D1 compartida, un bucket R2 compartido, un repositorio de GitHub como fuente declarativa de verdad. Cada superficie de Claude se conecta por una de cuatro rutas: (a) acceso directo al sistema de archivos vía Code, (b) herramientas MCP por JSON-RPC vía Chat/iPad, (c) mensaje reenviado vía Telegram, (d) contenedor programado vía Cowork. Las cuatro convergen en la misma memoria.

## Componentes (15 herramientas, por capa)

Cada tarjeta es una pieza del stack — qué hace y (cuando es relevante) cuántos minutos cuesta levantarlo en tu propia cuenta de Cloudflare.

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>claude-memory-mcp worker</h4>
    <div class="fw-sub">Núcleo · Cloudflare Worker · 5 min</div>
    <ul class="fw-list">
      <li>42 herramientas MCP + 3 prompts MCP sobre <code>/mcp</code></li>
      <li>Esquema D1: facts (EAV), sessions, errors, knowledge_graph, granola</li>
      <li>R2 para backups y medios grandes</li>
      <li><code>/mcp</code> abierto (conector de Chat) y <code>/mcp/&#123;token&#125;</code> con token</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>claude-telegram-bot worker</h4>
    <div class="fw-sub">Superficie de captura · 15 min</div>
    <ul class="fw-list">
      <li>Silencioso por defecto. Solo responde a triggers explícitos ( <code>?</code>, verbos, vocativos)</li>
      <li>Persiste cada mensaje reenviado a D1 + R2 con una reacción 👀</li>
      <li>Cron cada 5 min recupera filas atascadas</li>
      <li>Rotación del webhook secret vía <code>rotate-webhook-secret.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>GitHub Actions CI/CD</h4>
    <div class="fw-sub">Compuerta de seguridad · 5 min</div>
    <ul class="fw-list">
      <li>Despliegue al hacer push a <code>main</code> tocando <code>config/</code></li>
      <li><code>tsc --noEmit</code> + tests estructurales + scan de secretos</li>
      <li>Auto-merge de PRs de Claude cuando el CI está verde</li>
      <li>Workflows por worker — una superficie no bloquea a la otra</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Scanner pre-commit de secretos</h4>
    <div class="fw-sub">Defensa local · 1 min</div>
    <ul class="fw-list">
      <li>Bloquea <code>cfut_ · ghp_ · gho_ · grn_ · sk- · [0-9a-f]&#123;60+&#125;</code></li>
      <li>Espejo del lado del servidor en <code>lint-secrets.yml</code></li>
      <li>Desplegado tras un incidente real el 2026-04-10</li>
      <li>Instalar: <code>bash config/hooks/install-pre-commit.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Hooks de sesión</h4>
    <div class="fw-sub">Integración con Claude Code · 2 min</div>
    <ul class="fw-list">
      <li><code>SessionStart</code> → <code>git pull</code> del repo de memoria</li>
      <li><code>SessionEnd</code> → registro automático en D1 <code>sessions</code> vía <code>auto_log</code></li>
      <li>Solo rutas absolutas — el harness no expande <code>~</code></li>
      <li>Reconciliación sin fricción, sin necesidad de pedirla</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Triggers cron</h4>
    <div class="fw-sub">Integrados</div>
    <ul class="fw-list">
      <li>MCP worker: diario 07:00 UTC — autodiagnóstico + sync de Granola</li>
      <li>TG bot: cada 5 min — recupera atascadas / reintenta fallidas</li>
      <li>Declarados en <code>wrangler.toml</code>, sin planificador externo</li>
      <li>Heartbeat en D1 <code>sessions</code> con <code>source=cron</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Skills + plugins</h4>
    <div class="fw-sub">Claude Code · variable</div>
    <ul class="fw-list">
      <li>Superpowers, skill-creator, cloudflare, episodic-memory, code-review</li>
      <li>9 skills personales en <code>skills/</code> — autodescubiertos cuando el repo es cwd</li>
      <li>Los skills definen <em>cómo</em> hacer trabajo estructurado (brainstorm, plan, ejecutar, revisar)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Protocolo Dreaming</h4>
    <div class="fw-sub">Consolidación nocturna · 3 min para programar</div>
    <ul class="fw-list">
      <li>Sesión programada de Claude Code a las 03:00 local vía <code>/schedule</code></li>
      <li>Ciclo LIGHT (lun–sáb): chequeo de obsolescencia, archivo, entrada de diario</li>
      <li>Ciclo BURN (jue): reconciliación completa de hubs + refresco del índice</li>
      <li>Protocolo: <code>config/DREAMING_TASK.md</code> (~40 KB)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Sync diaria de Cowork</h4>
    <div class="fw-sub">Tarea programada en claude.ai · 09:00 CET</div>
    <ul class="fw-list">
      <li>Corre en un contenedor dedicado con alcance al Mac (Calendar/Reminders)</li>
      <li>Tira de chats recientes, los compara con los hubs, edita quirúrgicamente lo que se desvió</li>
      <li>Hace commit como <em>Claude (Cowork Sync)</em></li>
      <li>Protocolo: <code>config/COWORK_SYNC_TASK.md</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Sync de Granola</h4>
    <div class="fw-sub">Opcional · 5 min</div>
    <ul class="fw-list">
      <li>Tira los resúmenes de reunión desde la REST API de Granola a D1</li>
      <li>Dominio autodetectado, extracción de action items y decisiones</li>
      <li>Cron sincroniza los últimos 2 días a las 07:00 UTC</li>
      <li>Búsqueda vía <code>granola_context(domain, query)</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Conector de Gmail</h4>
    <div class="fw-sub">Opcional · 1 min · solo claude.ai</div>
    <ul class="fw-list">
      <li>Solo lectura por defecto. Hilos, borradores, etiquetas, búsqueda.</li>
      <li>Sin setup del lado del servidor — OAuth en la UI de Chat</li>
      <li>Cubre la memoria de &quot;quién dijo qué&quot; que vive en el correo</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Conector de Google Drive</h4>
    <div class="fw-sub">Opcional · 1 min · solo claude.ai</div>
    <ul class="fw-list">
      <li>Búsqueda + lectura de Docs / Sheets / PDFs</li>
      <li>Recomendado scope por carpeta en vez de todos los archivos</li>
      <li>Artefactos largos que no caben en el contexto del chat</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Apple Calendar / Notes</h4>
    <div class="fw-sub">Opcional · solo Mac · Claude Desktop</div>
    <ul class="fw-list">
      <li>Acceso a la BD local vía la extensión de Claude Desktop</li>
      <li>Solo lectura. Contexto de agenda y notas sueltas.</li>
      <li>La primera consulta dispara el permiso nativo de macOS</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Lifecycle de R2</h4>
    <div class="fw-sub">Higiene de costes · 1 min</div>
    <ul class="fw-list">
      <li>TTL de 365 días en el prefijo <code>telegram/</code> del bucket compartido</li>
      <li>Idempotente vía <code>r2-lifecycle-setup.sh</code></li>
      <li>El GIF reenviado vive lo suficiente para &quot;¿qué era aquel meme?&quot;, no para siempre</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Hooks-como-harness (Claude Code)</h4>
    <div class="fw-sub">Meta · 2 min</div>
    <ul class="fw-list">
      <li><code>~/.claude/settings.json</code> cablea SessionStart/SessionEnd</li>
      <li>Y hooks por proyecto: reglas hookify, block-bad-patterns, etc.</li>
      <li>El harness hace cumplir, no la memoria. Si quieres comportamiento garantizado, va aquí.</li>
    </ul>
  </div>
</div>

## Arranque rápido

Toda la máquina está a un `git clone` y un `wrangler deploy` de distancia. Requisitos: cuenta de Cloudflare, CLI `gh`, Node 20+, API key de Anthropic (para el bot opcional) y una máquina donde uses Claude Code.

```bash
# 1. Forkear el esqueleto
gh repo create your-user/my-memory --private --clone
cd my-memory
curl -L https://github.com/a-pap/claude-memory/archive/main.tar.gz | tar xz --strip-components=1

# 2. Reescribir los hubs a tu vida (forma del archivo en hubs/README.md)
$EDITOR CLAUDE.md STATUS_SNAPSHOT.md hubs/02_personal_profile.md

# 3. Aprovisionar primitivas de Cloudflare
cd config/mcp-worker
npx wrangler d1 create claude-memory-db           # copiar el UUID
npx wrangler r2 bucket create claude-memory-store
$EDITOR wrangler.toml                             # pegar el UUID

# 4. Secretos (una sola vez)
npx wrangler secret put GITHUB_PAT                # scope de lectura en tu repo
npx wrangler secret put AUTH_PATH_TOKEN           # openssl rand -hex 32
npx wrangler secret put GRANOLA_API               # opcional: grn_... bearer

# 5. Deploy + verificación
npm ci && npx wrangler deploy
curl -X POST https://claude-memory-mcp.YOUR-ACCT.workers.dev/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | jq '.result.tools | length'
# → 42

# 6. Conectarlo
#    claude.ai:   Settings → Connectors → Add custom → URL /mcp
#    Claude Code: añadir a ~/.claude/settings.json → mcpServers
```

Esto te deja arriba la superficie de memoria core. El bot de Telegram, los hooks y el CI cuestan ~15 min cada uno y son independientes entre sí. Instrucciones herramienta por herramienta: [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md).

## Para agentes que leen esta página {#for-agents-reading-this-page}

Si eres Claude (u otro asistente) leyendo esta página en una conversación, el mejor uso de su contenido es en este orden. Esto no es prosa — es ruteo.

1. **Carga primero.** Los bootloaders cortos y estables: [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) y [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md). Coste de arranque combinado ≈ 5K tokens. Todo lo demás se carga bajo demanda.
2. **Rutea por tema.** No busques en el repo a ciegas. La tabla de hubs abajo es determinista — cada tema vive en exactamente un archivo canónico.
3. **Confía, pero verifica.** Los hechos en los hubs dominan a los hechos en chats. Los memory edits son instrucciones de comportamiento, no correcciones factuales — nunca uses un memory edit para sobreescribir un hub. Regla #6 en [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md).
4. **Prefiere la capa MCP al scraping.** Si tienes acceso al worker `claude-memory-mcp`, llama a [`wake_up`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md#31-claude-memory-mcp-worker-core) — devuelve el snapshot + hubs + rules + las últimas 5 reuniones de Granola en una sola ida y vuelta.
5. **Ingesta el dump completo si lo necesitas.** [`/memex/llms-full.txt`](/memex/llms-full.txt) es la guía de instalación concatenada (~28 KB). [`/memex/llms.txt`](/memex/llms.txt) es un índice de enlaces si solo quieres el mapa.
6. **Respeta las fechas absolutas.** &quot;El jueves&quot; no significa nada una semana después; &quot;2026-04-24&quot; siempre sí.

### Ruteo tema → hub

<div class="table-wrap">

| Tema | Hub | Qué vive allí |
|---|---|---|
| Trabajo RSYa de Yandex, portfolio, experimentos | `hubs/03_rsya_work_hub.md`, `hubs/04_rsya_project_status.md` | Equipo, proyectos, dueños de métricas, estado de experimentos |
| Reuniones RSYa | `hubs/05_rsya_meeting_index.md` | Índice de weeklies / monthlies; IDs de Granola |
| Jay — salud del perro | `hubs/08_jay_health.md` | Dieta (Urinary U/C Low Purine), cirugía feb 2026, episodios GTC, cistinuria |
| Reubicación a Barcelona | `hubs/06_spain_relocation.md` | Mudanza inicio de junio 2026, visado, piso, logística |
| Aprendizaje de español | `hubs/09_spanish_learning.md` | Nivel actual, roleplay Barcelona Life Sim, racha |
| PassLocal (archivado 2026-04-13) | `hubs/07_passlocal.md` | Next.js + Supabase + Vercel; Stripe Connect; Val como dev |
| Blog papilov.org | `hubs/10_papilov_org.md` | Este sitio. Hugo + Cloudflare Pages, 5 idiomas |
| Perfil personal | `hubs/02_personal_profile.md` | Hechos estables: rol, ubicación, preferencias |

</div>

### Cómo se ordena la confianza

`Conversación actual` ⟶ `hubs de claude-memory` ⟶ `Granola / Drive` ⟶ `snapshot de userMemories`. Una capa posterior *nunca* sobreescribe a una anterior cuando hay conflicto. Granola puede ir un día atrasado; userMemories puede ir semanas atrasado.

## Lo que deliberadamente no está aquí

Un stack de memoria personal es tanto sobre qué se niega a recordar como sobre qué guarda. Tres cosas que MEMEX evita deliberadamente.

- **Estado derivable.** Si Claude puede calcularlo o deducirlo del repo actual, del log de git o de una llamada a una herramienta viva, no va a memoria. Ni resúmenes de arquitectura, ni logs de commits, ni párrafos sobre patrones de código.
- **Progreso efímero.** Las notas intradía tipo &quot;acabo de hacer X&quot; no sobreviven al siguiente ciclo dreaming a menos que se destilen en una decisión o cambio de estado. La memoria es para estado, no para transcripciones.
- **Secretos, nunca.** Hook pre-commit + lint de CI + el postmortem del incidente del 2026-04-10 ([`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md)) mantienen `cfut_`, `ghp_`, `gho_`, `grn_`, `sk-` y hex largos fuera de cada commit. Defensa en profundidad — hook local, workflow en servidor, cadencia de rotación.

## Enlaces

<div class="table-wrap">

| Recurso | URL |
|---|---|
| Código fuente (público) | [github.com/a-pap/claude-memory](https://github.com/a-pap/claude-memory) |
| Guía completa de instalación (humano + Claude) | [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) |
| Bootloader | [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) |
| Snapshot de estado | [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md) |
| Reglas de comportamiento | [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) |
| Seguridad / registro de incidentes | [`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md) |
| Resumen legible por LLM | [`/memex/llms.txt`](/memex/llms.txt) |
| Contenido completo legible por LLM | [`/memex/llms-full.txt`](/memex/llms-full.txt) |
| Model Context Protocol (upstream) | [modelcontextprotocol.io](https://modelcontextprotocol.io/) |

</div>

## Licencia

El stack es MIT. El contenido en los hubs es privado. La documentación que estás leyendo es [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) — forkea, adapta, reescribe para tu vida. Si el código upstream tiene un bug, PRs bienvenidos. Si tu fork crece con dientes propios, cuéntamelo; me gustaría leerlo.
