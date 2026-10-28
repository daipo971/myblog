---
title: "Reflection Beam 模型档案：501B 开源模型的规格、Apache 2.0 许可、跑分与部署门槛"
date: 2026-10-28T06:30:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["档案", "开源模型", "Reflection"]
description: "美国 Reflection AI 开源模型 Beam 的持续更新档案：从 beta API 到权重开源的时间线、501B/23B MoE 规格、Apache 2.0 许可、官方跑分与独立评测差距、部署硬件门槛，以及它和国产开源模型怎么比。"
showtoc: true
---

**Beam 是美国 Reflection AI 的第一个开源大模型：10 月 5 日发布，10 月 16 日以 Apache 2.0 协议放出完整权重。** 它公开定位为「面向中国开源模型的美国替代方案」，代码和 Agent 任务是强项，但独立评测的综合排名明显落后于 GLM-5.3 和 Kimi K3。

这一页是 Beam 的档案页。把它放在「中国与开源模型」里，是因为它的对标对象就是国产开源模型，每次有新版本或新消息都会更新。

## 基本信息

| 项目 | 内容 |
| --- | --- |
| 公司 | Reflection AI，美国 |
| 当前模型 | Beam-501B-A23B（2026-10-05 发布） |
| 开源状态 | 2026-10-16 放出完整权重 |
| 许可证 | Apache 2.0 |
| 使用入口 | Hugging Face 权重、官方 beta API（候补制） |
| 国内可用 | 权重下载需海外网络，API 可用地区以官方为准 |

## 版本时间线

| 时间 | 事件 | 要点 |
| --- | --- | --- |
| 2026-10-16 | 权重开源 | Apache 2.0，BF16 / FP8 / NVFP4 三种精度，附 DFlash2 推测解码器 |
| 2026-10-06 前后 | beta API 开放候补 | 兼容 OpenAI 接口，256k 上下文，价格未公布 |
| 2026-10-05 | Beam 发布 | 权重承诺 10 月内放出，当时仍在做安全红队测试 |

## 规格速查

| 项目 | 数据 |
| --- | --- |
| 模型 ID | Beam-501B-A23B |
| 架构 | 稀疏 MoE，纯文本 |
| 参数 | 总参数 501B，每 token 激活 23B |
| 上下文 | 开源版 100 万 token（beta API 阶段为 256k） |
| 训练 | 预训练 23.8 万亿 token（6144 块 GB300，不到 4 周）；强化学习 10500 块 GB300 跑 4 周，上亿次 rollouts |
| 推理参数 | `reasoning_effort` 五档（low / medium / high / xhigh / max），没有关闭推理的开关 |

公司背景：创始人 Misha Laskin（曾负责 Gemini 奖励建模）和 Ioannis Antonoglou（AlphaGo 联创之一）都来自 Google DeepMind，Nvidia 参投。「西方 DeepSeek」这个外号来自投资人的采访，不是官方说法。

## 跑分：官方说法与独立评测

**官方成绩**（未经独立验证）：SWE-bench Verified 81.6%、Terminal-Bench 2.1 80.1%、GPQA Diamond 90.6%、AIME 2026 97.7%。官方称用约 1/3 的推理 token 追平 GLM-5.2。

**同一份官方榜单上的对比**：Terminal Bench v2.1 Beam 80.1，Kimi K3 88.3、GLM-5.3 88.2；DeepSWE v1.1 Beam 44.4，Kimi K3 68.0、GLM-5.3 61.0。也就是说，在官方自己公布的数据里，Beam 也没有赢过 Kimi K3 和 GLM-5.3。

**独立评测**：Artificial Analysis 智能指数 **30 分**，排在 GLM-5.3（45）、Kimi K3（44）、Mistral Large 4（38）之后。

一句话：代码和 Agent 任务可以试，综合推理还没证明自己。

## 许可证

**Apache 2.0**：可商用、可修改、可蒸馏，没有营收门槛或署名要求。这是 Beam 相对国产开源模型最明显的优势，对比 [MiniMax 社区许可证](/posts/minimax-guide/) 和 [StepFun 模型许可证](/posts/stepfun-step-guide/) 都更宽松。

## 部署门槛

| 精度 | 体积 | 硬件参考 |
| --- | --- | --- |
| BF16 | 约 1TB | H200 / B200 多卡服务器 |
| NVFP4 | 约 280GB | 4 张 B200 |
| 社区 GGUF 量化 | 待出 | 等社区量化版 |

个人电脑基本跑不动。普通用户更现实的路是等第三方 API 平台上架。

## 怎么用

1. **权重**：Hugging Face 下载（国内需要 VPN）。
2. **API**：官方 beta API 地址 `api.reflection.ai/openai/v1`，兼容 OpenAI 格式；也可以等第三方平台上架。
3. **选择建议**：已经在用 Qwen、GLM、Kimi 系开源模型的，没有非换不可的理由；做 Agent 或代码场景、又特别在意许可证宽松的，值得试。

## 同期的西方开源模型

10 月初还有法国 Mistral Large 4（万亿参数、原生多模态）和德国 Kolibri 接连发布，标尺同样对准中国模型。Beam 是其中分量最重的一款。

## 常见问题

**Reflection AI 是中国公司吗？**
不是。Reflection AI 是美国公司，创始人来自 Google DeepMind，Nvidia 参投。本站把 Beam 收在「中国与开源模型」里，是因为它公开对标的就是国产开源模型。

**Beam 比国产开源模型强吗？**
从现有数据看没有。官方榜单上它在 Terminal-Bench 和 DeepSWE 上落后于 Kimi K3、GLM-5.3；Artificial Analysis 的智能指数只有 30 分，低于 GLM-5.3 的 45 分和 Kimi K3 的 44 分。它最突出的优势是许可证。

**Apache 2.0 意味着什么？**
可以商用、修改、蒸馏，不需要署名，也没有营收门槛，是目前限制最少的开源许可证之一。相比之下，[MiniMax](/posts/minimax-guide/) 和 [阶跃 Step 5](/posts/stepfun-step-guide/) 的自研许可证都对大规模商用有额外要求。

**能关闭推理模式吗？**
不能。Beam 只提供五档 `reasoning_effort`（low 到 max），最低档也会推理。只要简单快速回答的场景，选 low 档或换别的模型。

**普通人怎么用上？**
官方 beta API 兼容 OpenAI 格式，需要申请候补；权重体积在 280GB 到 1TB 之间，个人电脑跑不动。比较现实的是等第三方 API 平台上架后再试。

**中文能力怎么样？**
官方没有单独公布中文评测，模型训练数据和测试以英文为主。中文场景建议先用自己的真实任务小规模对比，再决定是否替换国产模型。

**Beam 的官方跑分可信吗？**
目前只能当作参考。SWE-bench Verified 81.6% 等数字都是官方自报、尚未经独立复现；独立机构 Artificial Analysis 的综合分明显低于官方宣传给人的印象。选型时以独立评测和自己的实测为准。

**为什么叫「西方 DeepSeek」？**
这是媒体给的标签，指它走的是 DeepSeek 式路线：大规模稀疏 MoE、开放权重、主打性价比。实际能力和生态目前还没有达到 DeepSeek 的水平。

## 相关报道

- [Reflection Beam 解析：501B 参数的「西方 DeepSeek」](/posts/2026-10-08-reflection-beam-jiexi/)
- [Beam 开源了：美国公司做了个「对标中国」的 501B 模型，Apache 2.0 随便用](/posts/2026-10-18-reflection-beam/)
- 更多中国与开源模型：[/categories/中国与开源模型/](/categories/中国与开源模型/)

## 更新记录

- 2026-10-28：建立档案页，收录 Beam 发布、开源、跑分和部署信息。
- 2026-10-28：补充常见问题

*资料来源：Reflection AI 官方博客与文档（2026-10-06 读取）；TechCrunch、《华尔街日报》相关报道；Hugging Face 模型页；Artificial Analysis 独立评测。官方跑分未经独立验证。*
