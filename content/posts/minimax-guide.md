---
title: "MiniMax 模型档案：M3.1 Flash 规格、价格、许可证、幻觉率与国内用法"
date: 2026-10-28T06:10:00+08:00
lastmod: 2026-10-28T06:10:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["档案", "国产大模型", "开源模型", "MiniMax"]
description: "上海 MiniMax 大模型的持续更新档案：M3.1 Flash 的发布与开源时间线、428B 参数规格、$0.15 输入价、社区许可证商用条件、93% 幻觉率的正确用法和国内使用渠道。"
showtoc: true
---

**MiniMax 是上海的大模型公司，目前主力模型是 2026 年 10 月 19 日发布、10 月 23 日开源权重的 M3.1 Flash。** 它的定位是「快而便宜」：API 输入价 $0.15 / 百万 token，输出 200+ token/秒，100 万上下文。最大的短板是幻觉率高，不适合直接当知识问答的唯一信源。

这一页是 MiniMax 的档案页，每次有新版本或新消息都会更新。

## 版本时间线

| 时间 | 事件 | 要点 |
| --- | --- | --- |
| 2026-10-23 | M3.1 Flash 权重开源 | 上架 Hugging Face 和魔搭社区，MiniMax 社区许可证同日公布 |
| 2026-10-19 | M3.1 Flash 发布 API | 速度为上一代 3 倍，价格为 DeepSeek V4.1 Flash 输入价的一半 |
| 更早 | M3 | 上一代模型，许可证体系与 M3.1 一脉相承 |

## M3.1 Flash 规格速查

| 项目 | 数据 |
| --- | --- |
| 参数 | 总参数 428B，每 token 激活约 23B |
| 上下文 | 100 万 token |
| 输入模态 | 文字、图片、视频 |
| 速度 | 日常场景输出 200+ token/秒 |
| 技术要点 | 全模型稀疏注意力、量化感知训练（QAT）、功耗感知调度 |
| 热度 | 官方称上线 72 小时内真实用户处理 token 超 1 万亿 |

开源首日生态支持较全：芯片侧有华为昇腾、平头哥、昆仑芯、摩尔线程、NVIDIA、AMD 等；推理框架 vLLM、SGLang 同步支持；Together AI、Fireworks 等云平台同步上线。

## 价格（API，每百万 token）

| 类型 | 价格 |
| --- | --- |
| 输入 | $0.15 |
| 输出 | $0.60 |
| 缓存读取 | $0.015 |

不分时段、不分长度，一口价。对比 [DeepSeek V4.1 Flash](/posts/2026-10-18-deepseek-v41-flash/) 闲时输入 $0.15、高峰 $0.30，MiniMax 在高峰时段更便宜，DeepSeek 的缓存价更低。

## 独立评测与幻觉率

独立评测机构 Artificial Analysis 的数据：

- 智能指数 **42**，上一代为 29。
- 单任务平均成本从 $0.51 降到 **$0.22**。
- HLE（高难知识题）从 39% 提到 48%。
- **AA-Omniscience 幻觉率 93%**：遇到不确定的问题几乎从不说「不知道」，而是编一个答案。

所以用法要分清：

- **适合**：写代码、跑 Agent 流程、长文档加工、创意生成，结果容易验证的活。
- **不适合**：直接当知识问答的唯一信源。要用在知识场景，接检索（RAG）或要求附出处，再人工核对。

## 许可证：能不能商用

M3.1 Flash 使用 **MiniMax 社区许可证（MiniMax Community License）**，不是 Apache 2.0 或 MIT，但门槛不高：

- **非商用**（研究、学习、个人项目）：免费，可修改、可再分享。
- **商用、年营收低于 2000 万美元**：在产品显著位置标注「Built with MiniMax M3.1-Flash」，并发邮件通知 MiniMax，不用等批准。
- **年营收超过 2000 万美元**：需事先获得书面许可。

对比之下，DeepSeek V4.1 Flash 的 MIT 协议没有任何义务，最省心。

## 国内怎么用

1. **MiniMax 官方 API、M Plan、MiniMax Code**：国内直连注册使用。
2. **OpenRouter**：上线时有 72 小时免费期，之后按官方价。
3. **Vercel**：有免费路由可以试手感。
4. **本地部署**：从 Hugging Face（需要 VPN）或魔搭社区下载权重，用 vLLM 或 SGLang 部署。428B 参数需要多卡服务器，个人电脑跑不动。

## 和其他国产模型怎么选

- 要便宜、要快、高频调用、Agent 干活：MiniMax M3.1 Flash 或 DeepSeek V4.1 Flash。
- 要最强效果、长文档和编程：[Kimi K3.1 Pro](/posts/kimi-guide/)。
- 商用最省心的许可证：DeepSeek V4.1 Flash（MIT）。

## 相关报道

- [MiniMax M3.1 Flash 发布：价格只有 DeepSeek 的一半，但有个毛病得先说清](/posts/2026-10-21-minimax-m3-1-flash/)
- [MiniMax M3.1 Flash 权重放出：许可证已落地，商用门槛比预想低](/posts/2026-10-23-minimax-m3-1-weights/)
- 更多中国与开源模型：[/categories/中国与开源模型/](/categories/中国与开源模型/)

## 更新记录

- 2026-10-28：建立档案页，收录 M3.1 Flash 发布、开源和许可证信息。

*资料来源：MiniMax 官方发布与 Hugging Face 模型页许可证（2026-10-23）；Artificial Analysis 独立评测；OpenRouter、Vercel 平台页面。免费额度以各平台实时页面为准。*
