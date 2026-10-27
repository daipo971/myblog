---
title: "Beam 开源了：美国公司做了个「对标中国」的 501B 模型，Apache 2.0 随便用"
date: 2026-10-18T16:40:00+08:00
description: "Reflection AI 10 月 16 日放出 Beam 完整权重：501B 参数 MoE，Apache 2.0 协议，号称「面向中国开源模型的美国本土替代方案」。代码能力是强项，但独立跑分没它自己说的那么神。"
categories: ["中国与开源模型"]
tags: ["开源模型", "Reflection", "Beam", "大模型"]
---

美国初创公司 Reflection AI 在 10 月 16 日（周五）放出了自家模型 **Beam** 的完整权重。5010 亿参数，MoE 架构，**Apache 2.0 协议**——这是目前最宽松的开源协议之一，商用、魔改、蒸馏，随便折腾不用交钱。

有意思的是它的自我定位。Beam 公开展示时就明说自己是"面向中国开源模型的美国本土替代方案"（a US answer to China's open models）。再加上 10 月初的 Kolibri（德国）、Mistral Large 4（法国），四天之内三款西方开源模型接连发布，标尺齐刷刷对准中国模型——这波"开源"多少带着地缘政治的味道。

## 硬参数

- **规模**：501B 总参数，每 token 只激活 23B，100 万 token 上下文。
- **训练量**：预训练 23.8 万亿 token；强化学习阶段用了 10500 张 NVIDIA GB300，跑了四个星期，做了上亿次 rollouts。
- **发布形式**：BF16 / FP8 / NVFP4 三种精度，外加一个 DFlash2 推测解码器。NVFP4 版把约 1TB 的参数压到 280GB 左右，4 张 B200 能跑下。

## 跑分：官方说的 vs 独立测的

官方成绩单很亮眼：SWE-bench Verified 81.6%、Terminal-Bench 2.1 80.1%、GPQA Diamond 90.6%、AIME 2026 97.7%，自称推理 token 只用三分之一就能追平 GLM-5.2。

但独立评测泼了盆冷水：Artificial Analysis 的 Intelligence Index 给 Beam 打了 **30 分**，排在 GLM-5.3（45）、Kimi K3（44）、Mistral Large 4（38）后面。老实说：**代码和 Agent 任务是它的强项，综合推理排名还没证明自己**。看发布会 PPT 很爽，看第三方榜单再决定。

## 普通人能怎么用

1. **权重**：HuggingFace 可下（要 VPN），Apache 2.0，随便商用。
2. **本地跑**：完整版要 H200/B200 级别的卡，个人基本别想了；等社区量化版（GGUF）出来再说。
3. **API**：可以蹲第三方平台什么时候上架，按这定价策略应该不会贵。

## 实话实说

- 这是今年"西方开源反击战"里分量最重的一款，但别被"对标中国"的叙事带跑——**选模型只看三件事：你的任务它强不强、跑起来贵不贵、许可证松不松**。Beam 许可证是最松的，代码任务强，综合能力待验证。
- 对国内用户，它的最大价值可能是"又多了一个免费可商用的强代码模型"，而不是地缘政治大戏。
- 如果你已经在用 Qwen、GLM、Kimi 系的开源模型，Beam 目前没有非换不可的理由；但做 Agent/代码场景的，值得蹲一下社区实测。

## 相关阅读

- [Reflection Beam 模型档案：规格、许可、跑分与部署门槛](/posts/reflection-beam-guide/)：这个模型的全部信息汇总，持续更新
- [Reflection Beam 解析：501B 参数的「西方 DeepSeek」，权重还没发，先看懂这 8 件事](/posts/2026-10-08-reflection-beam-jiexi/)
- [DeepSeek-V4.1-Flash 来了：更快更便宜，MIT 开源随便用，附国内使用指南](/posts/2026-10-18-deepseek-v41-flash/)
- [Kimi K3.1 Pro 发布了：国产 3T 大模型，能跟 Claude Opus 掰手腕，普通人这样免费用上](/posts/2026-10-27-kimi-k3-1-pro-guide/)
- 更多「中国与开源模型」文章：[/categories/中国与开源模型/](/categories/中国与开源模型/)
