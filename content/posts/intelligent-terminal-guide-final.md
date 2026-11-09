---
title: "Intelligent Terminal 0.3：关窗不断任务"
date: 2026-11-09T18:20:00+08:00
lastmod: 2026-11-09T18:20:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["教程", "AI编程", "AI Agent", "Claude Code"]
description: "微软实验终端 Intelligent Terminal 更新 0.3：新增 Agent 侧边栏、无头模式（关窗口任务照样跑）、自动识别 Claude、Codex 等 Agent。附安装、前提与三个边界，依据微软官方博客与发布说明整理。"
showtoc: true
---

结论先说：**在 Windows 上同时开几个编程 Agent 干活的人，Intelligent Terminal 值得一试。** 它是微软从 Windows Terminal 分叉出来的实验终端，0.3 版（2026 年 11 月 4 日发布）最大的变化是「无头模式」：给标签页开一下，关掉终端窗口，里面的 Agent 任务和长命令继续在后台跑，不会像以前一样窗口一关全断。再加上能一眼看全所有 Agent 状态的侧边栏、自动识别已安装 Agent CLI，它想解决的就是「Agent 越开越多、管不过来」这一个问题。先把口径说清：本文依据微软官方博客与 GitHub 发布说明整理（查阅时间：2026 年 11 月 9 日），**未在真实 Windows 机器上安装实测**；它仍是实验项目，下面把边界一并说清。

![插画：带竖排侧边栏的终端窗口，标签上有发光的状态点，小机器人在窗口里工作，背景里有一个淡去的窗口轮廓和仍在转动的齿轮](/images/intelligent-terminal-guide/cover.webp)

## 它和 Windows Terminal 是什么关系

Intelligent Terminal 是微软的一个**独立实验应用**：代码从 Windows Terminal 分叉，标签页、分屏、主题、快捷键这些基础能力都和原版一致，区别是原生集成了 AI Agent——有一个能看懂你 shell 上下文的 Agent 窗格，支持 ACP（Agent Client Protocol）协议的 Agent 都能接进来，本地模型也可以。它在 GitHub 开源（MIT 许可证，仓库 `microsoft/intelligent-terminal`），和系统自带的 Windows Terminal 并排安装、互不影响，不用卸载谁。微软自己的定性是「实验阶段」：迭代很快，功能和行为都可能变。

## 0.3 更新了什么

微软官方博客的说法是，这是「自发布以来最大的更新」。具体是三件事：

### 侧边栏：所有 Agent 一眼看全

新版默认把横排标签换成竖排侧边栏（不习惯可以切回去：右键标签选 Switch to horizontal tabs，或在设置 > 外观 > Tab Layout 里改；`Ctrl+Shift+S` 可折叠侧边栏）。每个标签除了标题，还能显示最多两个信息字段：Agent 状态、工作目录、Git 仓库与分支变更等。最有用的是**实时状态和提醒圆点**：哪个 Agent 在干活、哪个在等你输入、哪个在等你批准工具调用，不用逐个点开就知道。另外还有标签置顶、分屏嵌套显示在标签下方、全局搜索（连其他窗口和已关闭的历史会话一起搜）、「只看 Agent」的过滤开关，以及跨窗口的「最近 Agent 会话」列表。

### 无头模式：关窗不杀任务

以前终端窗口一关，正在跑的 Agent 长任务和编译就一起断了。0.3 的做法：右键标签选 **Turn on headless mode**，这个标签（连同它里面的分屏）就转入后台继续运行，你可以把窗口关掉走人；之后从侧边栏或系统托盘（没有活动窗口时）把还在跑的标签找回来。无头模式下的 Agent 会话会一直出现在侧边栏的「最近 Agent 会话」里。

边界必须讲清：按 GitHub 发布说明的口径，无头模式保的是**活进程**——**应用被彻底退出、或电脑重启，任务就没了**。微软博客里「一直跑到机器停为止」的说法更宽，实际以发布说明为准：它防的是「手滑关窗」，不是「关机断电」。

### 自动识别已安装的 Agent CLI

新版会扫描你电脑里装好的 Agent CLI，自动建好启动配置，在新建标签菜单里像选 PowerShell 一样直接启动。官方发布说明列出的有 GitHub Copilot CLI、Claude、Codex、Gemini、OpenCode，以及这次新加入的 Google Antigravity。

### Agent 窗格：报错不用再复制粘贴

它和普通终端的另一个区别是内置的 Agent 窗格：shell 的输出会自动进入 Agent 的上下文，命令报错时不用手动复制日志去问 AI，让它解释失败原因、生成下一条命令、或接着跑多步骤任务，你的 shell 本身保持可用。0.3 里这个窗格支持用 Markdown 渲染回复，文本编辑和粘贴图片的操作也做了改进。要注意的是，窗格背后跑的还是你接的那个 Agent CLI，它的订阅、额度和数据政策都跟着 Agent 本身走，终端只负责把上下文递过去。

## 怎么安装

系统要求：Windows 10 版本 2004（内部版本 19041）或更高，Windows 11 直接满足。三种装法任选：

1. **Microsoft Store**：搜 Intelligent Terminal 安装，最省事，后续自动更新；
2. **GitHub 发布页**：到 `microsoft/intelligent-terminal` 仓库的 Releases 下载安装包；
3. **winget 命令**：`winget install Microsoft.IntelligentTerminal`。

还有一个使用前提：终端本体免费，但要让它真干活，你得先有至少一个受支持的 Agent CLI 和它对应的订阅（默认是 GitHub Copilot CLI）——没有 Agent 的话，它就只是个换了侧边栏的普通终端。

## 先说清三个边界

1. **实验阶段**：微软明说还在快速迭代期，别把关键的无人值守任务押在它的会话保活上，重要工作该落盘落盘。
2. **无头模式不抗重启**：见上文，关窗可以，退出应用和重启不行。
3. **两个已知的识别盲区**：装在 WSL 里面的 Agent CLI 不会被自动识别（需自己建配置）；Antigravity 在部分企业版 Windows 环境上有 DLL 加载失败的报告（发布说明提及）。这两条对国内个人用户影响不大，但公司电脑用户先有个预期。

## 适合谁

- 适合：已经在 Windows 上用 Claude Code、Codex、Copilot CLI 等编程 Agent，且经常同时开两三个会话、被「窗口关了任务就断」坑过的人。
- 不适合：只用网页版 AI、没碰过命令行 Agent 的新手——先从 [AI Agent 完全指南](/posts/build-your-own-ai-agent-tutorial/) 了解 Agent 怎么回事更划算；Mac 和 Linux 用户也用不了，它是 Windows 专用。

同类开源工具本站还写过几篇，都在 [AI工具实测中心页](/categories/ai工具实测/) 的「GitHub 开源项目精选」一节里；给 Agent 换后端、试多家模型的玩法，可以看 [OpenRouter 免费模型那篇](/posts/openrouter-free-models/)。

## 常见问题

**Intelligent Terminal 会取代 Windows Terminal 吗？**
不会。它是并行存在的实验应用，微软没有宣布合并或替代计划，两个可以同时装。

**无头模式下关了窗口，任务能跑多久？**
只要应用进程还在、电脑不关机重启，就一直跑；从系统托盘可以找回界面。退出应用或重启即终止，这一点发布说明写得很明确。

**不装任何 Agent CLI 能用吗？**
能当普通终端用（标签、分屏、侧边栏都在），但它的核心卖点全在 Agent 管理上，没有 Agent 时没必要专门换。

**它收费吗？**
终端本身免费开源（MIT）。花钱的是你用的 Agent CLI 背后的订阅，比如 Copilot、Claude 的订阅或 API 费用，和终端无关。

**数据会上传吗？**
它就是本地终端应用，Agent 的数据流向取决于你接的 Agent CLI 本身；终端这一层没有额外的云服务。涉及公司代码时，按你所用 Agent 的数据政策判断。

## 参考来源

- 微软 Windows Command Line 官方博客：《Intelligent Terminal 0.3: A new way to manage your tabs and agents》（2026-11-04）
- GitHub 仓库 microsoft/intelligent-terminal 及 v0.3（v0.3.3083.0）发布说明（2026-11-04）
- Visual Studio Magazine、iThome 对 0.3 的报道（2026-11-05 前后）

## 信息核验与更新记录

- 核对日期：2026-11-09
- 官方来源：[微软官方博客](https://devblogs.microsoft.com/commandline/intelligent-terminal-v0-3-a-new-way-to-see-and-manage-your-tabs-and-agents/)（侧边栏、无头模式、自动配置的功能描述）；[GitHub 仓库](https://github.com/microsoft/intelligent-terminal)（MIT 许可证、系统要求、v0.3 发布说明）
- 口径差异说明：无头模式的持续范围，官方博客表述为「运行到机器停止为止」，GitHub 发布说明更严格（应用退出或重启不保留），本文按发布说明的严口径写。
- 经验与估算：文中「适合谁」的判断为本站经验口径；功能与限制均为官方或发布说明口径。本文未做真机安装实测，实际体验以读者本机为准。
- 利益披露：本站与微软、Intelligent Terminal 项目均无合作、返佣或利益关系，本文不含商城推荐。
- 更新记录：
  - 2026-11-09：首发。
