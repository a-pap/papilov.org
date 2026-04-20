---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "1.0"
status: "published"
label: "笔记"
description: "一篇关于我与 Claude 所用个人记忆模式的短记:一个收纳 Markdown 笔记的私有 Git 仓库、一个把它们以 MCP 工具暴露出来的 Cloudflare Worker,以及两个 Claude Code 的会话钩子。代码是我的、私有的;本页是该想法的公开草图。"
tags: ["claude", "mcp", "personal-memory"]
ai_disclosure: "与 Claude 协作撰写。"
license: "CC BY-NC 4.0"
robots: "all"
---

*一张草图,不是指南。一个 Git 仓库加一个 Worker,就足以让 Claude 拥有一份活过对话的记忆。*

整个配置由三部分组成,刻意保持小。一个私有 Git 仓库存放短小的 Markdown 笔记 —— 根目录下一个极小的启动器、一个不超过六十行的跨领域状态文件,以及一个记录我不愿每次重新解释的行为模式的规则文件。一个单文件 Cloudflare Worker 在 `/mcp` 上讲 Model Context Protocol,背后由 D1 存结构化行、R2 做偶尔的备份。两个 Claude Code 会话钩子把一切接起来:`SessionStart` 执行 `git pull`,让每次会话的第一回合看到新数据;`SessionEnd` 通过 `auto_log` 工具写入一行使用记录。可选扩展 —— 捕获机器人、夜间整合任务、若干托管连接器 —— 各自约十五分钟,与核心彼此独立。

四条不变量让它从玩具变成值得信任的东西。保持启动器很小,使起跳成本不超过数千 token。让主题路由确定化 —— 一个主题住在一个文件里,绝不两个。当事实冲突时,把已提交 Markdown 视为比聊天记录里的任何东西更强。绝不把秘密放进仓库;一个本地的 pre-commit 扫描器加服务端 lint,保证失误不会到达公共互联网。

若你想自己搭一个,邻近的工具值得一看:[Model Context Protocol](https://modelcontextprotocol.io/) 本身;托管替代 [mem0](https://mem0.ai/) 与 [Letta](https://www.letta.com/);Simon Willison 的 `llm` 命令行与 [Datasette](https://datasette.io/) —— &quot;文件即原语&quot; 那一派。本页没有可调用的东西 —— 代码私有、端点不公开。模式本身,才是重点。
