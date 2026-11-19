---
title: "Gemini 完全指南：版本、会员、功能一览"
date: 2026-11-17T09:30:00+08:00
lastmod: 2026-11-19T10:00:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["指南", "AI入门", "Gemini", "Google"]
description: "Gemini 现在是哪四个模型、免费版够不够用、AI Plus、Pro 与 Ultra 五档怎么选？本文整理 2026 年 11 月的官方定价与 API 价格，附国内开通提醒与选型结论，一篇看懂。"
summary: "一句话结论：Gemini 4 现在是四模型分工，Hydrogen 快而便宜、人人可用，Neon 快而强、专啃复杂任务，Argon 是付费主力，Carbon 专啃最难的推理题。个人用户先看免费版够不够用，不够再上 19.99 美元的 AI Pro；Ultra 两档只适合重度用户；开发者注意 Argon 与 Carbon 在 12 月 1 日涨价，预算按涨价后的价格算。"
showtoc: true
---

**一句话结论：Gemini 现在是四模型分工。Hydrogen 快而便宜，免费用户也能用，还进了所有人的 Google 搜索；Neon 快而强，专啃复杂的多步骤任务（11 月 18 日新发布）；Argon 是付费用户的日常主力；Carbon 专啃最难的长推理。订阅分五档，免费、4.99 美元的 AI Plus、19.99 美元的 AI Pro、99.99 与 199.99 美元两档 AI Ultra，个人用户先试免费，不够再上 Pro。开发者注意一条时间线：Argon 与 Carbon 的 API 价 12 月 1 日翻倍，预算按涨价后的价格算。** 这一页是 Gemini 的档案页：版本、价格、功能与国内用法集中放在这里，官方改动后会再更新。

![Gemini 完全指南封面图：深蓝紫渐变夜空下由发光节点连成的分支网络，光球象征各档模型](/images/gemini-guide/cover.webp)

> 写作说明：本文依据 Google 官方 API 定价页与 Google 官方博客整理，查阅时间 2026-11-17，Neon 部分 2026-11-19；订阅档位价格为美国官网标价，各地区价格与权益以 Google 结算页为准。没有经过账号实测，用量数字以官方页面与结账页为准；国内可用性见文末专门一节。

## 一表看懂

| 项目 | 内容 |
| --- | --- |
| 公司 | Google（Google DeepMind 研发） |
| 产品 | Gemini（网页、App、Google 搜索、Gmail 与 Docs 内嵌、API） |
| 当前四模型 | Hydrogen（快速执行，全员可用）、Neon（快而强，复杂任务）、Argon（付费主力）、Carbon（最强推理） |
| 免费方案 | 有，Hydrogen 与部分旧模型可用，有用量上限 |
| 个人付费 | AI Plus 4.99 美元/月；AI Pro 19.99 美元/月；AI Ultra 99.99 或 199.99 美元/月（美国标价） |
| 开发者 API | Neon 输入 3 美元、输出 15 美元；Argon、Carbon 输入 2 美元/百万 token、输出 10 美元（11 月 30 日前，12 月 1 日起翻倍）；Hydrogen 输入 1.5 美元、输出 7.5 美元 |
| 特殊产品 | Decisions API：只判题不生成文字，输入 0.1 美元/百万 token、输出 0 token |
| 是否开放权重 | 否，闭源模型 |
| 官方入口 | [gemini.google.com](https://gemini.google.com)；API 定价见 [Google AI 官方定价页](https://ai.google.dev/gemini-api/docs/pricing) |

## 1. 核心底层逻辑与原理解析

**先分清三样东西：Gemini 应用、Google AI 订阅、Gemini API。** 很多人把三者混为一谈，这是选错档位的第一原因。Gemini 应用是聊天框，免费就能进；Google AI 订阅（Plus、Pro、Ultra）是按月付费的会员，决定你能在聊天框里用哪个模型、用多少次、附带多少存储与创作额度；Gemini API 是给开发者按 token 计费的接口，和订阅分开算钱。订阅不送 API 额度，API 也不送订阅权益，两本账。

**四模型分工是理解 Gemini 4 的钥匙。** 2026 年 11 月的 Gemini 4 家族不是一代比一代强，而是四个档位各管一摊：Hydrogen 管速度与日常执行，Neon 管复杂任务的快速完成，Argon 管多数工程与知识工作，Carbon 管最难的长推理。Google 官方博客的原话是，Carbon 与 Argon 擅长“深度、长周期的推理”，Hydrogen 为“跨多样化智能体工作流的快速执行”而生。选模型之前先问自己是哪类任务，而不是哪个分数高。

**Hydrogen 的特殊之处在于它进了搜索。** 2026 年 11 月 12 日，Google 宣布 Hydrogen 进入全球所有用户的 Google 搜索，官方称这是“迄今为止对搜索的最大一次模型升级”。也就是说，你不用开 Gemini 应用、不用付费，日常搜东西时已经在用 Hydrogen 回答 AI Mode 与 AI 概览。这也是 Hydrogen 免费的原因之一：它是 Google 搜索的基础设施，不只是聊天框里的一个选项。

**思考级别是 Hydrogen 的第二个关键概念。** Hydrogen 有可调的思考级别，默认 high 档，最高 xhigh 档。Google 官方公布的数字是：默认 high 档在 Artificial Analysis 智能指数上得 51 分，超过 Argon 的 50 分；xhigh 档达到 54 分；完成任务比 Gemini 3.8 Flash 快 2.5 倍；Terminal-Bench 4.1 得 57%，而 3.8 Flash 只有 18.2%。这些全是 Google 官方说法，目前没有独立复现的评测，本文只转述、不背书。分数的实际意义是：一个便宜的快速模型，在官方基准上已经追上甚至超过了自家上一代旗舰，这正是 Google 敢把它推给所有人的底气。

**Carbon 的定位是旗舰，但门槛也最高。** Google 在 10 月 28 日介绍 Carbon 时称它在 Artificial Analysis 智能指数上以 59 分排名第一。11 月 10 日起，Carbon 在 AI Mode 里向 Google AI Ultra 订阅用户推出，搜索框里出现 Auto、3.8 Flash、4 Carbon 三个选项。API 侧 Carbon 和 Argon 同价，但 Carbon 不在免费层，思考 token 也全额计费。换句话说，Carbon 是给“愿意为最难的问题付最高价”的人准备的，日常任务用它就是浪费。

**Argon 是夹在中间的默认主力。** 2026 年 9 月 30 日发布、10 月 13 日向付费用户开放，官方定位是“高效的 Gemini 4 前沿推理模型”，在复杂编程、智能体、数学与科学任务上，用更少的 token 达到接近 Carbon 的水平。AI Pro 用户在应用里默认用的就是 Argon，API 侧它和 Carbon 同价。对大多数人来说，Argon 是“不用想”的选择：比 Hydrogen 聪明，比 Carbon 便宜。

**Neon 是 11 月 18 日新加入的第四个模型，卡在 Carbon 与 Hydrogen 之间。** 官方定位是复杂软件工程、知识工作与科学流程的端到端快速完成：由 Carbon 适配而来，知识截止 2026 年 3 月，上下文 100 万 tokens，思考四档可调。API 价输入 3 美元、输出 15 美元/百万 token，缓存输入 0.15 美元。在官方引用的第三方评测里，它在 Artificial Analysis 综合指数上得 61 分排第三，编码 Agent 指数排第一。注意一条时间线：11 月 30 日前 Carbon 与 Argon 还在促销价，Neon 单价反而更贵；12 月 1 日涨价后，Neon 反过来比 Carbon 便宜 25%。它只向付费层开放：Gemini API 付费层、Gemini App 的 Pro 与 Ultra 订阅者，免费层没有。细节见本站 [Gemini 4 Neon 发布：快而强的中间档](/posts/gemini-4-neon-launch/)。

**免费层的边界要看清。** 免费用户能用 Hydrogen（通过自动模型选择）和部分旧模型，但 Argon 与 Carbon 不在免费层。免费层的另一个条款值得注意：根据 Google 官方定价页，免费层的内容可能被用于改进产品，付费层则不会。介意隐私的人不要在免费层处理敏感内容。

## 2. 核心方案与多维对比横评

### 2.1 版本时间线

| 日期 | 版本 | 要点 |
| --- | --- | --- |
| 2026-09 | Gemini 3.8 Flash | AI Mode 的默认模型，轻量快速 |
| 2026-09-30 | Gemini 4 Argon 发布 | 高效前沿推理模型，定位日常主力 |
| 2026-10-13 | Argon 上线付费用户 | 进入 Gemini 应用与 AI Mode，API 同步开放 |
| 2026-10-28 | Gemini 4 Carbon 介绍 | Google 称其智能指数 59 分排名第一 |
| 2026-11-10 | Carbon 上线 AI Mode | 先向 AI Ultra 用户推出 |
| 2026-11-11 | Decisions API 发布 | 判题模型 `gemini-decision-1`，一次问 1000 道题 |
| 2026-11-12 | Gemini 4 Hydrogen 发布 | 快速执行模型，全员可用，并进入全球搜索 |
| 2026-11-18 | Gemini 4 Neon 发布 | 家族第四个模型，定位 Carbon 与 Hydrogen 之间，API 价 3/15 美元 |
| 2026-12-01 | API 涨价生效 | Argon、Carbon 输入 4 美元、输出 20 美元/百万 token；Neon 不涨价，仍为 3/15 美元 |

### 2.2 订阅五档对比

价格为美国官网标价，2026 年 11 月 10 日核对；各地区价格、学生优惠与试用政策以 Google 结算页为准。

| 档位 | 月费（美元） | Gemini 应用模型 | 用量 | 存储 | 创作额度与附加权益 |
| --- | :--- | :--- | :--- | :--- | :--- |
| 免费 | 0 | Hydrogen（自动选择）、部分旧模型 | 基础 | 15 GB（Google 账号默认） | 基础功能 |
| AI Plus | 4.99 | Hydrogen | 约免费 2 倍 | 400 GB（另有 2 TB 地区价） | 200 Flow 积分/月、Gmail 内 Gemini、Deep Research |
| AI Pro | 19.99 | Neon、Argon、Hydrogen | 约免费 4 倍 | 5 TB | 1000 Flow 积分/月、Gmail 与 Docs 内 Gemini、YouTube Premium Lite、Antigravity、Jules、Chrome 自动浏览 |
| AI Ultra 5x | 99.99 | Neon、Argon、Carbon、Hydrogen、Deep Think | Pro 的 5 倍 | 20 TB | 10000 Flow 积分/月、YouTube Premium、Project Genie |
| AI Ultra 20x | 199.99 | 同上 | Pro 的 20 倍 | 30 TB | 25000 Flow 积分/月，其余同上 |

用量数字是“倍数”不是“次数”：Google 不公布固定提问次数，只说额度按提示复杂度、功能与对话长度消耗，每 5 小时刷新一次，直到触及每周上限。别按“一天能问几十次”去算账，官方没有这个口径。

### 2.3 API 价格对比

以下为 Google 官方 API 定价页的价格，2026-11-17 核对。

| 模型 | 输入（每百万 token） | 输出（每百万 token） | 免费层 |
| --- | :--- | :--- | :--- |
| Gemini 4 Carbon | 2 美元（11 月 30 日前），12 月 1 日起 4 美元 | 10 美元（11 月 30 日前），12 月 1 日起 20 美元 | 无 |
| Gemini 4 Argon | 同上 | 同上 | 无 |
| Gemini 4 Neon | 3 美元 | 15 美元 | 无 |
| Gemini 4 Hydrogen | 1.5 美元，全上下文统一价 | 7.5 美元，全上下文统一价 | 有 |
| Decisions API（`gemini-decision-1`） | 0.1 美元 | 0 美元（不生成文字） | 每天 1 万次请求 |

Batch API 在标准价基础上便宜 50%。Argon 与 Carbon 的上下文缓存只支持隐式缓存，缓存价 0.1 美元/百万 token，12 月 1 日起 0.2 美元；Neon 的缓存输入为 0.15 美元/百万 token（95% 折扣）。细节见 [Google AI 官方定价页](https://ai.google.dev/gemini-api/docs/pricing)。

### 2.4 Gemini、ChatGPT、Claude 怎么选

三家没有绝对的胜负，只有场景差异。ChatGPT 的完整版本与价格见本站 [ChatGPT 完全指南](/posts/chatgpt-guide/)，Claude 的版本与用法见本站 [Claude 入门完整指南](/posts/claude-guide/)。

| 维度 | Gemini | ChatGPT | Claude |
| --- | :--- | :--- | :--- |
| 最大优势 | 和 Google 生态一体：搜索、Gmail、Docs、YouTube、安卓 | 聊天体验与插件生态最成熟，用户基数最大 | 长文写作与代码的口碑最好 |
| 旗舰模型 | Gemini 4 Carbon | GPT-6（本站指南核对于 2026-11-10） | Opus 5.5（本站旗舰文已更新） |
| 免费版诚意 | 高：Hydrogen 全员可用，还进了搜索 | 有免费版，但模型档位较低 | 有免费版，用量较紧 |
| 个人主力档 | AI Pro 19.99 美元/月 | Plus 20 美元/月 | 见本站 Claude 指南 |
| 开发者起步 | API 有免费层，Hydrogen 1.5/7.5 美元 | 按量计费，另有免费额度 | 按量计费 |
| 适合谁 | 重度用 Google 服务、常查资料、要做搜索与文档 | 要一个全能聊天助手、看重插件与社区 | 写长文、做开发、要稳定输出 |

一句话选型：已经在用 Gmail、Google Docs、安卓手机的人，Gemini 的 Pro 最顺手；只想找一个聊天框什么都能问，ChatGPT 更稳；写代码与长文为主，Claude 优先。

### 2.5 Decisions API：不聊天的 Gemini

11 月 11 日发布的 Decisions API 值得单独提一句，因为它不是聊天产品。判题模型 `gemini-decision-1` 不生成文字，只给概率和置信度：一次请求最多问 1000 道题，输入 0.1 美元/百万 token、输出永远 0 token。本站已用真实 Key 实测过 6 道题，结论是货真价实，细节见 [Gemini Decisions API 实测](/posts/gemini-decisions-api-hands-on/)。它的主场是 Agent 的“开关”与“分流”——分类、审核、路由、打分，而不是聊天。如果你只是在聊天框里问问题，这条可以跳过。

## 3. 手把手完整实战流程

### 步骤一：先用免费版摸清需求

打开 [gemini.google.com](https://gemini.google.com)，用 Google 账号登录，直接开始问。免费版默认自动选择模型，日常问题会走 Hydrogen。先用一周，记录三件事：每天大概问多少次、有没有遇到“额度用完请稍后再试”、有没有哪类问题答得明显不对。免费版够用就不用花钱，这是最省钱的结论。

### 步骤二：按任务挑模型，不按名气挑

在应用的模型选择器里（付费用户可见），按这个顺序试：

1. **日常问答、查资料、写草稿、翻译：** 用默认的自动选择或 Hydrogen，又快又便宜。
2. **写代码、改代码、做复杂推理、长文档分析：** 切到 Argon（Pro 及以上）。
3. **复杂的多步骤任务、长流程 Agent、多文件重构：** 试 Neon（Pro 及以上），编码 Agent 指数第一；但 11 月 30 日前它比促销价的 Carbon 贵，12 月 1 日后才反超。
4. **最难的数学与科学问题、超长程推理：** 再考虑 Carbon（Ultra 才有），先用 Argon 跑一次，对比结果值不值。

一个实用的判断标准：如果 Argon 的答案已经够用，Carbon 多花的钱就白花了；如果 Argon 连续两次答错同一类题，再升级。

### 步骤三：决定要不要付费

对照这张决策表：

- **免费版够用：** 每天问得不多、只做日常问答和搜索、不在意偶尔的额度上限。
- **上 AI Plus（4.99 美元）：** 想要 Deep Research、Gmail 内校对、更多生成次数，但不需要最强模型。
- **上 AI Pro（19.99 美元）：** 需要 Argon、经常在 Docs 里改稿、用 Flow 做视频、想要 5 TB 存储。大多数个人用户到这一档就够了。
- **上 AI Ultra（99.99/199.99 美元）：** 每天高强度用、要 Deep Think 和 Carbon、要 Project Genie、Flow 额度 1000 根本不够用。不是重度用户不要碰。

订阅前先看结算页：Google 常有首月优惠与学生优惠，各地区价格不同，结账页显示的才是你真正要付的钱。

### 步骤四：开发者走 API，先领免费额度

开发者不建议直接开订阅去调接口，订阅不送 API 额度。正确路线是去 Google AI Studio 领 API Key，免费层先跑通：Hydrogen 有免费层，Neon、Argon 与 Carbon 没有。调通后再按量付费，Batch 任务记得走 Batch API，省一半。定价细节以 [Google AI 官方定价页](https://ai.google.dev/gemini-api/docs/pricing) 为准，本文的价格表是 2026-11-19 的快照，12 月 1 日 Argon 与 Carbon 涨价后会更新。

### 步骤五：把 Gemini 接进日常工作流

几个不用折腾的接入点，都是 Pro 及以上权益：Gmail 与 Docs 里直接叫 Gemini 帮你写邮件、改稿子；聊天里生成文件后直接在对话里改，不用下载再上传，细节见本站 [Gemini 在聊天里生成和编辑文件](/posts/gemini-edit-files-in-chat/)；NotebookLM 做资料研读；Flow 做短视频。先把一个场景跑顺，再扩到下一个，不要一次全开。

## 4. 工业级避坑守则

### ⚠️ 避坑点 1：12 月 1 日涨价，预算别按 11 月的价格算

Argon 与 Carbon 的 API 价 11 月 30 日前是输入 2 美元、输出 10 美元/百万 token，12 月 1 日起变成 4 美元与 20 美元，直接翻倍。如果你 11 月底在做成本测算，务必按 12 月的价格算，否则上线第一周账单就会翻倍。Hydrogen 不涨价，1.5/7.5 美元是长期价。Neon 也不参与这次涨价，但时间线要分两段看：11 月 30 日前它比促销价的 Carbon 贵一半（3/15 美元对 2/10 美元），12 月 1 日后反过来比 Carbon 便宜 25%，做预算时别用一段的价格算另一段。

### ⚠️ 避坑点 2：思考 token 也计费，别只算看得见的输出

Argon 与 Carbon 的输出价包含思考 token，官方定价页明确写着“每个被处理的 token 都计费，包括思考 token”。一道难题的思考过程可能比最终答案长得多，账单上看不见但照样收钱。做成本估算时，按输出 token 的 2–3 倍留余量。

### ⚠️ 避坑点 3：订阅用量是倍数，不是次数

Google 不公布“每天能问多少次”，只给相对免费版的倍数，且额度按提示复杂度、功能与对话长度消耗，每 5 小时刷新一次。不要轻信网上“Pro 每天 100 次”的说法，官方没有这个口径。真正的高频用户看 Ultra 的 5x 与 20x 档，而不是数次数。

### ⚠️ 避坑点 4：免费层内容可能被用于改进产品

官方定价页写明，免费层的内容可能被用于改进产品，付费层不会。不要在免费层粘贴公司内部资料、未公开的商业信息或个人敏感内容。介意这一点就开付费档，或者走付费 API。

### ⚠️ 避坑点 5：别把官方基准分数当成你的任务分数

Hydrogen 的 51 分、Carbon 的 59 分，都是 Google 在 Artificial Analysis 智能指数等基准上的自报成绩，没有独立复现。搜索质量方面，Google 只说 Hydrogen 是“迄今为止对搜索的最大一次模型升级”，没有公布任何搜索准确率的前后对比数字。选模型看自己的任务实测，别看分数下单。

### ⚠️ 避坑点 6：国内开通先看总纲，别只看价格就下单

Gemini 的官网与 App 在中国大陆无法直接访问，订阅的地区与支付方式以 Google 结算页为准。本文不提供绕过方法，也不承诺任何国内直连方式。国内用户开通前的完整注意事项见本站 [ChatGPT、Claude、Gemini 国内开通总纲](/posts/chatgpt-claude-gemini-china-access-guide/)，先看总纲再决定，避免付了钱用不上。

## 5. 总结与后续行动建议

Gemini 在 2026 年 11 月从三模型扩到四模型：Hydrogen 管快、Neon 管复杂任务的快速完成、Argon 管日常主力、Carbon 管最难的题。普通用户的行动路径很清晰：先用免费版一周，确认需求；不够用就上 19.99 美元的 AI Pro，拿到 Neon、Argon 与全套 Google 生态权益；只有每天高强度使用、确实需要 Carbon 与 Deep Think 时，再考虑 Ultra。开发者的路径也清晰：先领 API 免费额度跑通 Hydrogen，Argon 与 Carbon 按 12 月涨价后的价格做预算，复杂任务可以试 Neon（11 月 30 日前按 3/15 美元算，12 月 1 日后它比 Carbon 便宜 25%），判题类任务单独评估 Decisions API。

本文是 Gemini 的档案页，官方改动后会更新。相关阅读：[Gemini 4 Neon 发布：快而强的中间档](/posts/gemini-4-neon-launch/)、[ChatGPT 完全指南](/posts/chatgpt-guide/)、[Claude 入门完整指南](/posts/claude-guide/)、[Gemini Decisions API 实测](/posts/gemini-decisions-api-hands-on/)、[Gemini 在聊天里生成和编辑文件](/posts/gemini-edit-files-in-chat/)、[ChatGPT、Claude、Gemini 国内开通总纲](/posts/chatgpt-claude-gemini-china-access-guide/)，更多工具评测见 [AI工具实测](/categories/ai工具实测/) 中心页。

## 常见问题

**免费版 Gemini 够用吗？**

日常问答、查资料、写草稿、翻译够用，因为免费版已经能用 Hydrogen。但免费版没有 Argon、Neon 与 Carbon，遇到复杂代码与长推理会吃力，且内容可能被用于改进产品。先免费试一周再决定。

**AI Pro 和 Ultra 差在哪里？**

核心差三样：模型（Ultra 多 Carbon 与 Deep Think）、用量倍数（5x 或 20x）、附加权益（Project Genie、YouTube Premium、更多 Flow 积分与存储）。大多数个人用户到 Pro 就够了。

**Gemini 4 Carbon 和 Argon 选哪个？**

日常主力选 Argon；只有多步骤智能体任务、最难的数学与科学问题才上 Carbon。Carbon 只在 Ultra 与 API 侧提供，价格 12 月 1 日起翻倍，日常任务用它不划算。

**Gemini 4 Neon 是什么？**

11 月 18 日发布的第四个模型，定位在 Carbon 与 Hydrogen 之间：复杂软件工程与长流程 Agent 任务的快速完成。API 价输入 3 美元、输出 15 美元，只向付费层开放（Gemini API 付费层、Gemini App 的 Pro 与 Ultra 订阅者），免费层没有。11 月 30 日前它比促销价的 Carbon 贵，12 月 1 日后反过来便宜 25%。详情见本站 [Gemini 4 Neon 发布：快而强的中间档](/posts/gemini-4-neon-launch/)。

**API 和订阅是一回事吗？**

不是。订阅按月付费管聊天框，API 按 token 计费管开发调用，订阅不送 API 额度。开发者去 Google AI Studio 领 Key，先走免费层。

**国内能直接用 Gemini 吗？**

Gemini 官网与 App 在中国大陆无法直接访问，订阅地区与支付方式以 Google 结算页为准。本文不提供绕过方法，开通前先看本站国内开通总纲。

## 核验

- 价格与模型信息来源：[Google AI 官方定价页](https://ai.google.dev/gemini-api/docs/pricing)、[Google 官方博客：Gemini 4 Hydrogen 介绍](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-hydrogen/?ref=aiposthub.com)、[Google 官方博客：Gemini 4 Neon 介绍](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-neon/)；订阅档位价格为美国官网标价，另据第三方价格追踪页 2026 年 11 月 10 日核对：[Gemini 定价追踪](https://magai.co/gemini-pricing/)。
- 性能分数（AA 指数、Terminal-Bench）均为 Google 官方说法，暂无独立复现评测。
- 查阅时间：2026-11-19（Neon 部分）。价格 12 月 1 日有变动，届时更新本文。

## 更新记录

- 2026-11-19：更新。Gemini 4 家族扩为四模型，新增 Neon（11 月 18 日发布）的定位、价格与选型说明，同步更新订阅与 API 价格表。
- 2026-11-17：首发。按 2026 年 11 月官方信息整理 Gemini 4 三模型、订阅五档与 API 价格。
