---
title: "Claude Code 和 Codex CLI 怎么选：终端编程智能体对比"
date: 2026-07-25
lastmod: 2026-10-28T09:00:00+08:00
description: "Claude Code 和 OpenAI Codex CLI 都是在终端里自主改代码的 AI 编程智能体。本文对比两者的安装、工作方式、权限与沙箱、计费、隐私，并说明它们和 Cursor 这类 AI 编辑器的分工。"
summary: "Claude Code 与 Codex CLI 对比：安装、工作方式、沙箱、计费、隐私和适合谁，以及和 Cursor 怎么搭配。"
categories: ["AI工具实测"]
tags: ["对比", "AI编程", "Claude Code", "Codex"]
showtoc: true
---

**结论先说：** Claude Code（Anthropic）和 Codex CLI（OpenAI）是同一类工具：在终端里用自然语言交代任务，AI 自己读代码、改文件、跑命令。两者能力接近，选哪个主要看你已经订阅了谁：有 Claude Pro/Max 用 Claude Code，有 ChatGPT Plus/Pro 用 Codex，都不用额外付费。它们不提供逐行补全，日常敲代码仍然需要 Cursor、Copilot 这类编辑器工具，常见做法是「编辑器写日常代码 + 终端智能体做大任务」。

**说明：** 本文依据两款工具的官方文档、GitHub 仓库和更新日志整理（2026 年 10 月查阅），不是长期实测打分。两款工具更新很快，命令和价格以官方文档为准。

## 终端智能体是什么，和 Cursor 有什么不同

AI 编程工具大致经历了三种形态：

| 形态 | 代表 | 你做什么 | AI 做什么 |
| --- | --- | --- | --- |
| 补全 | 早期 Copilot | 自己写代码 | 预测下一行 |
| AI 编辑器 | Cursor、Windsurf | 在编辑器里边看边改，选中代码下指令 | 补全、改选中片段、Agent 跨文件修改 |
| 终端智能体 | Claude Code、Codex CLI | 描述任务、审查结果 | 读代码库、制定计划、改多个文件、运行测试、迭代修复 |

终端智能体的核心区别是「交代任务，等结果」：你说「把用户模块的数据库访问从原生 SQL 改成 ORM，改完跑一遍测试」，它会自己找相关文件、逐个修改、跑测试、看报错再修，最后把改动交给你审查。编辑器里的 Agent 模式也在往这个方向走，两类工具的边界正在变模糊，但交互习惯仍有差异。

Cursor 的用法见 [Cursor 使用指南](/posts/cursor-programming-tools/)，几类工具的总体对比见 [AI 编程工具横评](/posts/ai-coding-tools-comparison-2026/)。

## Claude Code

[Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) 是 Anthropic 的编程智能体，2025 年发布。除了终端版本，还有 VS Code、JetBrains 扩展、桌面应用和网页版。

**安装：** 官方提供原生安装脚本，也可以用 npm 安装：

```bash
npm install -g @anthropic-ai/claude-code
cd your-project
claude
```

首次运行会引导你登录 Claude 账号，或者配置 API Key。

**主要特点：**

- **项目记忆：** 在项目根目录放一个 `CLAUDE.md`，写上项目结构、代码规范、常用命令，它每次启动都会读取。
- **权限确认：** 默认情况下，修改文件和运行命令前会征求你同意，可以按命令设置白名单。
- **计划模式：** 可以先让它只读代码、给出方案，你确认后再动手。
- **扩展能力：** 支持 MCP（接入数据库、浏览器、第三方服务）、自定义斜杠命令、子代理和 Hooks。
- **Git 配合：** 可以让它创建分支、写提交信息、开 PR。

**计费：** 包含在 Claude Pro、Max 订阅中（不同档位用量上限不同），也可以用 API Key 按 token 计费。详见 [Claude 入门指南](/posts/claude-guide/)。

## Codex CLI

[Codex CLI](https://github.com/openai/codex) 是 OpenAI 的开源终端编程智能体，2025 年发布，代码在 GitHub 上以 Apache-2.0 许可证开源。OpenAI 的 Codex 产品还包括 IDE 扩展和在云端执行任务的 Codex 网页版。

**安装：**

```bash
npm install -g @openai/codex
cd your-project
codex
```

也可以用 Homebrew 安装。首次运行用 ChatGPT 账号登录，或配置 OpenAI API Key。

**主要特点：**

- **项目说明：** 读取项目里的 `AGENTS.md` 文件，作用和 `CLAUDE.md` 相同。
- **沙箱和审批模式：** 默认在受限沙箱里运行命令，可以设置为只读、自动在工作目录内修改、或完全自动等不同级别。
- **开源：** 工具本身开源，可以审查代码、提交改进；但默认调用的是 OpenAI 的云端模型。
- **本地模型选项：** 官方提供 `--oss` 选项，可以配合 Ollama 等调用本地开源模型，这时代码不会发给 OpenAI，但效果取决于本地模型能力和电脑配置。

**计费：** 包含在 ChatGPT Plus、Pro、Business 等付费订阅中，也可以用 API Key 按量计费。上手方法见 [Codex 使用指南](/posts/codex-guide/)。

## 两者对比

| 维度 | Claude Code | Codex CLI |
| --- | --- | --- |
| 开发商 | Anthropic | OpenAI |
| 工具本身开源 | 否 | 是（Apache-2.0） |
| 默认模型 | Claude 系列 | OpenAI 的 GPT / Codex 系列 |
| 项目说明文件 | CLAUDE.md | AGENTS.md |
| 安全机制 | 操作前权限确认，可配置白名单 | 沙箱 + 多级审批模式 |
| 扩展 | MCP、斜杠命令、子代理、Hooks | MCP、配置文件、本地模型 |
| 其他入口 | IDE 扩展、桌面、网页 | IDE 扩展、云端 Codex |
| 订阅包含 | Claude Pro / Max | ChatGPT Plus / Pro 等 |
| API 按量 | 支持 | 支持 |

价格来源：[Claude 定价](https://claude.com/pricing)、[ChatGPT 定价](https://chatgpt.com/pricing)，以官网当前说明为准。

能力上，两者都能完成搭项目、跨文件重构、补测试、排查 bug 这类任务，效果差异主要来自背后的模型，而模型更新很频繁，今天谁更强不代表下个月。最实际的做法是用你已有的订阅先试，遇到它处理不好的任务，再换另一个试同一个任务。

## 按情况选择

| 你的情况 | 建议 |
| --- | --- |
| 已订阅 Claude Pro / Max | 直接用 Claude Code，不用额外付费 |
| 已订阅 ChatGPT Plus / Pro | 直接用 Codex，不用额外付费 |
| 都没订阅，想先体验 | 选一家开最低档付费订阅试一个月，比按 API 计费更好控制花销 |
| 公司要求代码不出内网 | 两者默认都不满足；考虑 Codex 接本地模型，或使用企业版并走公司审批 |
| 很看重工具本身可审查、可改造 | Codex CLI 开源，可以读源码和二次开发 |
| 需要接很多外部工具和自动化 | 两者都支持 MCP，Claude Code 的 Hooks 和子代理生态更成熟一些 |

不确定时，最省事的判断方法是拿同一个真实任务分别交给两者，比较哪个改动更少返工、更符合你的项目习惯。

## 和 Cursor 怎么搭配

| 任务 | 更顺手的工具 |
| --- | --- |
| 日常写业务代码、边写边补全 | Cursor / Copilot |
| 改一两个函数 | Cursor 行内编辑 |
| 新项目搭骨架、跑通环境 | Claude Code / Codex |
| 跨很多文件的重构、框架迁移 | Claude Code / Codex |
| 补单元测试、写文档 | Claude Code / Codex |
| 批量处理脚本、日志分析 | Claude Code / Codex |
| 理解一个陌生代码库 | 都可以，终端智能体更适合「从头读一遍再总结」 |

两类工具并不冲突：可以在 Cursor 的内置终端里运行 `claude` 或 `codex`，一边看 diff 一边让智能体干活。

## 隐私和安全

**代码会发到哪里：** 两款工具在你电脑上运行，但默认把相关代码和命令输出发送给 Anthropic 或 OpenAI 的云端模型处理。工具本身「在本地运行」不等于「代码不出电脑」，只有 Codex 配合本地模型时才完全离线。

**公司代码：** 使用前确认公司是否允许使用外部 AI 工具；需要合规时使用企业版或商业 API，并确认数据不用于训练的条款。

**权限：** 不要为了省事直接开启「全部自动执行」。让智能体运行删除文件、推送代码、访问生产环境的命令前，保留人工确认。密钥和 `.env` 文件不要让它读取，也不要在对话里粘贴。

**先提交再大改：** 让智能体动手前先 `git commit`，出了问题可以一条命令回退。

## 上手建议

1. **从小任务开始。** 先让它解释项目结构、修一个小 bug、写几个测试，熟悉它的工作方式再交大任务。
2. **任务写清楚边界。** 说清要做什么、改哪些目录、不能动什么、怎么验证完成（比如「`npm test` 全部通过」）。
3. **写项目说明文件。** 把构建命令、测试命令、代码风格、禁止事项写进 CLAUDE.md 或 AGENTS.md，可以减少反复纠正。
4. **认真看 diff。** 智能体可能顺手改了你没要求改的地方，或者为了让测试通过而改测试本身。
5. **控制用量。** 大任务会消耗大量 token，订阅有用量上限，按 API 计费时注意设置预算。

## AI 编程会让人不需要学编程吗

不会。终端智能体降低了「从零写出能跑的代码」的门槛，但审查 AI 的改动、判断方案好坏、在 AI 卡住时接手，都需要扎实的编程基础。对学习者来说，比较好的方式是先自己写，再让 AI 解释报错、指出问题；对有经验的开发者来说，它更像一个执行力很强、但需要你把关的同事。

## 常见问题

**Claude Code 和 Codex CLI 需要单独付费吗？**
不一定。Claude Code 包含在 Claude Pro、Max 订阅里，Codex 包含在 ChatGPT Plus 等付费订阅里；没有订阅也可以用 API Key 按量计费。免费账号一般不能使用或额度很少，以官方说明为准。

**Codex CLI 开源，是不是就免费、代码不出电脑？**
不是。开源的是命令行工具本身，默认调用的仍是 OpenAI 的云端模型，需要订阅或 API 费用，代码也会发送到 OpenAI。只有用 `--oss` 等方式接本地开源模型时才离线运行。

**不会编程能用这些工具做项目吗？**
能做出简单的原型，但遇到报错、需求变复杂或要上线部署时，很难判断 AI 改得对不对。建议先学一点基础，至少能读懂代码结构和报错信息。

**国内能用吗？**
工具可以正常安装，但需要能访问 Anthropic 或 OpenAI 的服务，付费需要海外支付方式，见 [海外服务通关](/categories/海外服务通关/) 分类。只能用国内服务的话，可以考虑在 Cursor 等编辑器里接入 [DeepSeek](/posts/deepseek-complete-guide-2026/) 等国产模型的 API。

**两个都要装吗？**
不需要。用你已经订阅的那一家即可；只有在某个任务上效果不理想时，再用另一家试同一个任务作对比。

## 更新记录

- 2026-10-28：改写为客观对比，删除无法核实的个人使用体验；更正 Claude Code「跑在云端」「只能按 token 计费」和 Codex CLI「本地运行代码不出电脑、免费」等不准确说法；补充沙箱与权限、项目说明文件、隐私、常见问题

## 相关阅读

- [AI 编程工具横评：Cursor、Windsurf、Copilot、Claude Code 怎么选](/posts/ai-coding-tools-comparison-2026/)
- [Cursor 和 Windsurf 怎么选](/posts/cursor-vs-windsurf-2026/)
- [Codex 使用指南](/posts/codex-guide/)
- 更多「AI工具实测」文章：[/categories/ai工具实测/](/categories/ai工具实测/)
