---
title: "AI Agent 是什么：主流框架对比与入门搭建"
date: 2026-07-27
lastmod: 2026-10-28T09:00:00+08:00
description: "2026年最火的AI Agent（智能体）到底是什么？从Anthropic Agent SDK到OpenAI Agents SDK，从浏览器Agent到代码Agent，完整指南和实战教程。"
summary: "2026年AI Agent最全指南：Anthropic Agent SDK、OpenAI Agents SDK、浏览器Agent、代码Agent，从概念到实战，手把手教你搭建自己的AI智能体。"
tags: ["科普", "AI Agent", "自动化", "Anthropic", "OpenAI"]
categories: ["AI工具实测"]
showtoc: true
---

**一句话说明：** AI Agent（智能体）不是「你问它答」的聊天机器人，而是给它一个目标后，能自己规划步骤、调用工具、检查结果并修正，直到完成任务的 AI 系统。普通用户最常接触的 Agent 是 Claude Code、Codex 这类编程智能体和 ChatGPT 的 Agent 模式；开发者可以用 Claude Agent SDK、OpenAI Agents SDK、Google ADK 或 LangGraph 等框架自己搭建。

从 2025 年起，主流 AI 公司陆续推出了面向开发者的 Agent 框架，Agent 成为行业最受关注的方向之一。

**什么是AI Agent？** 简单说，AI Agent不是"你问它答"的聊天机器人，而是**能自己干活、自己决策、自己执行任务的AI**。

你给Agent一个目标，它会自己规划步骤、调用工具、执行任务、修正错误，直到完成目标。这跟ChatGPT那种"你问一句它答一句"的模式，是完全不同的体验。

主要框架和发布时间：

- **OpenAI Agents SDK**：2025 年 3 月发布（[官方文档](https://openai.github.io/openai-agents-python/)）
- **Google ADK**：2025 年 4 月发布（[官方文档](https://google.github.io/adk-docs/)）
- **Claude Agent SDK**：Anthropic 在 2025 年把 Claude Code 的底层能力开放为 SDK（[官方文档](https://code.claude.com/docs/en/agent-sdk)）
- 以及 LangGraph、CrewAI、AutoGen 等开源框架

这篇就带你从零开始，全面了解AI Agent的世界，以及如何自己动手搭建一个。

---

## AI Agent 是什么？

### 对比：ChatGPT vs AI Agent

| 维度 | ChatGPT | AI Agent |
|------|---------|----------|
| 工作方式 | 你问一句，它答一句 | 你给一个目标，它自己干完 |
| 自主性 | 被动 | 主动 |
| 执行能力 | 只能聊天 | 能调用工具、操作软件、写代码 |
| 持久性 | 单次对话 | 可以持续运行，自主迭代 |
| 出错处理 | 你指出错误，它修正 | 自己发现错误，自己修正 |

### Agent的核心能力

一个基本的AI Agent由三部分组成：

1. **大脑（LLM）**：GPT、Claude、Gemini、DeepSeek 等大模型，负责理解和决策
2. **工具集（Tools）**：能调用的API、函数、软件
3. **记忆（Memory）**：短期记忆（当前任务上下文）+ 长期记忆（知识库）

**想象一下：** 你告诉Agent"帮我找一份2026年AI行业的市场报告，用英文写一份500字的摘要，发到我的邮箱，顺便在Slack上通知团队"。然后它就自己去做了——搜索、阅读、总结、发邮件、发Slack通知。**你只需要说一句话。**

---

## 主流的AI Agent 框架

### 1. Anthropic：Claude API 工具调用与 Claude Agent SDK

Anthropic 提供两种搭建 Agent 的方式，名字相近但不是同一个东西：

- **Claude API + 工具调用**（`pip install anthropic`）：你定义工具，模型决定什么时候调用，你的代码执行工具并把结果传回。SDK 还提供 Tool Runner 帮你自动循环。适合需要完全控制流程的场景。
- **Claude Agent SDK**（`pip install claude-agent-sdk`，另有 TypeScript 版）：把 Claude Code 的整套能力打包成库，内置读写文件、执行命令、搜索网页等工具，以及上下文管理、权限控制和子代理。适合想快速得到一个「能操作文件和命令行」的 Agent。用法以[官方文档](https://code.claude.com/docs/en/agent-sdk)为准。

**核心特性：**
- **工具调用（Tool Use）：** 模型可以调用你定义的 API 或函数
- **多步骤推理：** 自己拆解任务，一步步执行
- **MCP 支持：** 通过 MCP 协议接入外部工具和数据源
- **权限控制：** Agent SDK 可以限制 Agent 能使用哪些工具

**Claude API 工具调用的最小示例**（模型只会「请求」调用工具，真正执行工具和循环需要你的代码或 Tool Runner 完成）：
```python
import anthropic

client = anthropic.Anthropic()

# 定义一个工具
tools = [
    {
        "name": "search_web",
        "description": "搜索网络信息",
        "input_schema": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "搜索关键词"}
            },
            "required": ["query"]
        }
    }
]

# 发起请求，模型如需搜索会返回 tool_use 内容块
response = client.messages.create(
    model="claude-opus-5-5",
    max_tokens=4096,
    tools=tools,
    system="你是一个研究助手。搜索信息时，先确认理解用户需求，再分步骤搜索。",
    messages=[
        {"role": "user", "content": "帮我找一下2026年AI行业的最新趋势"}
    ]
)

print(response.stop_reason)  # 为 "tool_use" 时，执行工具后把结果发回
print(response.content)
```

**强项：** 适合需要复杂推理、长上下文和编程能力的任务；Agent SDK 与 Claude Code 同源，文件和命令行操作能力成熟。

**适合场景：** 研究分析、报告生成、数据分析、代码开发。

### 2. OpenAI Agents SDK

**Type：** Python SDK
**适用场景：** 多Agent协作、复杂工作流

OpenAI 在 2025 年 3 月发布的 Agents SDK（`pip install openai-agents`）是使用较广的 Agent 框架之一。

**核心特性：**
- **Agent编排：** 支持多个Agent协作，一个主Agent可以调用子Agent
- **Guardrails：** 内置安全约束，防止Agent执行危险操作
- **Handoffs：** Agent之间可以互相传递任务
- **内置工具集：** 代码执行、文件操作、网络搜索等

**简单示例：**
```python
from agents import Agent, Runner, function_tool

# 定义一个工具
@function_tool
def get_weather(city: str) -> str:
    """获取城市天气"""
    return f"{city}的天气是晴天，25°C"

# 创建一个Agent
agent = Agent(
    name="天气助手",
    instructions="你是一个天气查询助手，可以帮用户查询全球天气。",
    tools=[get_weather]
)

# 运行Agent
result = Runner.run_sync(agent, "北京的天气怎么样？")
print(result.final_output)
```

**OpenAI Agents SDK 的强项：** 多Agent协作和工具调用非常成熟。

**适合场景：** 客服系统、自动化工作流、多步骤任务。

### 3. Google ADK（Agent Development Kit）

**Type：** Python SDK
**适用场景：** 需要与Google生态集成

Google 的 ADK（Agent Development Kit）于 2025 年 4 月开源发布，适合使用 Gemini 模型或需要与 Google Cloud 生态集成的场景。

**核心特性：**
- 深度集成Google Workspace
- 支持Gemini模型
- 多模态能力（图片、视频、音频）

**适合场景：** Google Workspace自动化、企业级Agent。

### 4. 开源Agent框架

**LangChain + LangGraph：** 最成熟的开源Agent框架，支持所有主流模型，社区活跃。适合需要高度自定义的开发者。

**CrewAI：** 专注于"Agent团队"的框架。你可以定义多个角色（研究员、写手、编辑），让它们协作完成复杂任务。

**AutoGen：** 微软开源的Agent框架，支持多Agent对话。适合需要多个Agent协同工作的场景。

---

## 实战：搭建一个智能研究助手Agent

下面用 OpenAI Agents SDK 演示搭建一个「研究助手」Agent 的基本结构：它能搜索信息、分析结果、生成报告。代码仅作演示，运行前请对照官方文档确认接口。

### 第一步：安装

```bash
pip install openai-agents duckduckgo-search
```

### 第二步：定义工具

```python
from agents import Agent, Runner, function_tool
from duckduckgo_search import DDGS

@function_tool
def search_web(query: str) -> str:
    """搜索网络信息"""
    with DDGS() as ddgs:
        results = list(ddgs.text(query, max_results=5))
    return "\n".join([f"{r['title']}: {r['body']}" for r in results])

@function_tool
def analyze_text(text: str) -> str:
    """分析文本，提取关键信息"""
    return f"文本长度：{len(text)}字，包含{len(text.split())}个词"
```

### 第三步：创建Agent

```python
research_agent = Agent(
    name="研究助手",
    instructions="""你是一个专业的研究助手。

工作流程：
1. 理解用户的研究需求
2. 将问题拆解为多个子问题
3. 对每个子问题做搜索
4. 综合分析搜索结果
5. 生成结构化报告

报告格式：
- 核心结论
- 关键发现（分点）
- 详细分析
- 信息来源
""",
    tools=[search_web, analyze_text],
    # 不指定 model 时使用 SDK 默认模型，可按需改成官方文档列出的模型名
)
```

### 第四步：运行Agent

```python
result = Runner.run_sync(
    research_agent,
    "帮我研究2026年AI Agent的市场规模和应用趋势"
)

print(result.final_output)
```

### 第五步：加一个"检查Agent"做质量保障

```python
checker_agent = Agent(
    name="质量检查员",
    instructions="""你是一个质量检查员，审核研究助手生成的报告。

检查标准：
1. 结论是否有数据支撑
2. 信息来源是否可靠
3. 分析是否全面
4. 是否有明显的逻辑漏洞

通过标准：以上4项全部达标。
如果未通过，指出具体问题。
""",
    tools=[search_web]
)

# 双Agent协作
research_result = Runner.run_sync(research_agent, research_question)
check_result = Runner.run_sync(
    checker_agent,
    f"请审核这份报告：{research_result.final_output}"
)

print("最终报告：", research_result.final_output)
print("审核结果：", check_result.final_output)
```

---

## 浏览器Agent：让AI替你操作网页

除了代码Agent，2026年还有一个非常火的方向——**浏览器Agent**。它可以直接操作浏览器，帮你完成各种网页操作。

### 什么是浏览器Agent？

浏览器Agent = AI + 浏览器控制权。它能：
- 打开网页
- 点击按钮
- 填写表单
- 提取信息
- 完成复杂操作

### 主流浏览器Agent

**Anthropic Computer Use：** Claude 4的"电脑操作"能力，可以直接控制浏览器，执行点击、输入、滚动等操作。

**OpenAI Operator：** 2026年发布的浏览器Agent，可以在网页上完成订餐、购物、填表等任务。

**Browser Use（开源）：** 一个开源项目，可以接入 GPT、Claude 等模型控制浏览器。

### 实战：用浏览器Agent自动填表

```python
from browser_use import Agent

agent = Agent(
    task="打开谷歌表单，填写姓名、邮箱、电话，然后提交",
    llm="<按官方文档填写模型>"
)

await agent.run()
```

---

## AI Agent 的赚钱方式

AI Agent不仅是技术趋势，也是**赚钱工具**。这里分享几个已验证的变现思路：

### 1. 卖Agent模板

很多人不会写代码，但需要Agent。你可以制作各种Agent模板出售：
- **客服Agent模板**：$50-100/份
- **研究助手Agent模板**：$30-80/份
- **社交媒体自动化Agent**：$100-200/份

### 2. Agent即服务（AaaS）

帮企业搭建定制Agent：
- 自动化客服Agent：$500-2000/项目
- 数据采集Agent：$300-1000/项目
- 报告生成Agent：$500-2000/项目

### 3. 个人效率Agent

为自己搭建Agent，提升工作效率：
- 自动整理邮件
- 自动生成周报
- 自动监控竞品信息
- 自动回复客户咨询

---

## 总结

2026年，AI Agent 的爆发才刚刚开始。

**对于普通用户：** Agent 工具可以把多步骤的重复任务交给 AI 完成，但它仍会出错，涉及付款、发送消息、删除文件等不可撤销的操作，要保留人工确认。

**对于开发者：** 现在是最好的入场时机。Agent框架已经成熟，但应用场景还远未被发掘。每个领域都值得用Agent重做一遍。

**核心建议：**
1. **从简单开始**，先搭一个"研究助手"Agent
2. **找到适合你的框架**，推荐 Anthropic Agent SDK 或 OpenAI Agents SDK
3. **多实践**，Agent的能力在实战中才能真正体现
4. **关注安全问题**，给Agent设置权限边界

---


## 更新记录

- 2026-10-28：更正各 Agent 框架发布时间；区分 Claude API 工具调用与 Claude Agent SDK 并修正示例代码；删除过时模型名和夸大表述

## 相关阅读

- [Claude Duet 发布：不等你开口先干活，主动型 Agent 大战开始了](/posts/2026-10-22-claude-duet-launch/)
- [2026年AI效率工作流搭建指南：把ChatGPT+Claude+Cursor串起来用才叫效率翻倍](/posts/ai-workflow-guide-2026/)
- [AI智能体实战指南：用n8n搭建你自己的AI自动化工作流](/posts/ai-agent-workflow-guide-2026/)
- 更多「AI工具实测」文章：[/categories/ai工具实测/](/categories/ai工具实测/)
