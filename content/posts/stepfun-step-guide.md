---
title: "阶跃 Step 模型档案：Step 5 规格、开源许可证、价格与「1/8 成本」争议"
date: 2026-10-28T06:20:00+08:00
lastmod: 2026-10-28T06:20:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["阶跃星辰", "Step 5", "国产大模型", "开源模型"]
description: "阶跃星辰 Step 大模型的持续更新档案：Step 5 的发布与开源时间线、600B 参数规格、StepFun 模型许可证 1.0 商用条款、国内外 API 价格、1/8 成本说法的争议和部署门槛。"
showtoc: true
---

**阶跃星辰（StepFun）的最新旗舰是 Step 5 Preview：9 月 20 日发布，10 月 15 日开源权重。** 它主打长周期 Agent 任务和高性价比，在 OpenRouter 用量榜上一度位列全球第二。开源用的是阶跃自研的「StepFun 模型许可证 1.0」，对中小开发者基本无限制，对大厂和硬件预装有约束。

这一页是阶跃 Step 系列的档案页，每次有新版本或新消息都会更新。

## 版本时间线

| 时间 | 事件 | 要点 |
| --- | --- | --- |
| 2026-10-15 | Step 5 Preview 权重开源 | 许可证从 Apache 2.0 改为自研 StepFun 模型许可证 1.0 |
| 2026-10-12 | 上线腾讯 WorkBuddy | 10 月 12–25 日独家限免 |
| 2026-10-10 | 登顶 OpenRouter Trending 榜 | 日榜全球第二 |
| 2026-09-20 | Step 5 Preview 发布 | 新一代旗舰基座模型 |
| 更早 | Step 3.5 Flash、Step 3.7 Flash | 同一条「把算力高效转化为智能」的路线 |

## Step 5 规格速查

| 项目 | 数据 |
| --- | --- |
| 架构 | 稀疏 MoE，92 层窄深结构，Sparse GQA |
| 参数 | 总参数约 600B，每 token 激活约 27B |
| 上下文 | 最高 100 万 token |
| 输入模态 | 文本、视觉 |
| 主攻场景 | AI 编程、软件工程、专业知识工作、金融 |
| 官方仓库 | Hugging Face `stepfun-ai/Step-5-Preview-BF16`（另有 FP8 版） |

注意：Hugging Face 上有个 `SHSLab/Step-5-Preview-BF16` 镜像比官方早约 10 天出现，**它不是官方仓库**，下载认准 `stepfun-ai`。

## 成绩与热度

- **Artificial Analysis 智能指数 44 分**，一度位居全球开源第二，超过 Kimi K3（第三方数据）。
- **OpenRouter**：Token 用量周榜、日榜全球第二。
- **daily.dev Kingbench 3 编程实测**：8 个任务 67/80（83.75%），高于 GLM 5.3 Flash。
- 官方真实任务演示：GPU Kernel 优化连续执行约 22 小时、ESP32 开发板自主改造连续执行 3 小时以上（官方公布，效果受工具环境影响）。

## 价格（API）

| 区域 | 输入 | 输出 |
| --- | --- | --- |
| 国际 | $1 / 百万 token | $2.70 / 百万 token |
| 国内 | ¥7 / 百万 token | ¥20 / 百万 token |

### 「1/8 成本」怎么看

官方说法：按 Artificial Analysis 口径，Step 5 单任务成本 $0.71，Claude Opus 5 为 $5.86，约 1/8。

第三方质疑也很有道理：参照系选的是市面上最贵的模型之一；同一口径下 DeepSeek V4.1 Flash 单任务成本只有 $0.27，比 Step 5 更低。引用「1/8」时要同时写明参照系。

## 许可证：StepFun 模型许可证 1.0

- 商业产品**任一自然月月活超 1 亿或收入超 2000 万美元**：须显著展示「Powered by StepFun AI」。
- **硬件厂商预装**（手机、汽车、眼镜、可穿戴、机器人、智能家居）：须另签商业许可。
- **MaaS 连续 12 个月总收入超 2000 万美元**：须另获商业许可。
- 「衍生成果」定义很宽：微调、蒸馏、合并、量化、剪枝，以及实质基于模型输出训练的模型都算。

对个人开发者和中小团队基本无感，限制主要针对手机厂商、云厂商和大型 MaaS 平台。

## 怎么用

1. **在线体验**：阶跃开放平台 API 和 Step 5 Studio。
2. **第三方平台**：OpenRouter（DeepInfra、StepFun 提供服务）、Vercel AI Gateway、腾讯 WorkBuddy。
3. **自己部署**：BF16 体积约 1.2TB，官方 vLLM 镜像 `vllm/vllm-openai:step-5-preview`；FP8 单节点需 4×B300，BF16 需 8×B300 或 16×H200。个人工作站跑不动。
4. **社区量化**：已有 GGUF 版（256GB 起），但 llama.cpp 主线暂不支持该架构，只能用 ik_llama.cpp 分支，还很早期。

## 和其他国产模型怎么选

- 长周期 Agent、编程智能体，想要性价比：Step 5。
- 要最强综合效果：[Kimi K3.1 Pro](/posts/kimi-guide/)。
- 要最低价格：[MiniMax M3.1 Flash](/posts/minimax-guide/) 或 DeepSeek V4.1 Flash。

## 相关报道

- [开源倒计时：Step 5 Preview 登顶 OpenRouter 趋势榜](/posts/2026-10-13-step-5-preview/)
- [Step 5 开源复盘：协议改了、量化来了，「1/8 成本」经不经得起算](/posts/2026-10-15-step-5-review/)
- 更多中国与开源模型：[/categories/中国与开源模型/](/categories/中国与开源模型/)

## 更新记录

- 2026-10-28：建立档案页，收录 Step 5 发布、开源、许可证和价格信息。

*资料来源：环球网、上观新闻、澎湃新闻、IT之家 2026 年 9–10 月报道；Hugging Face 官方仓库与许可证原文（2026-10-15 人工核实）；Artificial Analysis；daily.dev Kingbench。社区量化进展转述自公开报道。*
