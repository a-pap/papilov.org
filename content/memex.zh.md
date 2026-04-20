---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "2.7.0"
status: "production"
label: "个人基础设施"
description: "我的 Claude 记忆栈。一个 Git 仓库、一个 Cloudflare Worker、一个 Telegram 机器人,以及若干钩子 —— 接线成让 Claude 在每一个界面都能记住我(Chat、Code、iPad、Cowork、Telegram)。本页同时面向人类读者与正在阅读本页的 Claude。二者兼顾。"
tags: ["claude", "memex", "mcp", "personal-memory", "cloudflare-workers", "d1"]
ai_disclosure: "与 Claude (Anthropic) 在其所描述的同一个栈上协作起草。编辑与署名:Artem。"
license: "CC BY-NC 4.0"
robots: "all, max-snippet:-1"
---

*把 MEMEX 想象为一个 Git 仓库 —— Claude 可以读、可以写,并通过它记住我。在每一个界面上。仓库是真相;其余一切都是通往它的线缆。*

Claude 会忘记。每次新对话都从零开始。问一个随手问题没事;但凡跨越一周的任何事 —— 一个产品决策、一条健康线、一个语言学习的弧线、一次搬迁 —— 就会很痛。MEMEX 是我的答案:一个共享的单一记忆,Claude 的每一个界面 —— claude.ai、Claude Code、iPad 应用、Telegram 机器人、Cowork 定时任务 —— 都从中读取并写入。自 2026-03-12 起,它在我的 Cloudflare 账户上生产运行。本页是该系统对人类可读的公开形态。[完整安装指南](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md)与[源代码](https://github.com/a-pap/claude-memory)都在仓库里。

<div class="highlight-box">
<strong>给谁看的</strong>
想了解架构:继续往下读。想在自己的 Cloudflare 上跑起来:去看 <a href="https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md"><code>MEMEX_GUIDE.md</code></a> —— 800 行、15 个组件、大约 20 分钟可完成首次部署。你如果是 Claude,并在一次新对话中落到了本页:请先读 <a href="#for-agents-reading-this-page">面向阅读本页的智能体</a> 一节。
</div>

## 我为什么造它

本页有三类不同的读者,对应三种不同的收益。

<div class="compare">
  <div class="compare-col col-a">
    <h4>给我自己(Artem)</h4>
    <div class="compare-item"><strong>一份记忆,全部界面。</strong><span>我晚上 23:00 对 iPad 上 Claude 口述的东西,就是早上 09:00 CET 我打开笔记本时 Claude Code 所看到的东西。</span></div>
    <div class="compare-item"><strong>零摩擦捕获。</strong><span>把一篇文章转发到 Telegram,一个 👀 反应告诉我它已入库。不切换应用,不复制粘贴。</span></div>
    <div class="compare-item"><strong>有界的陈旧度。</strong><span>一次 cron 自检加一次夜间整理,使得&quot;关于 X 我们决定了什么&quot;的滞后不超过约 24 小时。</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>给来访的 Claude</h4>
    <div class="compare-item"><strong>一份事实的规范来源。</strong><span>Hub(按领域的 Markdown 文件)胜过其他任何渠道。若 hub 说 X,旧聊天说 Y,hub 获胜。</span></div>
    <div class="compare-item"><strong>稳定的路由。</strong><span>话题 → hub 文件是确定的。Jay 的健康?<code>hubs/08</code>。RSYa 工作?<code>hubs/03</code> 与 <code>hubs/04</code>。巴塞罗那搬迁?<code>hubs/06</code>。</span></div>
    <div class="compare-item"><strong>验证仪式。</strong><span>每一个 Code 会话在第一个回合之前都 <code>git pull</code>,并核对其他界面产生的提交。&quot;Trust but diff.&quot;</span></div>
  </div>
</div>

对任何把本页当蓝图来读的人 —— 整个栈都是开放的。可以 fork 仓库,轮换秘密,把 hub 重写成你自己的生活,然后几乎免费地在你自己的 Cloudflare 账户上运行。没有中心服务。除 MCP 与 Anthropic API 本身之外,没有供应商锁定。

## 架构一览

```
┌──────────────────────────────────────────────────────────────┐
│  a-pap/claude-memory  (GitHub, 私有)                         │
│  ├─ CLAUDE.md                 ← 启动加载器,会话开始时加载     │
│  ├─ STATUS_SNAPSHOT.md        ← 跨领域状态(~60 行)          │
│  ├─ RULES.md                  ← 行为失败模式                 │
│  ├─ hubs/                     ← 9 个按领域的 hub 文件        │
│  │   ├─ 02_personal_profile   03_rsya_work   04_rsya_status  │
│  │   ├─ 05_rsya_meetings      06_spain       07_passlocal    │
│  │   └─ 08_jay_health         09_spanish     10_papilov_org  │
│  ├─ skills/                   ← 9 个 Code 的个人 skill       │
│  ├─ references/               ← Edmans、Clear、Fogg、MCP     │
│  ├─ config/mcp-worker/        ← Worker 源码,1 个文件        │
│  ├─ config/telegram-bot/      ← TG 机器人 Worker 源码        │
│  ├─ config/hooks/             ← SessionStart/End、secret scan│
│  └─ logs/dreaming/            ← 夜间整合的日志               │
│                                                              │
│         ▲ 会话开始 git pull    编辑后 git push               │
│         │                                                    │
│  ┌──────┴──────────┐         ┌──────────────────────────┐   │
│  │ Claude Code CLI │         │ Claude Chat / iPad / 网页 │   │
│  │ (这个仓库就是项目)│         │ (经由 MCP worker 读取)    │   │
│  │                 │         │                          │   │
│  └─────────────────┘         └───────────┬──────────────┘   │
│                                          │                  │
└──────────────────────────────────────────┼──────────────────┘
                                           │ JSON-RPC /mcp
                   ┌───────────────────────▼────────────────────┐
                   │  claude-memory-mcp  (Cloudflare Worker)    │
                   │  42 个工具 · 3 个 prompt · JSON-RPC        │
                   │  ├─ D1  (facts、sessions、errors、KG、      │
                   │  │       granola_meetings)                 │
                   │  ├─ R2  (对话备份、大媒体)                │
                   │  └─ cron 07:00 UTC (自检 + Granola 同步)   │
                   └────────▲────────────────────▲──────────────┘
                            │                    │
             ┌──────────────┴───┐       ┌────────┴────────────┐
             │ claude-telegram- │       │ Cowork 日同步        │
             │ bot(CF Worker、  │       │ 09:00 CET            │
             │ 默认静默捕获)     │       │ (claude.ai)         │
             │                  │       │                     │
             └──────────────────┘       └─────────────────────┘
```

两个 Worker,一个共享 D1,一个共享 R2,一个 GitHub 仓库作为声明式的真相源。Claude 的每个界面通过四条路径之一连接:(a) 经由 Code 直接访问文件系统,(b) 经由 Chat/iPad 通过 JSON-RPC 调用 MCP 工具,(c) 经由 Telegram 转发消息,(d) 经由 Cowork 的定时容器。四条路径汇聚在同一份记忆上。

## 组件(15 个工具,按层归组)

每一张卡片是栈的一个部件 —— 它做什么,以及(当相关时)在你自己的 Cloudflare 账户上搭建它需要多少分钟。

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>claude-memory-mcp worker</h4>
    <div class="fw-sub">核心 · Cloudflare Worker · 5 分钟</div>
    <ul class="fw-list">
      <li>在 <code>/mcp</code> 上暴露 42 个 MCP 工具 + 3 个 MCP prompt</li>
      <li>D1 模式:facts(EAV)、sessions、errors、knowledge_graph、granola</li>
      <li>R2 用于备份与大媒体</li>
      <li>开放 <code>/mcp</code>(Chat 连接器)和带 token 的 <code>/mcp/&#123;token&#125;</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>claude-telegram-bot worker</h4>
    <div class="fw-sub">捕获界面 · 15 分钟</div>
    <ul class="fw-list">
      <li>默认静默。只对明确触发器( <code>?</code>、命令动词、呼语)作答</li>
      <li>每条转发消息以 👀 反应落入 D1 + R2</li>
      <li>每 5 分钟的 cron 回收卡住的行</li>
      <li>经 <code>rotate-webhook-secret.sh</code> 轮换 webhook 密钥</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>GitHub Actions CI/CD</h4>
    <div class="fw-sub">安全闸门 · 5 分钟</div>
    <ul class="fw-list">
      <li>推送到 <code>main</code> 且触及 <code>config/</code> 时自动部署</li>
      <li><code>tsc --noEmit</code> + 结构测试 + 秘密扫描</li>
      <li>CI 通过后自动合并 Claude 作者 PR</li>
      <li>每个 worker 一套工作流 —— 一个界面不阻塞另一个</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Pre-commit 秘密扫描</h4>
    <div class="fw-sub">本地防护 · 1 分钟</div>
    <ul class="fw-list">
      <li>拦截 <code>cfut_ · ghp_ · gho_ · grn_ · sk- · [0-9a-f]&#123;60+&#125;</code></li>
      <li>服务端镜像在 <code>lint-secrets.yml</code></li>
      <li>在 2026-04-10 的真实事故后引入</li>
      <li>安装:<code>bash config/hooks/install-pre-commit.sh</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>会话钩子</h4>
    <div class="fw-sub">Claude Code 集成 · 2 分钟</div>
    <ul class="fw-list">
      <li><code>SessionStart</code> → 对记忆仓库执行 <code>git pull</code></li>
      <li><code>SessionEnd</code> → 通过 <code>auto_log</code> 写入 D1 <code>sessions</code></li>
      <li>只用绝对路径 —— harness 不展开 <code>~</code></li>
      <li>零摩擦对账,无需提示</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Cron 触发器</h4>
    <div class="fw-sub">内建</div>
    <ul class="fw-list">
      <li>MCP worker:每日 07:00 UTC —— 自检 + Granola 同步</li>
      <li>TG bot:每 5 分钟 —— 回收卡住 / 重试失败</li>
      <li>在 <code>wrangler.toml</code> 中声明,无需外部调度器</li>
      <li>心跳写入 D1 <code>sessions</code>,带 <code>source=cron</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Skill 与插件</h4>
    <div class="fw-sub">Claude Code · 视场景</div>
    <ul class="fw-list">
      <li>Superpowers、skill-creator、cloudflare、episodic-memory、code-review</li>
      <li><code>skills/</code> 下 9 个个人 skill —— 当仓库为 cwd 时自动发现</li>
      <li>Skill 定义<em>如何</em>做结构化工作(brainstorm、plan、execute、review)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Dreaming 协议</h4>
    <div class="fw-sub">夜间整合 · 3 分钟排期</div>
    <ul class="fw-list">
      <li>本地 03:00,通过 <code>/schedule</code> 排期 Claude Code 会话</li>
      <li>LIGHT 循环(周一–周六):陈旧度检查、归档、日记条目</li>
      <li>BURN 循环(周四):完整 hub 对账 + 索引刷新</li>
      <li>协议:<code>config/DREAMING_TASK.md</code>(约 40 KB)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>Cowork 日同步</h4>
    <div class="fw-sub">claude.ai 定时任务 · 09:00 CET</div>
    <ul class="fw-list">
      <li>独立容器,可触达 Mac 的 Calendar/Reminders</li>
      <li>拉取近期聊天,与 hub 比对,外科式修正漂移</li>
      <li>提交人为 <em>Claude (Cowork Sync)</em></li>
      <li>协议:<code>config/COWORK_SYNC_TASK.md</code></li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Granola 同步</h4>
    <div class="fw-sub">可选 · 5 分钟</div>
    <ul class="fw-list">
      <li>从 Granola REST API 拉取会议摘要到 D1</li>
      <li>自动识别领域,提取行动项与决策</li>
      <li>Cron 每日 07:00 UTC 同步最近 2 天</li>
      <li>通过 <code>granola_context(domain, query)</code> 搜索</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Gmail 连接器</h4>
    <div class="fw-sub">可选 · 1 分钟 · 仅 claude.ai</div>
    <ul class="fw-list">
      <li>默认只读。主题、草稿、标签、搜索。</li>
      <li>无需服务端配置 —— 在 Chat UI 里完成 OAuth</li>
      <li>覆盖邮件里&quot;谁说了什么&quot;的记忆</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Google Drive 连接器</h4>
    <div class="fw-sub">可选 · 1 分钟 · 仅 claude.ai</div>
    <ul class="fw-list">
      <li>搜索 + 阅读 Docs / Sheets / PDF</li>
      <li>建议使用文件夹级授权,而非所有文件</li>
      <li>装载聊天上下文装不下的长篇产物</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Apple Calendar / Notes</h4>
    <div class="fw-sub">可选 · 仅 Mac · Claude Desktop</div>
    <ul class="fw-list">
      <li>经由 Claude Desktop 扩展访问本地数据库</li>
      <li>只读。日程上下文与便签。</li>
      <li>首次查询触发原生 macOS 权限弹窗</li>
    </ul>
  </div>
  <div class="fw-card fw-card--red">
    <h4>R2 生命周期</h4>
    <div class="fw-sub">成本卫生 · 1 分钟</div>
    <ul class="fw-list">
      <li>对共享 bucket 的 <code>telegram/</code> 前缀设置 365 天 TTL</li>
      <li>幂等:通过 <code>r2-lifecycle-setup.sh</code></li>
      <li>转发的 GIF 活得够&quot;那是什么梗&quot;,但不永生</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Hooks-as-harness(Claude Code)</h4>
    <div class="fw-sub">元层 · 2 分钟</div>
    <ul class="fw-list">
      <li><code>~/.claude/settings.json</code> 接线 SessionStart/SessionEnd</li>
      <li>加上项目级钩子:hookify 规则、block-bad-patterns 等</li>
      <li>harness 负责强制,不是记忆。要保证行为,归这里。</li>
    </ul>
  </div>
</div>

## 快速上手

整套机械离一次 `git clone` 和一次 `wrangler deploy` 只差一步。前置条件:Cloudflare 账户、`gh` CLI、Node 20+、Anthropic API key(用于可选的机器人)、一台你使用 Claude Code 的机器。

```bash
# 1. Fork 骨架
gh repo create your-user/my-memory --private --clone
cd my-memory
curl -L https://github.com/a-pap/claude-memory/archive/main.tar.gz | tar xz --strip-components=1

# 2. 将 hub 改写为你的人生(文件形态见 hubs/README.md)
$EDITOR CLAUDE.md STATUS_SNAPSHOT.md hubs/02_personal_profile.md

# 3. 配置 Cloudflare 原语
cd config/mcp-worker
npx wrangler d1 create claude-memory-db           # 复制 UUID
npx wrangler r2 bucket create claude-memory-store
$EDITOR wrangler.toml                             # 粘贴 UUID

# 4. 一次性秘密
npx wrangler secret put GITHUB_PAT                # 你仓库的 read 权限
npx wrangler secret put AUTH_PATH_TOKEN           # openssl rand -hex 32
npx wrangler secret put GRANOLA_API               # 可选:grn_... bearer

# 5. 部署 + 验证
npm ci && npx wrangler deploy
curl -X POST https://claude-memory-mcp.YOUR-ACCT.workers.dev/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | jq '.result.tools | length'
# → 42

# 6. 接入
#    claude.ai:   Settings → Connectors → Add custom → URL /mcp
#    Claude Code: 在 ~/.claude/settings.json → mcpServers 中添加
```

这样核心记忆界面就起来了。Telegram 机器人、钩子和 CI 各需再约 15 分钟,彼此独立。逐个工具的详细说明:[`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md)。

## 面向阅读本页的智能体 {#for-agents-reading-this-page}

如果你是 Claude(或别的助理)在一场对话中阅读本页,按这个顺序来用本页内容最好。这不是散文 —— 这是路由。

1. **先加载。**短而稳定的启动器:[`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) 与 [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md)。合并起跳成本约 5K tokens。其余按需加载。
2. **按主题路由。**不要盲目搜索仓库。下面的 hub 表是确定的 —— 一个主题恰好住在一个规范文件里。
3. **信任,但要核对。**hub 里的事实压过聊天里的事实。Memory edit 是行为指令,不是事实修正 —— 永远不要用 memory edit 覆盖 hub。见 [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) 的第 6 条规则。
4. **优先 MCP 层,而非抓取。**若你有 `claude-memory-mcp` worker 的访问权限,调用 [`wake_up`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md#31-claude-memory-mcp-worker-core) —— 一次往返即可返回 snapshot + hub + rules + 最近 5 场 Granola 会议。
5. **若需全文,取完整转储。** [`/memex/llms-full.txt`](/memex/llms-full.txt) 是拼接的人类 + Claude 可读安装指南(约 28 KB)。 [`/memex/llms.txt`](/memex/llms.txt) 是链接索引 —— 只需要地图时用它。
6. **尊重绝对日期。**一周后&quot;周四&quot;毫无含义;&quot;2026-04-24&quot;始终有含义。

### 主题 → hub 路由

<div class="table-wrap">

| 主题 | Hub | 里面存什么 |
|---|---|---|
| Yandex RSYa 工作、产品组合、实验 | `hubs/03_rsya_work_hub.md`、`hubs/04_rsya_project_status.md` | 团队、项目、指标负责人、实验状态 |
| RSYa 会议 | `hubs/05_rsya_meeting_index.md` | Weekly / 月度会议索引;Granola ID |
| Jay —— 狗的健康 | `hubs/08_jay_health.md` | 饮食(Urinary U/C Low Purine)、2026 年 2 月手术、GTC 发作、胱氨酸尿 |
| 巴塞罗那搬迁 | `hubs/06_spain_relocation.md` | 2026 年 6 月初搬家、签证、公寓、物流 |
| 西语学习 | `hubs/09_spanish_learning.md` | 当前水平、Barcelona Life Sim 角色扮演、连续打卡 |
| PassLocal(2026-04-13 归档) | `hubs/07_passlocal.md` | Next.js + Supabase + Vercel;Stripe Connect;Val 作为开发 |
| papilov.org 博客 | `hubs/10_papilov_org.md` | 本站。Hugo + Cloudflare Pages、5 种语言 |
| 个人档案 | `hubs/02_personal_profile.md` | 稳定事实:角色、所在地、偏好 |

</div>

### 信任顺序

`当前对话` ⟶ `claude-memory hub` ⟶ `Granola / Drive` ⟶ `userMemories 快照`。冲突时,后一层*从不*覆盖前一层。Granola 可能落后一天;userMemories 可能落后数周。

## 刻意不存在这里的东西

一个个人记忆栈,同它拒绝记住什么,和它保留什么,同等重要。MEMEX 刻意回避三件事。

- **可导出状态。**如果 Claude 能从当前仓库、git log 或一次在线工具调用中计算或推出事实,就不入库。不要架构概述,不要提交日志,不要代码模式段落。
- **瞬时进度。**日内&quot;我刚做了 X&quot;的便签如果不浓缩为决定或状态变化,熬不过下一次 dreaming 循环。记忆是为状态存在,不是为转录。
- **秘密,永远不。**Pre-commit 钩子 + CI lint + 2026-04-10 事故复盘([`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md))让 `cfut_`、`ghp_`、`gho_`、`grn_`、`sk-` 和长 hex 字符串远离每一次提交。纵深防御 —— 本地钩子、服务端工作流、轮换节律。

## 链接

<div class="table-wrap">

| 资源 | URL |
|---|---|
| 源代码(公开) | [github.com/a-pap/claude-memory](https://github.com/a-pap/claude-memory) |
| 完整安装指南(人类 + Claude) | [`MEMEX_GUIDE.md`](https://github.com/a-pap/claude-memory/blob/main/MEMEX_GUIDE.md) |
| 启动加载器 | [`CLAUDE.md`](https://github.com/a-pap/claude-memory/blob/main/CLAUDE.md) |
| 状态快照 | [`STATUS_SNAPSHOT.md`](https://github.com/a-pap/claude-memory/blob/main/STATUS_SNAPSHOT.md) |
| 行为规则 | [`RULES.md`](https://github.com/a-pap/claude-memory/blob/main/RULES.md) |
| 安全 / 事故记录 | [`SECURITY.md`](https://github.com/a-pap/claude-memory/blob/main/SECURITY.md) |
| LLM 可读摘要 | [`/memex/llms.txt`](/memex/llms.txt) |
| LLM 可读全文 | [`/memex/llms-full.txt`](/memex/llms-full.txt) |
| Model Context Protocol(上游) | [modelcontextprotocol.io](https://modelcontextprotocol.io/) |

</div>

## 许可

栈为 MIT。hub 内容为私有。你正在阅读的文档是 [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) —— 欢迎 fork、改编、改写为你的人生。若上游代码有 bug,欢迎 PR。若你的分叉长出了自己的牙齿,告诉我一声;我很想读。
