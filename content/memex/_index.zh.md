---
title: "Memex"
description: "面向 Claude 的持久化、结构化、跨表面记忆系统 —— 以私有 GitHub 仓库为底座。"
tagline: "面向 Claude 的持久化记忆"
summary: "Claude 在对话之间会忘掉一切。Memex 为你提供由你自己掌控的结构化跨表面记忆 —— 以私有 GitHub 仓库作为唯一事实来源。"
meta: "git 存储 · markdown · 26 个 MCP 工具 · 约 5 分钟配置"
---

Claude 在对话之间会忘掉一切。内置记忆自动生成、没有结构，而且会滞后数天。

**Memex 为你提供由你自己掌控的结构化跨表面记忆** —— 以私有 GitHub 仓库作为唯一事实来源。你的上下文以人类可读的 markdown 文件形式存在，在 git 中版本化，按需加载。同一个仓库就是 Claude.ai、Claude Code、移动端和后台定时任务共同的大脑。

## 你能获得什么

- **跨表面的连续性。** 早上在手机上做的决定，下午笔记本上的 Claude Code 已经知道。
- **人类可读的存储。** Markdown 存于 git，而不是不透明的 SQLite。每一次改动都是一个可读、可比对、可回滚的 commit。
- **分级加载上下文。** 启动时约 3K tokens，只有话题需要时才加载更多。不会把 50K tokens 的历史塞进每次对话。
- **完整的灾难恢复。** 一个全新的 Claude，没有任何 memory edits，也能在约两分钟内从仓库重建全部上下文。
- **Cloudflare Workers 上的 26 个 MCP 工具。** 可选，用于无法运行 git 的表面 —— 但核心设计只靠仓库本身就能运作。

## 阅读蓝图

Memex 公开且可自托管。仓库包含完整的架构、安装指南和示例。

**→ [github.com/a-pap/memex](https://github.com/a-pap/memex)**

许可：代码 MIT，文档 CC BY 4.0。与 [Claude](https://claude.ai) 共同构建。
