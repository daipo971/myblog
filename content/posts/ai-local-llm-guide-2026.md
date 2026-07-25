---
title: "不用联网也能用AI：本机运行大模型完整指南（Ollama + LM Studio）"
date: 2026-07-25
description: "完全免费、离线可用、隐私安全。手把手教你用Ollama和LM Studio在自己电脑上运行AI大模型，Mac和Windows都能用。"
summary: "Ollama和LM Studio双教程，教你完全免费地在自己的电脑上运行AI大模型。离线可用、隐私安全、没有限额。"
tags: ["Ollama", "LM Studio", "本机AI", "免费AI", "隐私", "大模型"]
showtoc: true
---

你有没有想过一个问题——如果哪天所有AI工具都断网了，或者免费额度用完了，怎么办？

我最近越来越在意这个事。不是因为偏执，而是因为有些东西真的不适合发到云端。比如我的日记、客户的代码、还有一些私人文档。

于是就研究了一下**在本机运行AI大模型**这条路。试了一圈下来发现，现在的开源模型已经相当能打了。虽然比不上GPT-4o那么强，但日常写东西、分析代码、聊聊天完全够用，而且完全免费、完全离线。

这篇就把两种主流方案都说清楚。

---

## 方案一：Ollama — 最简单，Mac/Linux首选

Ollama 是目前最流行的本地大模型运行工具，没有之一。优势就是一个字：**简单**。

### 安装

```bash
# Mac
brew install ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh
```

Windows用户去 [ollama.com](https://ollama.com/) 下载安装包就行。

装完终端运行 `ollama serve` 启动服务，然后在另一个窗口 `ollama run` 选模型。

### 选哪个模型

Ollama 支持几十个开源模型。说几个我实测好用的：

| 模型 | 大小 | 能力 | 推荐配置 |
|------|------|------|----------|
| llama3.1:8b | 4.7GB | 日常对话、写作 | 8GB内存以上 |
| qwen2.5:7b | 4.1GB | 中文能力强 | 8GB内存以上 |
| mistral:7b | 4.1GB | 代码和推理 | 8GB内存以上 |
| deepseek-coder-v2 | 8GB+ | 写代码超强 | 16GB内存以上 |
| qwen2.5:32b | 20GB | 接近GPT-4水平 | 32GB内存以上 |

我的MacBook Air M1（16GB）日常用 `qwen2.5:7b` 非常流畅。如果你配置低一些，`llama3.2:3b` 只有2GB，大部分电脑都能跑。

### 使用方式

```bash
# 下载并运行模型
ollama run qwen2.5

# 在终端里直接对话
>>> 帮我写一封请假邮件
```

但更实用的用法是配合其他工具：

**Open WebUI** — 给Ollama加上ChatGPT一样的Web界面：
```bash
docker run -d -p 3000:8080 \
  -v open-webui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
  ghcr.io/open-webui/open-webui:main
```

装完打开 `localhost:3000`，界面跟ChatGPT一模一样，只是背后跑的是你自己的模型。

### 隐私优势

所有数据都在本机，断网也能用。我出差在飞机上就经常用Ollama写东西，旁边的人看我对着终端敲字以为我在写代码，其实我在跟AI聊天。

---

## 方案二：LM Studio — 图形界面，新手友好

如果你不想碰命令行，LM Studio 是更好的选择。它自带漂亮的图形界面，下载模型、加载、对话全部鼠标操作。

### 安装

去 [lmstudio.ai](https://lmstudio.ai/) 下载，Mac和Windows都有。

安装完打开，界面分三块：
- **左侧**：模型浏览器，搜索和下载模型
- **中间**：聊天窗口，跟模型对话
- **右侧**：配置面板，调整参数

### 选模型

LM Studio 直接从 Hugging Face 下载模型。推荐几个我实测的：

1. **Qwen2.5-7B-Instruct-GGUF** — 中文能力最强的7B模型
2. **Llama-3.1-8B-Instruct-GGUF** — 英文和推理能力强
3. **Mistral-7B-Instruct-v0.3-GGUF** — 轻量但全面

注意选GGUF格式，用 `Q4_K_M` 量化版本，效果和体积的平衡最好。

### 本地API服务器

LM Studio 有一个隐藏功能——启动本地API服务器。打开设置开启"Local API Server"，然后任何支持OpenAI API的工具都能调用你本地的模型。

举个例子，在Cursor里把API地址改成 `http://localhost:1234/v1`，就能用本地模型帮你写代码了。完全离线，代码不会离开你的电脑。

---

## 两个方案怎么选

| | Ollama | LM Studio |
|---|---|---|
| 上手难度 | 需终端命令 | 纯图形界面 |
| 模型管理 | 命令行操作 | 可视化下载 |
| 速度 | 略快 | 略慢 |
| API兼容 | 需额外配置 | 开箱即用 |
| 系统支持 | Mac/Linux为主 | Mac/Windows |

我的建议是：**终端老手用Ollama，新手或Windows用户用LM Studio**。

我自己是两个都装了。Ollama 用来日常快速对话，LM Studio 用来跑本地API服务器给其他工具用。

---

## 硬件要求和避坑

### 内存是关键
- 8GB内存：可以跑3B-7B的模型，速度还行
- 16GB内存：7B-14B的模型流畅运行
- 32GB以上：可以跑30B以上的大模型

### 量化很重要
本地模型一般都选量化版本，简单理解就是把模型"压缩"一下，体积变小、速度变快，能力损失很小。

Q4_K_M 是最推荐的量化级别。Q8更好但体积大一倍，Q2虽然小但质量下降明显。

### GPU加速
Mac用户不用管，M系列芯片自动用GPU跑。
Windows用户如果有NVIDIA显卡，LM Studio 会自动用CUDA加速。
没有独立显卡也别慌，CPU跑7B模型虽然慢一点，但也能用。

---

说实话，本地模型现在的发展速度远超我的预期。去年这个时候7B模型还像个呆子，现在Qwen2.5-7B已经能写完整的Python脚本了，有时候写得比我还好。

如果说有什么趋势值得关注，我觉得"AI本地化"是2026年最大的一个。当所有AI公司都在涨价、限额、收割用户的时候，开源社区正在让AI真正变成每个人都可以拥有的东西。

免费、离线、隐私安全——这三个理由够不够？

👉 [下载Ollama](https://ollama.com/)
👉 [下载LM Studio](https://lmstudio.ai/)
👉 相关阅读：[免费AI工具合集](/posts/7-free-ai-tools-2026/)
👉 更多：[Claude Code和Codex CLI指南](/posts/claude-code-codex-cli-2026/)

*文章写于2026年7月，各工具版本可能会有更新。*
