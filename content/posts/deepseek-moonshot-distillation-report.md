---
title: "路透：DeepSeek、月之暗面被指蒸馏 Astra"
date: 2026-10-29T14:05:00+08:00
lastmod: 2026-10-29T14:05:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "DeepSeek", "Kimi"]
description: "路透社 10 月 29 日转引 The Information 报道称，DeepSeek 与月之暗面训练模型时大量依赖了 GPT-6 Astra 的输出。三方未回应置评，蒸馏细节未披露，本文按「据报道、未证实」口径讲清这件事的来龙去脉。"
showtoc: true
---

**一句话结论：** 路透社今天（2026 年 10 月 29 日）转引 The Information 的报道称，DeepSeek 与月之暗面（Moonshot AI）训练最新模型时，大量依赖了 OpenAI 的 GPT-6 Astra 的输出。先把话说在前面：这是援引知情人士的报道，OpenAI、DeepSeek、月之暗面三方都没有回应置评，蒸馏细节也没有披露，**目前未证实**。

![路透称 DeepSeek、月之暗面被指蒸馏 Astra 封面图](/images/deepseek-moonshot-distillation-report/cover.webp)

## 报道说了什么

The Information 称（路透转引，援引直接知情人士）：月之暗面的 Kimi K3.1 Pro（上周发布）和 DeepSeek 的 V4.1-Flash 1017（10 月 17 日发布），都从蒸馏 Astra 中受益；两家训练最新模型时「大量依赖」了 Astra 的输出。

顺带给不熟悉的读者解释一句：蒸馏就是用一个强模型的回答当教材，去训练自己的模型。好处是能更快、更便宜地把能力追上来；争议在于，未经许可拿别家闭源模型的输出来训练，通常违反对方的服务条款，也是大厂眼里的「抄近道」。

## 为什么现在还不能下结论

- **三方未回应**：路透向 OpenAI、DeepSeek、月之暗面求证，三家都没有立即回应；截至本文发布，也还没有任何一方公开回应或否认。
- **细节缺失**：报道没有给出蒸馏的规模、方式和证据细节；The Information 原文在付费墙后，外界能核对的只有路透的转述。
- 所以本文标题用「被指」、正文用「据报道」：这是媒体援引知情人士的说法，不是任何一方的承认，也不是已证实的结论。

## 背景：蒸馏之争不是第一次

- OpenAI 在 9 月 30 日的官方发文里称，7 月初以来有一场协同的蒸馏行动，试图提取其模型的受保护推理，其核心一部分与月之暗面相关个人有关联；7 月 24–25 日两天出现约 1.6 万次带相关提取模式的请求（OpenAI 口径，原文注明是「尝试」口径，不等于成功提取），行动在 7 月 28 日被完全阻断。这同样是 OpenAI 的单方说法，要标注口径看。
- Anthropic 本月称，其新反制措施让针对 Claude 的所谓蒸馏攻击收获的数据减少了约 90%–99%（Anthropic 单方口径）。
- 蒸馏已经成了中美 AI 竞争的一个焦点议题：OpenAI、Anthropic、Google 的共同立场是，未经许可的蒸馏让对手能更快、更便宜地复制先进能力。

## 和本站已发文章的关系

被点名的两个模型，本站都写过：Kimi K3.1 Pro 的发布快讯和上手指南、DeepSeek V4.1-Flash 1017 的发布文都在站内（见相关阅读）。如果后续任何一方公开回应，本文会同步更新。

## 参考来源

- [路透社：DeepSeek, Moonshot used OpenAI's GPT-6 Astra to train latest models, The Information reports（英文）](https://www.reuters.com/technology/deepseek-moonshot-used-openais-gpt-6-astra-train-latest-models-information-2026-10-29/)
- [OpenAI 官方：Disrupting a coordinated model-distillation campaign（英文）](https://openai.com/index/disrupting-a-coordinated-model-distillation-campaign/)

## 更新记录

- 2026-10-29：首发。

## 相关阅读

- [AI前沿动态](/categories/ai前沿动态/)：本分类全部文章。
- [Kimi K3.1 Pro 发布快讯](/posts/2026-10-24-kimi-k3-1-pro-launch/)
- [Kimi K3.1 Pro 保姆级上手指南](/posts/2026-10-27-kimi-k3-1-pro-guide/)
- [DeepSeek V4.1 Flash 1017 发布](/posts/2026-10-18-deepseek-v41-flash/)
