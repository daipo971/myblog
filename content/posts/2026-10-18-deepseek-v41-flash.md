---
title: "DeepSeek-V4.1-Flash 来了：更快更便宜，MIT 开源随便用，附国内使用指南"
date: 2026-10-18T16:30:00+08:00
lastmod: 2026-10-18T16:30:00+08:00
description: "DeepSeek 10 月 17 日发布 V4.1-Flash-1017：MIT 协议开源权重，API 输入低至 $0.15/百万 token，附带 Search 和 Fetch 联网 API。国内直接可用，这篇讲清楚怎么用最划算。"
categories: ["中国与开源模型"]
tags: ["快讯", "开源模型", "API", "DeepSeek"]
---

DeepSeek 昨天（10 月 17 日）又放了个新模型：**DeepSeek-V4.1-Flash-1017**。名字里的 1017 就是发布日期。这次不是拼榜单，而是一门心思做"又快又便宜"——推理速度提上去，API 价格打下来，权重还直接 MIT 开源。 Bloomberg 都专门报了，标题就一句话：faster and leaner。

## 先说结论：谁适合用

- **开发者/做应用的**：API 价格是真便宜，输入 $0.15/百万 token（闲时），缓存命中更是低到 $0.003，适合高频调用的场景。
- **本地部署党的**：MIT 协议，商用无限制，HuggingFace 和魔搭社区（ModelScope）都能下权重。
- **国内用户**：DeepSeek API 本来就国内直连，不用 VPN，这篇的方法全部直连可用。

## 价格拆开看

这次定价玩了个"波峰波谷"：

| 类型 | 闲时 | 高峰 |
|---|---|---|
| 输入 | $0.15 / 百万 token | $0.30 / 百万 token |
| 缓存输入 | $0.003 / 百万 token | $0.006 / 百万 token |
| 输出 | $0.60 / 百万 token | $1.20 / 百万 token |

高峰时段是工作日的 06:30–09:30 和 11:30–15:30（印度时间 IST），中国公共节假日除外。**缓存命中的价格是最大亮点**——$0.003 几乎等于不要钱，做 RAG、做 Agent 这种反复调用同一批上下文的场景，成本直接砍到脚踝。

上下文 100 万 token，单次最多输出 38.4 万 token，塞长文档、做大批量改写都够用。

## 两个新 API：Search 和 Fetch

这次 DeepSeek 还把自家的联网能力拆出来卖了：

- **Search API**：用它自己的搜索引擎找网页，$0.75 / 1000 次调用。
- **Fetch API**：把网页抓回来转成 Markdown，$0.75 / 1000 次调用。

有个羊毛：通过 DeepSeek Harness、Claude Code、Codex 的服务端工具调用 Search/Fetch，**到 2026 年 10 月 31 日 21:30（IST）之前免费**。薅得到就薅。

## 国内怎么用

1. **API**：直接去 DeepSeek 官网开，国内直连，支付宝/微信能付（按官网实际结算方式为准）。
2. **权重**：HuggingFace 要 VPN，嫌麻烦就去魔搭社区（modelscope.cn）搜 DeepSeek-V4.1-Flash-1017，国内镜像下载快。
3. **配套工具**：官方推荐 DeepSeek Harness v0.2.1-rc.1 及以上版本，腾讯的 CodeBuddy、WorkBuddy 也做了适配。

## 实话实说

- Flash 版的定位就是"够用且便宜"，极限推理能力别指望它去拼榜单第一，日常开发、客服、内容生成这类活儿，它是性价比之王。
- 高峰/闲时定价看着复杂，实际用下来：把高频任务往闲时排、善用缓存，账单会好看很多。
- 模型刚发布一天，社区量化版、部署教程还在路上，着急本地跑的可以先等一等。

DeepSeek 这波的思路很清楚：不跟你拼参数，拼的是"跑起来便宜"。对咱们这种要真刀真枪用的用户来说，这比榜单第一实在多了。

## 参考来源

- [TechNode：DeepSeek 发布 V4.1 Flash 1017（英文）](https://technode.com/2026/10/19/deepseek-releases-v4-1-flash-1017-with-stronger-coding-and-agent-capabilities/)
- [凤凰网科技：DeepSeek V4.1 Flash 更新报道](https://tech.ifeng.com/c/8xIZufSArx4)

文中跑分、价格等数据多为厂商官方说法，以官方最新公布为准。

## 相关阅读

- [DeepSeek 完全指南与版本档案](/posts/deepseek-complete-guide-2026/)：这个模型的全部信息汇总，持续更新
- [MiniMax M3.1 Flash 发布：价格只有 DeepSeek 的一半，但有个毛病得先说清](/posts/2026-10-21-minimax-m3-1-flash/)
- [DeepSeek 模型档案：版本、价格、许可证与国内用法](/posts/deepseek-complete-guide-2026/)
- [Beam 开源了：美国公司做了个「对标中国」的 501B 模型，Apache 2.0 随便用](/posts/2026-10-18-reflection-beam/)
- 更多「中国与开源模型」文章：[/categories/中国与开源模型/](/categories/中国与开源模型/)
