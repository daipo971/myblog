---
title: "本地运行大模型教程：Ollama 和 LM Studio 离线用 AI"
date: 2026-07-25
lastmod: 2026-10-28T09:00:00+08:00
description: "在自己电脑上离线运行开源大模型的完整教程：Ollama 和 LM Studio 的安装、选模型（Qwen3、Gemma 3、gpt-oss、DeepSeek-R1 蒸馏版）、按内存选尺寸、量化怎么选、Open WebUI 界面和本地 API，附常见报错和常见问题。"
summary: "Ollama 和 LM Studio 本地运行大模型：安装、选模型、硬件要求、量化、常见报错。"
categories: ["中国与开源模型"]
tags: ["教程", "本地部署", "开源模型", "Ollama", "LM Studio"]
showtoc: true
---

**结论先说：** 想在自己电脑上离线用 AI，命令行用户装 Ollama，新手和 Windows 用户装 LM Studio，两者都免费。16GB 内存的电脑能流畅运行 7B–8B 级别的模型（如 Qwen3-8B），日常写作、翻译、总结够用；32GB 以上可以跑 20B–30B 级别。本地模型的能力不如云端旗舰，但数据不出电脑、没有额度限制、断网可用，适合处理日记、客户资料、公司代码这类不方便上传的内容。

## 为什么要在本地跑模型

- **隐私**：日记、合同、客户代码等敏感内容不离开你的电脑；
- **没有额度**：不受免费次数限制，可以批量处理；
- **离线可用**：在飞机上、内网环境里也能用；
- **免费**：除了电费和硬件，没有订阅费用。

代价是：能力不如 GPT、Claude 等云端旗舰模型；对内存和显卡有要求；需要自己选模型、调参数。

## 前置条件

| 项目 | 最低 | 推荐 |
| --- | --- | --- |
| 内存（统一内存或显存） | 8GB，可跑 3B–4B 模型 | 16GB 以上，可跑 7B–8B |
| 硬盘 | 剩余 10GB | 剩余 50GB 以上（模型文件较大） |
| 系统 | macOS（Apple 芯片）、Windows 10/11、Linux | Apple M 系列或带 NVIDIA 显卡的 PC |
| 网络 | 下载模型时需要联网 | 之后可完全离线 |

模型文件从 Ollama 官方库或 Hugging Face 下载；Hugging Face 国内访问不稳定时，可以从魔搭社区（ModelScope）下载 GGUF 文件再导入。

## 方案一：Ollama

[Ollama](https://ollama.com/) 是最流行的本地大模型运行工具，一条命令下载并运行模型，并在本机提供兼容 OpenAI 格式的 API。

### 第 1 步：安装

- **macOS / Windows**：在官网下载安装包，安装后会常驻后台，并提供一个简单的聊天窗口；
- **Linux**：

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

安装后在终端运行 `ollama --version`，能看到版本号即安装成功。Linux 下如果服务没有自动启动，运行 `ollama serve`。

### 第 2 步：下载并运行模型

```bash
# 下载并进入对话（首次会自动下载）
ollama run qwen3:8b

# 查看已下载的模型
ollama list

# 删除不用的模型，释放硬盘
ollama rm qwen3:8b
```

### 第 3 步：选模型

下面是 2026 年 10 月 Ollama 官方库里常用的模型，体积为默认量化版本的大致大小，以 [Ollama 模型库](https://ollama.com/library) 为准：

| 模型 | 体积 | 特点 | 建议内存 |
| --- | --- | --- | --- |
| qwen3:4b | 约 2.5GB | 阿里通义，中文好，轻量 | 8GB |
| qwen3:8b | 约 5GB | 中文日常主力 | 16GB |
| gemma3:12b | 约 8GB | Google 开源，支持看图 | 16GB |
| gpt-oss:20b | 约 14GB | OpenAI 开源权重模型，推理能力强 | 16GB 以上 |
| deepseek-r1:8b | 约 5GB | DeepSeek-R1 蒸馏版，会先思考再回答 | 16GB |
| qwen3:30b | 约 19GB | 混合专家模型，能力接近中大型模型 | 32GB |
| qwen3-coder:30b | 约 19GB | 写代码专用 | 32GB |

**选择建议：** 中文用户先试 `qwen3:8b`；内存只有 8GB 用 `qwen3:4b`；需要推理和数学选 `deepseek-r1:8b` 或 `gpt-oss:20b`；写代码且内存充足选 `qwen3-coder`。

### 第 4 步：加一个网页界面（可选）

终端对话不方便，可以用 [Open WebUI](https://github.com/open-webui/open-webui) 获得类似 ChatGPT 的界面（需要先安装 Docker）：

```bash
docker run -d -p 3000:8080 \
  -v open-webui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
  --name open-webui ghcr.io/open-webui/open-webui:main
```

打开 `http://localhost:3000`，注册一个本地管理员账号，选择已下载的模型即可对话，还支持上传文档提问。

## 方案二：LM Studio

[LM Studio](https://lmstudio.ai/) 是图形界面工具，下载模型、加载、对话全部用鼠标完成，支持 macOS、Windows 和 Linux。

### 第 1 步：安装

从官网下载安装包并安装。界面分为：模型搜索（Discover）、聊天（Chat）、本地服务器（Developer）几个区域。

### 第 2 步：下载模型

在搜索页输入模型名，例如 `Qwen3-8B`，选择 **GGUF** 格式（Mac 上也可以选 MLX 格式，速度更快）。同一个模型会有多个量化版本，新手选 `Q4_K_M`。LM Studio 会根据你的内存提示哪些版本能流畅运行。

### 第 3 步：对话和调参

在聊天页顶部选择模型加载。右侧可以调整：

- **上下文长度**：越长越能记住前文，但占用内存更多，先用默认值；
- **GPU 卸载层数**：有显卡时尽量调高，速度更快；
- **温度**：写作可以高一些（0.7–1.0），问答和代码低一些（0.2–0.5）。

### 第 4 步：开启本地 API

在 Developer 页面启动本地服务器（默认地址 `http://localhost:1234/v1`）。之后任何支持 OpenAI API 格式的工具（比如 Obsidian 的 AI 插件、沉浸式翻译、部分编程工具）都可以把 API 地址改成这个，调用本地模型，数据不出电脑。

## 两个方案怎么选

| | Ollama | LM Studio |
| --- | --- | --- |
| 操作方式 | 命令行为主，附简易窗口 | 纯图形界面 |
| 模型来源 | Ollama 官方库 | Hugging Face 等，选择更多 |
| 本地 API | 默认开启（端口 11434） | 手动开启（端口 1234） |
| 适合 | 开发者、需要脚本调用 | 新手、想调参数和多试模型 |

可以两个都装：Ollama 给脚本和其他程序调用，LM Studio 用来尝试新模型。

## 量化怎么选

量化就是降低模型参数的精度，让模型体积变小、速度变快，代价是能力略有下降。常见级别：

| 量化 | 体积 | 质量 | 建议 |
| --- | --- | --- | --- |
| Q8_0 | 大 | 接近原始 | 内存充足时用 |
| Q5_K_M | 中 | 很好 | 平衡之选 |
| Q4_K_M | 较小 | 较好 | 大多数人的默认选择 |
| Q2 / Q3 | 很小 | 明显下降 | 不推荐 |

经验法则：内存允许的情况下，「大模型的 Q4」通常比「小模型的 Q8」更聪明。

## 常见报错与解决

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| 下载模型很慢或失败 | 网络访问官方库或 Hugging Face 不稳定 | 换时段重试；从魔搭社区下载 GGUF 后在 LM Studio 导入 |
| 生成非常慢，一秒一两个字 | 模型太大，内存不足，用到了硬盘交换 | 换小一号模型或更低量化；关闭其他占内存的程序 |
| 提示 out of memory | 显存或内存不够 | 降低上下文长度、减少 GPU 卸载层数或换小模型 |
| Open WebUI 里看不到模型 | 容器连不上 Ollama | 确认 Ollama 正在运行；Linux 下把地址改为宿主机 IP，并让 Ollama 监听 0.0.0.0 |
| 回答全是英文或中英混杂 | 模型中文能力弱或提示不清 | 换 Qwen 等中文模型；在系统提示里要求「用简体中文回答」 |
| 推理模型输出很长的思考过程 | 正常行为 | 在客户端隐藏思考内容，或换非推理模型 |

## 本地模型能做什么、不能做什么

**适合：** 总结和改写敏感文档、翻译、写邮件和日常文案、离线问答、给笔记软件和翻译插件做后端、批量处理文本。

**不太适合：** 需要最新知识的问题（本地模型不联网）、复杂的长篇推理和大型代码工程、需要高质量多模态理解的任务。这些仍然交给云端模型更合适，比如 [DeepSeek](/posts/deepseek-complete-guide-2026/) 的 API 价格很低。

## 常见问题

**没有独立显卡能跑吗？**
能。Apple M 系列芯片会自动用 GPU 加速；普通 Windows 电脑用 CPU 也能跑 3B–8B 模型，只是速度慢一些。

**本地模型和 ChatGPT 差多少？**
7B–8B 模型能处理日常任务，但在复杂推理、长文写作和编程上和云端旗舰有明显差距。30B 以上的模型差距会缩小。

**本地运行真的完全不联网吗？**
模型下载完成后，Ollama 和 LM Studio 都可以断网使用。注意 Open WebUI 的联网搜索等功能需要单独关闭。

**可以商用吗？**
看模型的许可证。Qwen3、gpt-oss 等采用 Apache 2.0，DeepSeek 近期模型采用 MIT，允许商用；部分模型有额外限制，下载前看模型卡的 License。

**模型放在哪里，怎么清理？**
Ollama 用 `ollama rm 模型名` 删除；LM Studio 在「我的模型」里删除。模型文件动辄几 GB，不用的及时删。

## 更新记录

- 2026-07-25：首次发布。
- 2026-10-28：删除无法核实的个人使用经历，改为客观教程；模型推荐更新为 Qwen3、Gemma 3、gpt-oss、DeepSeek-R1 蒸馏版；补充前置条件、常见报错、量化说明和常见问题。

## 相关阅读

- [DeepSeek 模型档案](/posts/deepseek-complete-guide-2026/)
- [Reflection Beam 模型档案](/posts/reflection-beam-guide/)
- [阶跃 Step 模型档案](/posts/stepfun-step-guide/)
- 更多「中国与开源模型」文章：[/categories/中国与开源模型/](/categories/中国与开源模型/)
