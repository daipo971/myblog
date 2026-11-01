---
title: "MiniMax M3.1 Flash 权重今日放出：许可证已落地，商用门槛比预想低"
date: 2026-10-23T09:40:00+08:00
lastmod: 2026-10-23T09:40:00+08:00
draft: false
description: "MiniMax 10 月 23 日放出 M3.1 Flash 模型权重：总参数 428B、激活 23B，上线 72 小时真实用户 token 超 1 万亿，首日即获 vLLM、SGLang 与多家国产芯片支持。"
tags: ["快讯", "开源模型", "国产大模型", "MiniMax"]
categories: ["中国与开源模型"]
---

10 月 19 日发布 API 的 MiniMax M3.1 Flash，今天（10 月 23 日）按计划放出了模型权重。这是 10 月国产模型「Flash 双强」格局里的另一只靴子落地——另一只是 10 月 17 日的 DeepSeek V4.1 Flash。

> **10 月 23 日晚更新**：权重许可证已于同日公布，本文结论已同步修订——详见下方许可证一节。

## 这次放出了什么

- **规模**：总参数 428B，每 token 激活约 23B；100 万 token 上下文，文本、图片、视频输入。
- **热度**：官方数据，上线 72 小时内真实用户处理的 token 超过 **1 万亿**。
- **技术**：全模型稀疏注意力、量化感知训练（QAT）、功耗感知调度，日常场景输出 200+ TPS。
- **生态首日拉满**：芯片侧有华为昇腾、平头哥、昆仑芯、摩尔线程、壁仞、海光、沐曦、天数、NVIDIA、AMD；云侧有 Together AI、Fireworks、Nebius、Baseten、Modal、DigitalOcean；推理框架 vLLM、SGLang、智源 FlagOS 同步支持；Hugging Face、魔搭社区同步上架。

价格线同步再确认一遍：输入 $0.15 / 百万 token，输出 $0.60 / 百万 token，缓存读取 $0.015 / 百万 token——不分时段、不分长度，一口价。

## 许可证已落地：社区许可证，门槛比预想低

权重已同步上架 Hugging Face 和魔搭社区，许可证随权重一同公布：**MiniMax 社区许可证（MiniMax Community License）**，和上一代 M3 一脉相承——不是 Apache 2.0，也不是 MIT，但实际门槛比预想低得多：

- **非商用**（研究、学习、个人项目）：免费使用，可修改、可再分享；
- **商用**：要在产品显著位置标注「Built with MiniMax M3.1-Flash」；年营收在 **2000 万美元以下**的，发一封邮件通知 MiniMax 即可，不用等批准；
- 只有**年营收超过 2000 万美元**的大企业，才需要事先拿到书面许可。

对比之下，DeepSeek V4.1 Flash 的 **MIT 协议**仍然最省心——拿来即用、无任何义务。但对绝大多数开发者和小公司来说，M3.1 Flash 这套「挂个名 + 发封邮件」的商用条件，基本等于可以直接开干。

所以结论更新为：**权重可以下、可以部署、可以商用**——记得标注来源、发出那封通知邮件就行。

## 多说一句：为什么偏偏是今天开源

有分析把 10 月 23 日这个时间点和 10 月 16 日的中国 AI 出口管制新规连起来看：已开源的模型明确豁免，拿到「公开发布」的事实标记后，商用 API 不受 23 项管制目录约束。开源既是技术动作，也是合规动作。

接下来值得盯的两件事：Hugging Face 上的实际下载量与社区评测，以及 GLM、Kimi、Qwen 是否跟进打价格战。

## 参考来源

- [TechNode：MiniMax 开放 4280 亿参数 M3.1 Flash 权重（英文）](https://technode.com/2026/10/23/minimax-releases-open-weights-for-428-billion-parameter-m3-1-flash-model/)
- [OpenRouter：MiniMax M3.1 Flash 模型页（价格、上下文）](https://openrouter.ai/minimax/minimax-m3.1-flash)

文中跑分、价格等数据多为厂商官方说法，以官方最新公布为准。

## 相关阅读

- [MiniMax 模型档案：规格、价格、许可证与国内用法](/posts/minimax-guide/)：这个模型的全部信息汇总，持续更新
- [MiniMax M3.1 Flash 发布：价格只有 DeepSeek 的一半，但有个毛病得先说清](/posts/2026-10-21-minimax-m3-1-flash/)
- [DeepSeek-V4.1-Flash 来了：更快更便宜，MIT 开源随便用，附国内使用指南](/posts/2026-10-18-deepseek-v41-flash/)
- [Kimi K3.1 Pro 发布：编程跑分超 GPT-6，11 月 4 日开源全部权重](/posts/2026-10-24-kimi-k3-1-pro-launch/)
- 更多「中国与开源模型」文章：[/categories/中国与开源模型/](/categories/中国与开源模型/)
