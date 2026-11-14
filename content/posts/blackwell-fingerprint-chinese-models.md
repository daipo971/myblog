---
title: "六款中国模型被指用禁运芯片"
date: 2026-11-14T10:00:00+08:00
lastmod: 2026-11-14T10:00:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "国产大模型", "AI政策", "DeepSeek", "Kimi"]
description: "前 OpenAI 研究员 Will DePue 11 月 12 日发布报告，指 DeepSeek、Kimi 等 6 款中国模型带有禁运的 Blackwell 芯片指纹。报告承认：指纹只能说明初始权重来源，不能证明违法，四家公司未回应。"
showtoc: true
---

前 OpenAI 研究员 Will DePue 11 月 12 日发布一份法医报告，指 DeepSeek、Kimi 等 6 款中国模型带有被禁运的英伟达 Blackwell 芯片指纹。先说结论：**这是一份单方指控，不是定论**——报告自己承认，指纹只能说明生成初始权重的硬件，不能证明训练全程用了什么芯片、芯片在哪、谁拥有，更不能证明违反了出口管制；英伟达和涉事的四家公司到发稿时都没有回应。

![六款中国模型被指用禁运芯片封面](/images/blackwell-fingerprint-chinese-models/cover.webp)

## 报告指控了什么

报告题为《Top Chinese Frontier AI Models Carry the Fingerprint of Export-Controlled NVIDIA Blackwell GPUs》，作者 Will DePue 曾在 OpenAI 工作，现运营非营利研究组织 Unemployment Labs。报告称，对公开模型权重做法医分析后，6 个 2026 年 4 月以来发布的模型带有 Blackwell 指纹，而此前同厂模型读作上一代 Hopper：

- **DeepSeek**：DeepSeek-V4-Flash（2026 年 4 月，B200/B300）、DeepSeek-V4-Pro（2026 年 4 月，GB200/GB300）；此前 V3 读作 Hopper
- **月之暗面**：Kimi K3（2026 年 7 月，GB200/GB300）、Kimi K3.1-Pro（2026 年 11 月，GB200/GB300）；此前 K2、K2.5 读作 Hopper
- **MiniMax**：MiniMax-M3（2026 年 6 月，B200/B300）；此前 M2.7 读作 Hopper
- **蚂蚁集团**：Ling-3.1-flash（2026 年 10 月，GB200/GB300）；此前 Ling-3.0-flash 读作 Hopper

Blackwell 芯片出口到中国需要美国许可证，报告称目前没有公开报道显示有人拿到过这类许可。DePue 11 月 12 日晚把结论发在 X 上，帖子一夜获得 580 万次浏览。

## 指纹是怎么来的

方法本身不依赖内幕消息或泄密，全部基于各家自己公开发布的模型权重。通俗讲：

模型训练开始前，权重需要一组初始值，通常由伪随机数算法 Philox 按一个固定「种子」生成。PyTorch 会把生成任务分给 GPU 上的大量并行线程，不同芯片的处理器核心数不同，分到的线程数就不同，初始值落在权重里的位置也随之不同——就像同一串数字，用不同格数的棋盘摆出来，图案不一样。

报告搜了约 6 万亿种芯片布局与种子组合，去匹配公开权重里残存的初始值。按报告的说法，最强证据达到 49 至 1,385 sigma（衡量结果偏离随机巧合的程度），而纯巧合的预期上限约 8 sigma。DeepSeek-V4-Flash 和 Kimi K3 的匹配还在真实 Blackwell 芯片上复核过。报告称，该方法在 24 个已公开硬件信息的模型上全部吻合，包括英伟达自家说明用 GB200 训练的 Nemotron-3 Ultra。

## 报告自己承认的三处局限

这份报告的结论没有它标题听起来那么硬，作者自己写明了三处局限：

1. **指纹只说明初始权重的来源**。报告原话是：指纹说明权重是怎么生成的，「支持但不证明」Blackwell 也参与了训练。训练中途换硬件是可能的。
2. **不知道芯片在哪、谁拥有、怎么获得**。Blackwell 系统可以在中国境外的数据中心租用，报告明确写着：结论「不是任何法律被违反的认定」。
3. **规模估算作者自己都没把握**。报告估计 Kimi K3 约用 4,500 块、DeepSeek-V4-Pro 约用 3,000 块 Blackwell，五次运行共约 12,000 块，但作者在报告里写明「我们对这些估计没有把握」，因为它们依赖各家没有公开的训练效率、数据量和训练时长。

另外两点也值得注意：报告没有经过同行评审；DePue 称 OpenAI 与 Anthropic 的资深研究员独立验证过结果，但没有具名，两家公司也没有公开背书。

## 不是所有中国实验室都被点名

报告也列出了反例：阿里巴巴（Qwen）、智谱（GLM）、腾讯、小米、阶跃的最新模型仍读作 Hopper。DeepSeek 最新的 V4.1-Flash 里也没有发现指纹。也就是说，报告描述的是部分实验室、部分时间段的变化，不是整个中国 AI 行业的普遍情况。

相关阅读：[DeepSeek 完全指南](/posts/deepseek-complete-guide-2026/)、[Kimi K3.1 Pro 普通人上手指南](/posts/2026-10-27-kimi-k3-1-pro-guide/)、[MiniMax 模型档案](/posts/minimax-guide/)、[DeepSeek-V4.1-Flash 发布与国内使用指南](/posts/2026-10-18-deepseek-v41-flash/)。更多国产模型文章见[中国与开源模型](/categories/中国与开源模型/)栏目。

## 各方回应

截至发稿，英伟达、DeepSeek、月之暗面、MiniMax、蚂蚁集团都没有对这份报告作出回应。美国官员此前也曾指控 DeepSeek 和月之暗面使用 Blackwell 芯片，但没有公开过技术证据——这次是第一次有人拿出成套的分析方法。

## 对普通用户意味着什么

对普通用户来说，这件事目前没有直接影响：涉事模型都还在正常提供服务，Kimi、DeepSeek 的使用方式没有变化。值得跟进的只有两点：一是其他研究者能否复现这套指纹分析（报告附了种子值供复现），二是涉事公司会不会回应。只要这两点没落地，它就还只是一份「有方法、没定论」的指控，本站不会把它当成走私或违法的事实来写。

## 参考来源

- [Top Chinese Frontier AI Models Carry the Fingerprint of Export-Controlled NVIDIA Blackwell GPUs（Unemployment Labs，2026 年 11 月 12 日）](https://unemploymentlabs.com/checkpoint-forensics)
- [Export-banned Nvidia chips are behind China's most powerful AI models（TechCrunch，2026 年 11 月 13 日）](https://techcrunch.com/2026/11/13/export-banned-nvidia-chips-are-behind-chinas-most-powerful-ai-models-uh-oh-jensen/)

## 信息核验与更新记录

- **核对日期**：2026 年 11 月 14 日。
- **事实与推断分标**：6 个模型的 Blackwell 指纹、方法原理、sigma 数值、GPU 数量估算均来自 Unemployment Labs 报告原文；「不能证明违法」「芯片位置未知」是报告原文的明确限定；「未回应」指截至 2026 年 11 月 14 日上午，英伟达与四家公司均未公开回应。
- **经验值标注**：GPU 数量估算为报告作者的估算，作者本人声明没有把握，本文只转述，不作定论。
- **更新记录**：2026 年 11 月 14 日首发。

## 更新记录

- 2026 年 11 月 14 日首发。
