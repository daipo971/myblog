---
title: "Muse Ember 发布：Meta 最小最便宜的模型"
date: 2026-11-11T09:20:00+08:00
lastmod: 2026-11-11T09:20:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "AI Agent", "API", "Meta", "Muse"]
description: "Meta 11 月 9 日发布 Muse Ember：家族最小、最便宜的模型，专干智能体重复执行的活——工具调用、编程子任务、长文档解析。输入每百万 token 0.10 美元、1M 上下文，已上线 Meta Model API。"
showtoc: true
---

先给结论：**Meta 在 11 月 9 日发布了 Muse Ember，这是 Muse 家族最小、最便宜的一个模型。**它不跟旗舰拼最难的题，专干智能体每天重复成百上千次的活：调用工具、跑编程子任务、做路由分发、抽取信息、解析长文档。价格低到输入每百万 token 只要 0.10 美元。同一天 Anthropic 那边发的是走高端路线的 [Claude Fable 5.2](/posts/claude-fable-mythos-5-2-launch/)，两家正好一高一低。

![插画：许多小小的发光余烬节点各自忙着搬运文档、调用工具，围绕一个小核心有序流动](/images/muse-ember-launch/cover.webp)

## 它在 Muse 家族里是什么位置

Meta 现在的阵容分工写得很清楚：[Muse Wonder](/posts/2026-10-13-muse-wonder/) 负责最难的问题，Muse Spark 负责编程和智能体工作流，Ember 负责「量大、重复、要便宜」的执行层。官方原话是：最难的题让 Wonder 出方案，Ember 来扛量（Wonder plans, Ember carries volume）。

还有一个细节值得记：Ember 是第一个用 Muse Wonder Full 训练出来的模型——旗舰不只对外卖，也开始反哺小模型。这也是它敢说「小但能干复杂推理执行」的原因。

它还是原生多模态：文本、图片、音频、视频都能直接读，智能体看截图操作电脑、读扫描文档、听会议录音不用再换模型。

## 价格和规格

| 项目 | Muse Ember |
| --- | --- |
| 模型 ID | `muse-ember-1.0` |
| 输入价格 | $0.10 / 每百万 token |
| 缓存输入 | $0.004 / 每百万 token |
| 输出价格 | $0.50 / 每百万 token |
| 上下文 | 1M token |
| 最大输出 | 512K token |
| 渠道 | Meta Model API、Muse，另上架 Google Cloud 与 Oracle Cloud |

价格概念对比一下：同为 Muse 家族的 Spark 是 $1.25 / $4.25，Ember 的输入价只有它的十二分之一。官方博客只公布了上面这张牌价表；是否有长上下文分段计费之类的细则，公告里没有提，真要接入请以 Meta Model API 定价页的实时说明为准，不要按传闻估算成本。

## 跑分怎么看：便宜，但没掉队

以下数据来自 Artificial Analysis 2026 年 11 月 9 日的评测（Meta 官方公告引用，非本站实测），对比对象是 Anthropic 的小模型 Claude Haiku 5.5 和 OpenAI 的 GPT-6 Luna，均为各模型最高推理档：

| 基准 | Ember | Haiku 5.5 | GPT-6 Luna |
| --- | --- | --- | --- |
| 智能体综合任务 Agents' Last Exam | 61.6 | 57.0 | 57.1 |
| 业务流程自动化 AutomationBench-AA | 37.8 | 13.9 | 20.2 |
| 终端编程 Terminal-Bench 4.0 | 40.9 | 39.2 | 16.4 |
| 综合智能指数 Intelligence Index | 36 | 36 | 28 |

读法：综合智能和 Haiku 打平，但官方称达到同样成绩的成本约为三分之一；单个任务的平均成本约 0.14 美元（Artificial Analysis 口径）。对跑智能体的开发者来说，执行层换成 Ember，账单能直接降一个量级——这正是它存在的意义。

## 普通用户要不要管它

暂时不用专门去追。Ember 主要面向开发者和智能体产品：写代码、搭 agent 的人可以在 Muse 里直接选它，或用 API（支持 Responses API）把重复子任务分流过去省钱。普通聊天用户继续用 Muse 里的 Spark 就好，Ember 是幕后干活的那一层。

地区可用性方面，Meta 公告没有公布国家与地区名单，国内能否直连 Meta Model API 未核实，不要默认可用；想用 Muse 本体的可以先看 [Muse 注册指南](/posts/muse-how-to-register/)。

## 参考来源

- Meta 官方公告：[Introducing Our Smallest, Most Efficient Model: Muse Ember](https://research.meta.ai/blog/muse-ember)（2026-11-09）
- 跑分数据：[Artificial Analysis](https://artificialanalysis.ai) 评测（2026-11-09，经 Meta 公告引用）

## 信息核验与更新记录

- 2026-11-11 核对：本文价格、规格、渠道均以 Meta 官方公告原文为准；跑分标注为第三方评测口径，非本站实测；国内可用性未核实，已在正文标明。
