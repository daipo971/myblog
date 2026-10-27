---
title: "Muse Wonder 不免费：Meta 首个前沿模型定价对标 Opus，开源时代结束了？"
date: 2026-10-13T15:45:00+08:00
draft: false
tags: ["快讯", "行业动态", "Meta", "Muse"]
categories: ["AI前沿动态"]
description: "Meta 昨日发布首个前沿模型 Muse Wonder / Wonder Full，API 定价 $4/$20 每百万 token，直接对标 Claude Opus 5.5——是上一代 Muse Spark 1.3 的三倍。本文解析它的能力、定价和背后的转向。"
---

昨天（10 月 12 日），Meta 的超级智能实验室发布了 **Muse Wonder** 和加强版 **Wonder Full**——公司首个真正意义上的前沿（frontier）大模型。但比跑分更值得聊的，是价格：**$4 / $20 每百万 token**，和 Claude Opus 5.5 一个价，直接是上一代 Muse Spark 1.3（$1.25/$4.25）的三倍。

Meta 花了两年时间坚称自己会坚持开源路线，Wonder 的定价单宣告这个时代结束了。

## 先说结论

- **是什么**：Meta 首个前沿级模型，主打 agent 场景，1M 上下文，多模态输入（文本/图像/视频/音频/PDF）
- **两个版本**：Muse Wonder 走 Meta Model API（$4 输入 / $20 输出）+ Muse Code；Wonder Full 只给 Muse Code $50/$200 订阅用户，不上 API
- **跑分**：Artificial Analysis 智能指数 Wonder 52、Wonder Full 56；Opus 5.5 是 58，GPT-6 Astra 53——独立评测里没赢，但咬得很紧
- **核心卖点**：Active Memory（跨对话记住关键信息）+ Active Focus（死磕难题、卡住换路子、动手前先确认）
- **权重**：闭源。安全报告承诺了但还没发

## 定价：三倍涨幅，对标 Opus

这是全文最重要的一张表：

| | Muse Spark 1.3（上一代） | Muse Wonder（这次） | Claude Opus 5.5 |
|---|---|---|---|
| 输入 / 百万 token | $1.25 | **$4** | $4 |
| 输出 / 百万 token | $4.25 | **$20** | $20 |

Artificial Analysis 测的单任务成本：Wonder 跑一次智能指数任务 $4.52，是 Spark 1.3（$1.60）的近三倍。

Meta 自己的说法是"能力到了前沿，价格自然到前沿"。但换个角度看：过去两年 Meta 靠 Llama 系列扛着"开源普惠"大旗，现在亲手给旗舰模型标上 Opus 级的价格——**开源故事和赚钱故事，Meta 选了后者**。Llama 的免费午餐，大概率不会再有下一顿。

## 能力：Agent 味很重

Wonder 的两个招牌功能都是为 agent 设计的：

**Active Memory**：长对话里记住关键信息，相关时自动拎出来。Meta 内部有个 MemoryBench（在 6.4 万~10 万 token 的对话里藏事实、中途改事实、加干扰项），Wonder 双版本拿 85.5 分，比 Meta 测过的所有模型都高。

**Active Focus**：卡住了不放弃，换路子、绕过去、真拿不准就问你，动手干大事之前先确认。用 agent 的人都知道，"不瞎搞"比"能干活"更难得——Meta 的模型卡里自己都建议， irreversible 的操作一定要让人类确认。

跑分上，Terminal-Bench 4.0（命令行任务）Wonder Full 从 33% 跳到 57%，编码 agent 指数 68 分追平 Anthropic 顶级模型。短板是事实性知识（AA-Omniscience 只拿 30 分），背书类任务别指望它。

## 谁能用、谁用不上

- **开发者**：Meta Model API 今天就能调（`muse-wonder-1.0`，OpenRouter 上也有 `meta/muse-wonder`），兼容 OpenAI 和 Anthropic 的接口格式，迁移成本低
- **Muse Code 订阅用户**：Wonder Full 只在这儿，$50/$200 两档
- **普通用户**：Muse App 的集成是"即将上线"，而且 App 目前**仅美加可用**，国内用户先别惦记

## 三个冷静点

1. **跑分注水嫌疑**：Meta 自家图表里 Wonder Full 处处赢 Opus，但独立评测（AA 指数 56 vs 58）没复现。信第三方，别信发布会 PPT
2. **安全报告没发**：模型卡里提了化学/生物风险相关内容，但完整安全报告还没公布，安全声明暂时无法核验
3. **价格≠性价比**：$4/$20 和 Opus 同价，但独立跑分低 2~6 分。同样的钱，买 Opus 5.5 目前更稳——除非你的场景特别吃"主动记忆"

## 一句话

Muse Wonder 标志着 Meta 的彻底转向：从"Llama 普惠开源"到"前沿模型按前沿价格卖"。对开发者是多了个可选的强力 agent 模型，对行业是又一个信号——**免费的前沿模型时代，正在关门**。国产的 DeepSeek、Qwen、GLM 们，压力给到了价格端。

---

*参考：Meta 官方模型卡、Artificial Analysis、TechCrunch、dev.to 实测汇总*

## 相关阅读

- [开源倒计时：阶跃 Step 5 Preview 登顶 OpenRouter 趋势榜，10 月 15 日放出权重前先看懂这几件事](/posts/2026-10-13-step-5-preview/)
- [Kimi K3.1 Pro 发布了：国产 3T 大模型，能跟 Claude Opus 掰手腕，普通人这样免费用上](/posts/2026-10-27-kimi-k3-1-pro-guide/)
- [Reflection Beam 解析：501B 参数的「西方 DeepSeek」，权重还没发，先看懂这 8 件事](/posts/2026-10-08-reflection-beam-jiexi/)
- 更多「AI前沿动态」文章：[/categories/ai前沿动态/](/categories/ai前沿动态/)
