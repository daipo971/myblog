---
title: "OpenAI Codex 使用教程：CLI、IDE 插件和云端任务上手"
date: 2026-07-05T00:00:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
draft: false
description: "OpenAI Codex 现在是 ChatGPT 付费套餐附带的编程智能体，有命令行、IDE 插件和云端三种用法。本文讲清安装登录、审批模式、AGENTS.md、云端任务和代码审查、计费方式，附常见报错和常见问题。"
categories: ["AI工具实测"]
tags: ["教程", "AI编程", "Codex", "OpenAI"]
showtoc: true
---

**结论先说：** 现在说的 OpenAI Codex，已经不是 2021 年那个代码补全模型（旧 Codex 模型早已停用），而是 OpenAI 的**编程智能体**：你用自然语言交代任务，它读代码、改文件、跑命令和测试。它有三种用法：**终端里的 Codex CLI**、**VS Code 等编辑器里的插件**、**在云端并行执行任务的 Codex 网页版**。有 ChatGPT Plus 及以上订阅就能直接用，不需要额外付费；也可以用 API Key 按量计费。

**说明：** 本文依据 [Codex 官方文档](https://developers.openai.com/codex) 和 [GitHub 仓库](https://github.com/openai/codex) 整理（2026 年 10 月查阅）。Codex 更新很快，命令和套餐范围以官方说明为准。和 Claude Code 的对比见 [Claude Code 和 Codex CLI 怎么选](/posts/claude-code-codex-cli-2026/)。

## 前置条件

| 项目 | 要求 |
| --- | --- |
| 账号 | ChatGPT Plus、Pro、Business、Edu、Enterprise 等付费套餐；或 OpenAI API Key |
| 电脑 | macOS、Linux，或 Windows（推荐在 WSL 中使用 CLI） |
| 工具 | 安装了 Node.js（用 npm 安装时）或 Homebrew；项目用 Git 管理 |
| 网络 | 能访问 OpenAI 服务；国内用户见 [海外服务通关](/categories/海外服务通关/) 分类 |

## Codex 的三种用法

| 用法 | 在哪里运行 | 适合 |
| --- | --- | --- |
| Codex CLI | 你电脑的终端，直接改本地文件 | 习惯命令行，在本地项目里交代任务 |
| IDE 插件 | VS Code 以及 Cursor、Windsurf 等兼容编辑器的侧边栏 | 边看代码边让它修改 |
| Codex 云端 | 浏览器打开 ChatGPT 的 Codex 页面，在 OpenAI 的云端沙箱运行 | 连接 GitHub 仓库，后台并行跑多个任务并生成 PR |

三种入口用同一个 ChatGPT 账号登录，可以按场景混用：本地小改用 CLI 或插件，耗时的独立任务丢给云端。

## 第一步：安装 Codex CLI

```bash
# 方式一：npm
npm install -g @openai/codex

# 方式二：Homebrew（macOS）
brew install codex
```

安装后进入项目目录启动：

```bash
cd your-project
codex
```

第一次运行会提示登录：选择用 **ChatGPT 账号登录**（使用订阅额度），或者填入 **API Key**（按 token 计费）。

## 第二步：选择审批模式

Codex 会读文件、改文件、执行命令。为了安全，它有不同的审批级别，可以在会话中用 `/approvals` 切换：

| 模式 | Codex 可以做什么 | 适合 |
| --- | --- | --- |
| 只读 | 只能读代码和回答问题，改动和命令都要你批准 | 第一次用、读陌生项目 |
| 自动（默认） | 在当前工作目录内自动读写和运行命令，访问网络或目录外文件需批准 | 日常开发 |
| 完全访问 | 不再询问，可以访问网络和目录外文件 | 只在隔离环境里使用 |

建议：第一次在一个项目里用 Codex 时先用只读模式，让它解释项目结构，熟悉后再切换到自动模式。不要在有生产环境密钥的机器上开启完全访问。

## 第三步：交代第一个任务

好的任务描述包括四部分：**做什么、改哪里、不能动什么、怎么验证**。例如：

```
给 utils/date.py 里的 parse_date 函数补充单元测试，
覆盖空字符串、非法格式和时区三种情况。
不要修改 parse_date 本身。完成后运行 pytest 并告诉我结果。
```

Codex 会先读相关文件，给出计划，再修改并运行测试。每次改动结束后，用 `git diff` 检查它到底改了什么，满意再提交。

一些实用的会话命令（以 CLI 内 `/` 菜单为准）：

| 命令 | 作用 |
| --- | --- |
| `/model` | 切换模型和推理强度 |
| `/approvals` | 切换审批模式 |
| `/diff` | 查看本次会话的改动 |
| `/review` | 让 Codex 审查当前改动 |
| `/new` | 开始新会话 |

非交互场景（脚本、CI）可以用 `codex exec "任务描述"` 直接执行一次任务。

## 第四步：写 AGENTS.md 让它记住项目约定

在项目根目录放一个 `AGENTS.md`，Codex 每次启动都会读取。写进去的内容相当于给新同事的项目说明：

```markdown
# 项目说明
- 技术栈：Python 3.12 + FastAPI，依赖用 uv 管理
- 运行测试：uv run pytest
- 代码风格：ruff format；函数必须有类型注解
- 不要修改 migrations/ 目录下已有的文件
- 提交前必须让测试全部通过
```

AGENTS.md 是多家编程智能体通用的格式。写得越具体，需要你反复纠正的地方越少。

## 第五步：在编辑器里使用

在 VS Code 扩展市场搜索 OpenAI 官方的 Codex 扩展并安装（Cursor、Windsurf 等兼容编辑器同样可用），登录后在侧边栏打开 Codex 面板。它会把当前打开的文件和选中的代码作为上下文，适合「选中一段代码，让它重构或解释」的场景。插件里也可以把任务发送到云端执行。

## 第六步：用云端 Codex 跑后台任务

1. 在 ChatGPT 里打开 Codex 页面，连接 GitHub 账号并授权仓库；
2. 为仓库配置运行环境（安装依赖的命令、测试命令等）；
3. 输入任务，Codex 会在云端沙箱里克隆仓库、修改、运行测试；
4. 完成后查看改动和日志，满意就一键创建 Pull Request。

云端任务的好处是可以同时开多个任务，不占用你本地电脑。连接 GitHub 后，还可以在 PR 评论里让 Codex 审查代码。具体开通范围以官方说明为准。

## 计费方式

| 方式 | 说明 |
| --- | --- |
| ChatGPT 订阅 | Plus、Pro、Business 等套餐包含 Codex 使用额度，套餐越高额度越多，用完需等待额度恢复 |
| API Key | 按模型的 token 价格计费，适合脚本化、自动化场景 |

各套餐额度见 [ChatGPT 定价页](https://chatgpt.com/pricing)。按 API 计费时，大任务会消耗大量 token，建议在 OpenAI 平台设置用量上限。

## 常见报错与解决

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| `command not found: codex` | npm 全局目录不在 PATH 中 | 检查 `npm config get prefix`，把对应的 bin 目录加入 PATH，或改用 Homebrew 安装 |
| 登录页面打不开或登录失败 | 网络无法访问 OpenAI，或浏览器回调被拦截 | 检查网络；无图形界面的服务器上可改用 API Key 登录 |
| 提示额度用完 | 订阅的使用额度达到上限 | 等待额度恢复、升级套餐，或改用 API Key |
| 每一步都要确认，很慢 | 处于只读或需要审批的模式 | 用 `/approvals` 切到自动模式 |
| 改完代码测试失败 | 任务描述没有说明验证方式 | 在任务里写明测试命令，并要求它修到测试通过 |
| Windows 下命令执行异常 | 原生 Windows 环境支持有限 | 在 WSL 中安装和运行 |

## 用好 Codex 的几条原则

1. **先提交再让它大改。** 出问题时 `git checkout .` 就能回退。
2. **一次一个任务。** 范围小、边界清楚的任务成功率最高，大需求拆成几步。
3. **让它跑测试。** 不要只看代码「看起来对」，要求它运行测试和 lint。
4. **认真看 diff。** 它可能为了让测试通过而修改测试本身，或顺手改了无关文件。
5. **敏感信息不给它。** `.env`、密钥、客户数据不要放在它能读的地方，也不要粘贴到对话里。

## 常见问题

**现在的 Codex 和以前的 Codex 模型是一回事吗？**
不是。2021 年的 Codex 是一个代码补全模型（曾驱动早期的 GitHub Copilot），已经停用。现在的 Codex 是 OpenAI 的编程智能体产品，背后使用 OpenAI 当前的模型。

**免费账号能用吗？**
Codex 主要面向 ChatGPT 付费套餐和 API 用户，免费账号的可用范围以官方说明为准。

**Codex 和 GitHub Copilot 有什么区别？**
Copilot 是 GitHub 的编程助手，以编辑器补全和对话为主，也有 Agent 功能，支持多家模型；Codex 是 OpenAI 自己的编程智能体，主打交代任务后自主完成多步骤修改。详见 [AI 编程工具横评](/posts/ai-coding-tools-comparison-2026/)。

**Codex CLI 开源，是不是就不用付费、代码不出电脑？**
不是。开源的是命令行工具本身，默认调用的是 OpenAI 的云端模型，需要订阅或 API 费用，相关代码会发送给 OpenAI 处理。

**公司代码能用吗？**
先确认公司是否允许使用外部 AI 工具。企业场景使用 Business 或 Enterprise 套餐，并确认数据使用条款。

## 更新记录

- 2026-10-28：按 Codex 现状全面重写：旧版 Codex 模型（code-davinci-002 等）早已停用，改为介绍 Codex CLI、IDE 插件、云端任务、审批模式、AGENTS.md 和计费方式；删除不存在的「Codenew 模式」和过时的 API 示例；补充常见报错和常见问题；正文联系方式改为评论区

## 相关阅读

- [Claude Code 和 Codex CLI 怎么选](/posts/claude-code-codex-cli-2026/)
- [AI 编程工具横评：Cursor、Windsurf、Copilot、Claude Code 怎么选](/posts/ai-coding-tools-comparison-2026/)
- [Claude 入门指南](/posts/claude-guide/)
- 更多「AI工具实测」文章：[/categories/ai工具实测/](/categories/ai工具实测/)
