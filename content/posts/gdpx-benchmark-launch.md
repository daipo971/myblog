---
title: "SemiAnalysis 新基准：最强模型只拿 12 分"
date: 2026-11-02T18:35:00+08:00
lastmod: 2026-11-02T18:35:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "前沿研究", "Claude", "Gemini"]
description: "SemiAnalysis 11 月 2 日发布智能体基准 GDPx：206 个工作任务、11 个高价值领域，最强 Claude Opus 5.5 也只通过 12.0%。讲清它怎么考、谁赢谁输，以及 12% 为什么不等于「AI 干不了活」。"
showtoc: true
---

![GDPx 基准发布封面图](/images/gdpx-benchmark-launch/cover.webp)

**一句话结论：** 研究机构 SemiAnalysis 11 月 2 日发布新基准 GDPx，把当今最强的 AI 模型放进模拟真实工作环境里连续干几个小时的活——结果第一名 Claude Opus 5.5 的任务通过率只有 12.0%，Gemini 4 Carbon 以 10.9% 排第二，GPT-6 Astra 以 9.6% 排第三。这个分数低，首先是因为题是照着「难倒最强模型」的标准出的，不是模型突然变笨了。

## GDPx 考什么：11 个最值钱的领域，206 个真实任务

GDPx 的全称是通用智能体基准（General Agentic Benchmark）。SemiAnalysis 的选领域逻辑很直白：不按 GDP 占比选行业，只选它认为前沿 AI 最先赚到大钱的高回报领域，共 11 个——芯片设计、硬件设计、网络安全、生物、金融、法律、量化交易、递归自我改进、材料科学、对齐、软件工程；政府、房地产、保险被明确排除在外。

任务共 206 个，由 14 家专业数据公司按领域分别出题（例如生物领域的 LatchBio、软件工程领域的 Datacurve），SemiAnalysis 做最终质检。和 OpenAI 2025 年发布的 GDPval 那种「给一段提示词、交一份文件」的考法不同，GDPx 给的是完整的模拟工作环境：金融任务里有约 4000 份文件的真实交易数据室，模型要自己翻找资料、判断该看什么，再动手完成任务。每个模型用自家的智能体工具运行（Opus 5.5 用 Claude Code、Astra 用 Codex、Gemini 4 Carbon 用 Antigravity，没有的用 OpenCode 兜底），每个任务默认时限 8 小时。总分取三次尝试的 pass@1、11 个领域等权平均。

## 排行榜：第一名 12 分，赢家各拿各的领域

| 排名 | 模型 | GDPx 总分 | 平均每任务成本 |
| --- | --- | --- | --- |
| 1 | Claude Opus 5.5 | 12.0% | 约 51.41 美元 |
| 2 | Gemini 4 Carbon | 10.9% | 约 16.29 美元 |
| 3 | GPT-6 Astra | 9.6% | 约 53.99 美元 |

（数据来源：[GDPx 官网排行榜](https://gdpx.semianalysis.com)，查阅于 2026 年 11 月 2 日。）

总分之外，分领域看更有意思，没有哪个模型通吃：Opus 5.5 赢下量化交易、硬件设计和芯片设计，是官方口径的「最佳全能选手」；Gemini 4 Carbon 赢下生物和软件工程——本站上周刚介绍过这个[主攻网络安全的谷歌新模型](/posts/gemini-4-carbon-launch/)，它在 GDPx 上的总分还便宜：拿到接近第一名的成绩，每任务成本只有 Opus 5.5 的约三分之一；GPT-6 Astra 赢下递归自我改进和材料科学。最惨的是金融和法律：按二值评分（对就是对、错就是错），几乎所有模型都得 0 分——这两个领域对「差不多对」的容忍度最低，门槛也最高。

## 一个必须打问号的说法：安全分类器「拖了后腿」

SemiAnalysis 在原文里专门强调：Opus 5.5 和 GPT-6 Astra 的总分被自家的安全分类器「拖了后腿」（原文用词 sandbagged）——在网络安全、生物、对齐这三个领域，模型会因为安全规则拒绝或中断一部分任务。如果把这三个领域剔除、只看其余 8 个领域，排名会翻转：Astra 以约 0.1 个百分点的微弱优势反超 Opus 5.5 排到第一（同样出自 SemiAnalysis 公布的数据）。

这段要提醒读者：这是 SemiAnalysis 一家的说法和它自己重算的榜，不是独立机构的复测结果。安全拦截算不算「不公平」，本身就是个立场问题——对真要拿模型做安全研究的用户，拦截确实碍事；对普通用户，那些拦截恰恰是厂商承诺的安全底线。围绕 Astra 的争议最近不少，本站此前也报道过[路透称 DeepSeek、月之暗面被指蒸馏 Astra](/posts/deepseek-moonshot-distillation-report/) 一事，结论同样是先看证据、别急着站队。

## 普通读者怎么看这个 12%

三件事说清，避免误读：

第一，12% 是「刻意极难」的结果。SemiAnalysis 明说 GDPx 是按前沿难度设计的：出题标准就是让最强模型也只能做对一小部分，好让这个基准在未来一两年里还有区分度。它证明的是「离全自动干完高价值复杂工作还很远」，不是「AI 干不了活」——日常的写作、编程、查资料这类任务，根本不在这套题的难度带里。

第二，GDPx 是 SemiAnalysis 的付费研究产品，任务由合作公司出、没有经过独立第三方审计，而 SemiAnalysis 自己也明说目标是做「世界上最好的通用智能体基准」——它有让 GDPx 成为行业标准的话语权利益。所以这份榜适合当参考系，别当唯一真理。好消息是官网排行榜本身免费公开，本次查阅时无需付费或登录即可看完整榜单和分领域数据；该站从中国大陆能否直连，本次未核实。

第三，这份榜计划每 3 到 6 个月更新一版。分数会涨，排名会换，真正值得跟踪的是涨速：等 v2.0 出来，第一名从 12% 涨到多少，比今天谁第一更能说明问题。本站的 [AI前沿动态](/categories/ai前沿动态/) 中心页会持续跟进这类海外大厂与评测动态。

## 参考来源

- [SemiAnalysis 官方原文：GDPx: Measuring Frontier Model Capabilities Across the Most Valuable Domains](https://newsletter.semianalysis.com/p/gdpx-measuring-frontier-model-capabilities)
- [GDPx 官网与排行榜](https://gdpx.semianalysis.com)
- [Unite.AI：SemiAnalysis Launches GDPx Benchmark Spanning 11 Agentic Domains](https://www.unite.ai/semianalysis-launches-gdpx-benchmark-spanning-11-agentic-domains/)
