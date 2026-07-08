---
title: "Anthropic Claude 入门完整指南（2026版）"
date: 2026-07-05T00:00:00+08:00
draft: false
description: "从零开始学习 Anthropic Claude，包括 API 调用、Claude Pro 介绍、Claude Code CLI 使用、Artifacts 功能详解。适合新手入门。"
tags: ["Anthropic", "Claude", "AI", "教程"]
---

这两年 AI 工具发展太快，Anthropic 的 Claude 成了很多人首选的 AI 助手。相比其他模型，Claude 的优势很明显：

| 特性 | Claude | ChatGPT | Claude 的优势 |
|------|--------|---------|---------------|
| 上下文窗口 | 200K token | 128K | 能处理超长文档 |
| 长度限制 | 任意长 | 32K | 写文章、代码更流畅 |
| 代码能力 | 优秀 | 良好 | 支持 30+ 种语言 |
| 安全性 | 首屈一指 | 良好 | 很少胡说八道 |
| 思考模式 | Sonnet/Opus | 没有 | 处理复杂任务更强 |

这篇文章从零教你使用 Claude，不管是日常对话、API 调用还是代码开发，都能帮你快速上手。

## Claude 有哪些产品？

### 1. Claude Pro / Claude Max

Claude Pro 是付费订阅服务，每月 $20 美元（国内充值约 ¥140）。

**Pro 计划特色：**
- ⚡️ 更快响应速度
- 🎯 更快切换到 Sonnet 模型
- 📈 更高使用限额（每天 200 次对话 vs 普通 50 次）
- 🚫 去除未来可能的功能水印

**适用人群：**
- 日常高频使用者
- 开发者需要大量代码生成
- 想体验最新功能

### 2. Claude API

Claude API 提供完整的程序化访问能力，按 Token 计费。

**计费方式：**
| 模型 | 输入价格 | 输出价格 | 典型场景 |
|------|----------|----------|----------|
| Claude Haiku | $1/M | $5/M | 批量处理、成本低 |
| Claude Sonnet | $3/M | $15/M | 日常开发、最常用 |
| Claude Opus | $15/M | $75/M | 复杂任务、精细工作 |

### 3. Claude Desktop App

桌面应用，支持 macOS、Windows、Linux。

### 4. Claude Web + Claude Artifacts

网页版支持最新功能：
- **Artifacts** - 实时预览代码/设计
- **Projects** - 持久化对话项目
- **Canvas** - 协作文档编辑

## 快速开始

### 注册 Claude

1. 访问 https://claude.ai
2. 使用 Google / Apple / Email 注册
3. 完成手机号验证

**注册注意：**
- 首次注册可以免费试用 3 次对话
- 试用期结束后会要求绑定支付方式（不是扣款，只是验证）
- 不绑定也能继续用，但限额会降到每天 5 次对话

### 使用 Claude Web

```
┌──────────────────────────────────────────────────────────┐
│  Claude.ai (https://claude.ai)                           │
├──────────────────────────────────────────────────────────┤
│  ┌────────────────────────────────────────────────────┐  │
│  │  聊天窗口                                           │  │
│  │  "帮我写一个 Python 函数"                          │  │
│  │                                                     │  │
│  │  ┌──────────────────────────────────────────────┐ │  │
│  │  │  Claude 响应区域                             │ │  │
│  │  │                                             │ │  │
│  │  │  代码块高亮显示                              │ │  │
│  │  │  ┌──────────────────────────────────────┐ │ │  │
│  │  │  │ def hello():                         │ │ │  │
│  │  │  │     print("Hello, Claude!")          │ │ │  │
│  │  │  └──────────────────────────────────────┘ │ │  │
│  │  │                                             │ │  │
│  │  │  [Artifacts 按钮]                          │ │  │
│  │  └──────────────────────────────────────────────┘ │  │
│  └────────────────────────────────────────────────────┘  │
│                                                             │
│  提示词输入框 → 发送按钮                                    │
└──────────────────────────────────────────────────────────┘
```

### 基础使用技巧

**1. 清晰的 Prompt 模板**

```markdown
# 角色设定
你是一位 Python 专家，擅长写清晰、高效的代码。

# 任务目标
写一个函数，功能是...

# 输入格式
输入：...

# 输出要求
- 代码必须包含类型注解
- 必须有 Docstring
- 示例测试代码

# 上下文
我正在...
```

**2. 代码示例 Prompt**

```
# 用 Python 写一个函数，计算斐波那契数列的第 n 项
# 要求：使用动态规划优化性能
# 返回值类型：int
```

**3. 多轮对话技巧**

```
你：帮我优化这段代码

AI：这是优化后的版本...

你：速度还可以再快一点吗？

AI：这是进一步优化的版本...

你：最后一个版本最慢的部分是哪里？

AI：慢在递归调用...
```

## Claude API 快速入门

### 1. 注册并获取 API Key

1. 访问 https://console.anthropic.com
2. 使用 Google / GitHub 账号登录
3. 进入 API Keys 页面 → Create Key
4. 复制 API Key（格式：`sk-ant-xxx`）

### 2. 安装 SDK

**Python：**
```bash
pip install anthropic
```

**Node.js：**
```bash
npm install @anthropic-ai/sdk
```

**Go：**
```bash
go get github.com/anthropics/anthropics-go
```

### 3. Python 示例代码

```python
from anthropic import Anthropic

# 初始化客户端
client = Anthropic(
    api_key="你的 API Key"
)

# 发送消息
message = client.messages.create(
    model="claude-sonnet-4-20250514",  # 推荐用 Sonnet
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": "解释一下什么是递归算法"
        }
    ]
)

# 获取响应
print(message.content[0].text)
```

### 4. 常见 API 模式

**流式输出（Streaming）：**

```python
with client.messages.stream(
    model="claude-sonnet-4-20250514",
    max_tokens=1024,
    messages=[{"role": "user", "content": "写一首诗"}]
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

**系统提示词（System Prompt）：**

```python
message = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=1024,
    system="""你是一位资深软件工程师，
    专注于后端开发，擅长 Python 和 Go。

    回答风格：
    1. 代码优先
    2. 简洁明了
    3. 包含示例""",
    messages=[
        {"role": "user", "content": "我想学 Go"}
    ]
)
```

**并行内容：**

```python
message = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "分析这张图片"},
                {
                    "type": "image",
                    "source": {
                        "type": "base64",
                        "media_type": "image/jpeg",
                        "data": "图片base64数据..."
                    }
                }
            ]
        }
    ]
)
```

## Claude Code CLI 使用教程

Claude Code CLI 是在终端里直接调用 Claude 的命令行工具，对开发者非常友好。

### 安装 Claude Code

**使用 Homebrew（macOS）：**
```bash
brew install anthropic/claude-code/claude-code
```

**使用 npm（Node.js）：**
```bash
npm install -g @anthropic/claude-code
```

### 配置 API Key

```bash
claude-code configure
```

按提示输入 API Key，会保存在 `~/.config/claude-code/config.json`。

### 基础命令

```bash
# 打开交互式模式
claude-code

# 执行单条命令
claude-code "解释这段代码"
claude-code --prompt "帮我写一个函数" --language python

# 批量处理文件
claude-code --files path/to/file1.py path/to/file2.js

# 使用特定模型
claude-code --model opus "处理这个任务"
```

### 实战示例

**示例 1：代码分析**

```bash
claude-code --files app.py
```

Claude 会：
1. 读取文件内容
2. 分析代码结构和逻辑
3. 返回详细的分析报告

**示例 2：代码生成**

```bash
claude-code --language python --prompt "写一个 REST API 的装饰器"
```

Claude 会直接生成可运行的代码，包含注释和示例。

**示例 3：批量重构**

```bash
claude-code --files src/old/*.py
```

Claude 会逐个分析文件，提供重构建议。

## Claude Artifacts 功能详解

Artifacts 是 Claude 最受欢迎的功能之一——实时预览你生成的内容。

### 什么是 Artifacts？

简单说，就是：
- 你在聊天里让 Claude 生成代码
- Claude 生成后立即渲染成可交互的预览
- 不用切换标签页，直接在聊天里就能测试

### 使用 Artifacts

**1. 生成代码后点击 "Create"**

```
你：用 React 写一个计数器组件

Claude：这是一个计数器组件...

           [Create Artifact] 按钮
```

点击后，代码会渲染成一个实时预览页面。

**2. 在 Artifact 中交互**

```jsx
// 代码
function Counter() {
  const [count, setCount] = useState(0);
  return <div onClick={() => setCount(c => c + 1)}>{count}</div>;
}
```

点击数字就能测试计数功能，不需要打开新标签页。

**3. 分享 Artifact**

点击 Artifact 右上角的分享图标，可以生成公开链接。

### Artifacts 适用场景

| 类型 | 说明 | 示例 |
|------|------|------|
| 代码 | React/Vue/HTML 组件 | 计数器、表单 |
| 设计 | Figma 风格的界面设计 | Landing page 原型 |
| 文档 | Markdown/文档结构 | 技术文档、教程 |
| 数据 | 交互式数据可视化 | 图表、报表 |

## Claude Projects 功能

Projects 是 Claude 的「项目对话」功能，让你把相关内容集中管理。

### 创建 Project

1. 点击左侧 "Projects" 标签
2. 点击 "New Project"
3. 输入项目名称，如 "个人博客项目"

### 在 Project 中工作

```
┌─────────────────────────────────────────────────────┐
│  📁 我的博客项目                                     │
│                                                      │
│  ├── Hugo 配置                                       │
│  ├── 主题文件                                       │
│  ├── 内容草稿                                       │
│  └── 部署脚本                                       │
└─────────────────────────────────────────────────────┘
```

在 Project 中，Claude 会记住上下文，能更好地理解你的项目结构。

### Project 优势

- 📂 结构化组织对话
- 🔄 支持多人协作
- 💾 保存对话历史
- 🔍 快速搜索历史内容

## Claude 最佳实践

### 1. 合理使用模型

```
┌─────────────────────────────────────────────────────┐
│  快速问答 → Haiku                                    │
│  日常对话/代码 → Sonnet                             │
│  复杂任务/精细 → Opus                              │
└─────────────────────────────────────────────────────┘
```

### 2. Prompt 工程技巧

**少样本提示（Few-shot Prompting）：**

```markdown
# 输入格式
输入：1 + 1
输出：2

输入：2 + 2
输出：4

输入：3 + 3
输出：6

输入：5 + 5
```

**结构化输出：**

```markdown
请以 JSON 格式返回：

{
  "summary": "一句话总结",
  "key_points": ["要点1", "要点2"],
  "action_items": ["任务1", "任务2"]
}
```

### 3. 代码工作流

```
┌─────────────────────────────────────────────────────┐
│  第1步：让 Claude 理解需求                            │
│  第2步：生成初始代码                                  │
│  第3步：Claude Code CLI 本地调试                      │
│  第4步：返回 Claude 运行测试                          │
│  第5步：迭代优化                                      │
└─────────────────────────────────────────────────────┘
```

## 常见问题

**Q: Claude 和 ChatGPT 怎么选？**

A:
- Claude → 上下文长、代码能力强、更安全
- ChatGPT → 生态更丰富、工具更多

**Q: API Key 安全吗？**

A: 不要分享给别人，使用环境变量或 `.env` 文件存储。

**Q: 有免费额度吗？**

A: 注册后会送 3 次试用，之后 Pro 每月 200 次免费。

**Q: Claude 会记住之前的对话吗？**

A: 单次对话内可以，Projects 功能支持跨会话记忆。

**Q: 如何设置 Claude 为默认搜索引擎？**

A: 浏览器扩展可以设置，或者直接用 Claude 搜索网站。

## 写在最后

Claude 已经成为我日常工作的核心工具。不管是写代码、写文章还是分析问题，它都能提供很大帮助。

**推荐学习路线：**
1. 先用 Claude Web 体验基础功能
2. 注册 Claude Pro 享受更快的速度和更高的限额
3. 下载 Claude Desktop App 随时随地使用
4. 尝试 Claude Code CLI 提升开发效率
5. 最后使用 API 把 Claude 集成到你的项目里

**官方资源：**
- Claude 官网：https://claude.ai
- Claude API 文档：https://docs.anthropic.com/
- Claude Code GitHub：https://github.com/anthropics/claude-code

有问题欢迎留言，或者发邮件到 `daipo971@gmail.com`。

---

**相关文章：**
- [免费 VPS 对比指南](/posts/free-vps-guide/)

### 💡 升级 Claude Pro

免费版足够日常使用。如果你需要处理大量长文本、深度分析项目代码，或者想体验最前沿的 Sonnet/Opus 模型，可以升级到 Pro 版（$20/月）。

👉 **[免费注册 Claude →](https://claude.ai/)**
