---
title: "Gemini 4 Neon 发布：快而强的中间档"
date: 2026-11-19T09:35:00+08:00
lastmod: 2026-11-19T09:35:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["快讯", "AI编程", "Gemini", "Google"]
description: "Google 11 月 18 日发布 Gemini 4 Neon：Gemini 4 家族第四个模型，输入每百万 tokens 3 美元、100 万上下文，独立评测综合指数 61 分排第三。本文讲清价格、跑分与四模型怎么选。"
summary: "Google 11 月 18 日发布 Gemini 4 Neon，定位在 Carbon 与 Hydrogen 之间：旗舰级推理、更快的任务完成速度，输入每百万 tokens 3 美元。11 月 30 日前它比促销价的 Carbon 还贵，12 月 1 日后反过来便宜 25%，选型先看这条时间线。"
showtoc: true
---

先给结论：**Google 在 11 月 18 日发布了 Gemini 4 Neon，这是 Gemini 4 家族的第四个模型，定位在最强的 Carbon 与最快的 Hydrogen 之间。**它主打复杂软件工程、知识工作与科学流程的端到端快速完成，价格是输入每百万 tokens 3 美元、输出 15 美元，上下文 100 万 tokens。官方引用的第三方评测里，它在 Artificial Analysis 综合指数上拿到 61 分、总榜第三，编码 Agent 指数排第一。但有一个时间陷阱：11 月 30 日之前，Carbon 与 Argon 还在促销价，每 token 比 Neon 便宜一半；12 月 1 日涨价后，Neon 才反过来便宜 25%。所以现在选模型，先看日历再看价格。

![插画：深蓝色数字空间中一颗发光的青色光球悬浮在电路纹理上方，旁边一颗暖黄色小光球与一颗淡蓝色小光球由发光细线相连，象征 Gemini 4 家族的三个模型](/images/gemini-4-neon-launch/cover.webp)

> 写作说明：本文依据 Google 官方博客公告与 DeepMind 官方模型卡整理，查阅时间 2026-11-19。跑分均为官方引用的第三方评测结果，非本站实测；价格为美国官网标价，各地区价格与权益以 Google 结算页为准。

## 发布了什么：家族第四个模型

| 项目 | 内容 |
| --- | --- |
| 发布方 | Google（Google DeepMind） |
| 发布时间 | 2026 年 11 月 18 日 |
| 模型定位 | 复杂软件工程、知识工作、科学流程，端到端快速完成任务 |
| 价格 | 输入每百万 tokens 3 美元，缓存输入 0.15 美元（95% 折扣），输出 15 美元 |
| 上下文 | 100 万 tokens 统一窗口；默认同步输出最高 6.4 万 tokens，后台长解码最高 100 万 tokens |
| 思考等级 | 四档可调，默认 high，最高 xhigh |
| 技术来源 | 由 Gemini 4 Carbon 适配而来，知识截止 2026 年 3 月 |
| 开放范围 | Gemini API（Google AI Studio 付费层）、Gemini for business、Antigravity（付费 Pro／Ultra）、Gemini App（Pro／Ultra 订阅者） |

Neon 这个名字延续了 Gemini 4 家族的元素命名：Argon、Carbon、Hydrogen 之后，Neon 是第四个成员。官方对它的定位写得很直白：Carbon 负责最难的长程项目，Hydrogen 负责日常快速执行，Neon 在两者之间取平衡——给高频、复杂的工作提供前沿级推理，同时更快、更便宜。

这个定位不是一句空话，它对应一个具体的使用场景。官方博客花了相当篇幅讲 Neon 在 Google Antigravity 里的角色：它可以作为 Orchestrator（编排者），指挥多个并行的 Hydrogen 子代理干活，自己做高判断的协调工作；也可以单独跑长流程的 Agent 任务。换句话说，Neon 是为"一个任务要跑很久、中间要调很多工具"这种工作设计的，而不是为问一句答一句的聊天设计的。

对普通用户来说，更贴近的另一面在 Gemini App 里：Neon 能读电子表格、PDF、图表、音频和视频，在同一个 100 万 tokens 窗口里综合处理，输出结构化结果。官方举的例子包括：分析账单弄清一笔水电费为什么突然变高、交叉核对多张收据去协商退款、比价再做一份带最新数据的简报。这些都是"材料多、步骤多"的活，正好是 Neon 的目标场景。

还有一个独立分支值得单独提：Gemini 4 Neon for cyber（网络安全版）。它在生成安全代码、找漏洞、验证漏洞可利用性、打补丁这条防线全流程上都给了数字：AutoBaxBench 困难档 76%（官方称同类最佳）、WebExploitBench v1.2 渗透测试 51.26%、SEC-bench Pro 找漏洞 90.5%、CWE-bench v2 打补丁 70.7%（比 Carbon 高 3.4 个百分点）。这个版本不向所有人开放，未来几天内先给 Fairwind Program 里受信任的防御者。普通用户用不上，但它说明 Google 把 Neon 当作一个可以进生产环境的模型来推，而不只是一个跑分模型。

## 价格怎么算：11 月 30 日是分水岭

Neon 的定价本身不复杂，复杂的是它和自家兄弟的相对关系。先把四模型的 API 价格摆在一起：

| 模型 | 输入（每百万 tokens） | 输出（每百万 tokens） | 备注 |
| --- | --- | --- | --- |
| Gemini 4 Hydrogen | 1.5 美元 | 7.5 美元 | 日常快速执行，免费层可用 |
| Gemini 4 Neon | 3 美元 | 15 美元 | 本次新发布 |
| Gemini 4 Argon | 2 美元（促销价，11 月 30 日截止） | 10 美元（促销价） | 12 月 1 日起涨至 4／20 美元 |
| Gemini 4 Carbon | 2 美元（促销价，11 月 30 日截止） | 10 美元（促销价） | 12 月 1 日起涨至 4／20 美元 |

这张表里藏着一个容易算错账的点：**在 11 月 30 日之前，Neon 每 token 的价格比旗舰 Carbon 贵 50%。** 因为 Carbon 和 Argon 现在是促销价 2／10 美元，而 Neon 一上来就是标准价 3／15 美元。只看单价，Neon 现在是家族里第二贵的模型，仅次于涨价后的 Carbon。

但官方的说法换了一个算法：算"每个任务的总成本"，而不是"每个 token 的单价"。在默认的 high 思考等级下，Neon 每个任务的成本比 Carbon 低 32%。逻辑是 Neon 推理更省、调用工具时少读重复文件、长会话里上下文压缩更可靠，所以完成同一个任务花的 token 更少。这个说法有没有水分，要等第三方实测才知道；但它至少提醒一件事：**只比单价会得出错误的结论，Neon 卖的是"单位任务的成本"，不是"单位 token 的便宜"。**

12 月 1 日之后，账要重算一遍。Carbon 与 Argon 的促销结束，涨到 4／20 美元，Neon 的 3／15 美元就反过来比 Carbon 便宜 25%。所以结论分两段：11 月 30 日前，Neon 是"贵但可能更省"的选项；12 月 1 日后，它是家族里性价比最高的强推理模型。开发者如果现在就要上生产环境，先按 11 月的价格做预算，再把 12 月的涨价写进计划里，别用促销价去算长期成本。

缓存输入 0.15 美元（95% 折扣）也值得注意。对长上下文的 Agent 任务来说，输入里大量是重复的上下文——系统提示、代码库、历史对话——缓存命中率高的话，输入成本能压得很低。这是 Neon 成本模型里最实在的一块：单价 3 美元看着不便宜，但缓存后的实际输入成本可能只有零头。当然，缓存命中率取决于具体用法，官方没有给出通用数字，这里不要自己编一个。

## 跑分怎么读：61 分的含金量

官方公告引用了一串第三方评测，先把核心数字列出来：

| 评测 | Neon 成绩 | 官方说法 |
| --- | --- | --- |
| Artificial Analysis 综合指数 v5.0.1 | 61 分（xhigh 档） | 总榜第 3，仅次于更大、更慢的模型 |
| Artificial Analysis 编码 Agent 指数 | 58.6 分 | 第 1 |
| Vals Index v2.2 | 70.9% | 第 2，落在帕累托前沿 |
| Terminal-Bench 4.1 | 65.2% | 编程 Agent 基准 |
| FrontierCode 2.0 | 46.2%（默认 high 档） | 前沿编程基准 |
| Agent Arena Index | 1336 分 | 全球第 2，基于 4200 多次真实 Agent 会话 |
| AutomationBench（Zapier） | 56.3% | 第 1 |
| Vending-Bench 2（Andon Labs） | 16843 美元 | 第 1，长程经营模拟 |
| Terminal-Bench Science | 70.5% | 同类最佳 |
| RiemannBench | 84.0% | 同类最佳 |
| HLE-Diamond | 71.3% | 同类最佳 |
| Chartography | 73.5% | 读密集专业图表 |

怎么读这张表，先说三个提醒。

**第一，61 分是在 xhigh 档测的，不是默认档。** Neon 的思考等级默认是 high，最高是 xhigh。官方说 61 分是 xhigh 档的成绩，而成本"比 Carbon 低 32%"的说法是在默认 high 档下算的。这两个数字不能拼在一起用：要最高分就开 xhigh，代价是更多 token；要省钱就用默认 high，分数会比 61 低。官方没有公布 high 档的综合指数分数，所以"又强又省"这个组合在现有公开数字里是拼不出来的，选型时按自己的优先级取舍。

**第二，横向对比要看对手是谁。** 同一个 Artificial Analysis 综合指数上，Claude Fable 5.2 是 65 分第一，GPT-6.2 Astra 是 62 分第二，Neon 的 61 分排第三。差距只有 1 到 4 分，在不同评测集上排名随时可能互换。但 Neon 有一张王牌：编码 Agent 指数 58.6 分排第一，Terminal-Bench 4.1 也有 65.2%。这说明 Neon 的长处不在"什么都强"，而在"写代码、跑 Agent 任务"这个具体方向上强。选模型时，别只看总榜第三这个名次，要看自己的任务是不是落在它的长处里。

**第三，这些都是厂商引用的数字，不是独立复核。** 官方博客明确写了数据来源是 Artificial Analysis、Vals、Agent Arena 等第三方，但表格和测试条件是 Google 自己挑的、自己公布的。第三方评测机构的数据本身是独立的，但"挑哪些放进公告"这个选择是厂商做的。最值得留意的细节是 SWE-sweep 的数字：在 mini-SWE 测试里 Neon 只有 12.8%，在 Google 自家的 Antigravity 环境里飙到 39.0%。同一个模型，换个测试环境成绩差三倍，这说明"用什么工具链跑模型"对结果的影响可能比"用哪个模型"还大。读跑分时，环境和方法论比分数本身重要。

还有一组数字容易被忽略，但对生产环境很关键：安全与对齐指标。Neon 在 Terminal-Bench 4.0 上的作弊率是 0.0%，走捷径的比例是 2.45%（官方称 Gemini 4 家族最低）；在 Gray Swan 的间接提示注入基准上，最高思考档的攻击成功率是 0.0%。这些数字的意思是：让模型长时间自主干活时，它更少"抄近路交差"、更少被网页或文档里藏的恶意指令带偏。对跑 Agent 的用户来说，这比多一两分跑分更实在——一个会在长任务里偷工减料的模型，分数再高也不敢放进生产流程。

## 四模型横向对比：该选哪一个

把 Gemini 4 家族四个模型放在一起，选型其实是一道"任务难度 × 频率 × 预算"的选择题：

| 维度 | Hydrogen | Neon（新） | Argon | Carbon |
| --- | --- | --- | --- | --- |
| 定位 | 日常快速执行 | 复杂任务的快速完成 | 付费日常主力 | 最难的长程推理 |
| 输入价格 | 1.5 美元 | 3 美元 | 2→4 美元（12 月 1 日起） | 2→4 美元（12 月 1 日起） |
| 输出价格 | 7.5 美元 | 15 美元 | 10→20 美元（12 月 1 日起） | 10→20 美元（12 月 1 日起） |
| 上下文 | 100 万 tokens | 100 万 tokens | 100 万 tokens | 100 万 tokens |
| 综合指数 | 未公布同口径分数 | 61 分（xhigh） | 未公布同口径分数 | 60 分左右（官方对比口径） |
| 免费层 | 有 | 官方公告未提免费层 | 无 | 无 |
| 适合谁 | 所有人、日常任务 | 开发者、高频复杂任务 | 付费用户日常主力 | 最难的推理与研究 |

从这张表可以得出几条直接可用的选型建议。更多新模型与工具的实测对比，见 [AI工具实测](/categories/ai工具实测/)中心页。

**只用 Gemini App 聊天、查资料、写东西的普通用户：先不用换。** Neon 只向 Pro 与 Ultra 订阅者开放，免费版用户在 App 里用的是 Hydrogen。Hydrogen 已经够快够便宜，日常问答、写稿、查资料不需要 Neon 的长程 Agent 能力。等 Neon 下放到更低的订阅档再考虑，官方公告里没有提到这个时间表。

**付费 Pro／Ultra 用户：可以在 App 的模型下拉菜单里试 Neon。** 适合的任务是"材料多、步骤多"的活：一次丢进几十页 PDF 做尽调、拿着一堆收据和账单算账、让模型对照多个来源写一份带最新数据的简报。单次问答、翻译、改写这类短任务，用 Hydrogen 更划算。

**开发者调 API：Neon 的对手不是 Hydrogen，而是 Carbon 与 GPT-6.2 Sol。** 如果任务是长流程 Agent、多文件重构、跑测试修 Bug，Neon 的编码 Agent 指数第一和 Terminal-Bench 65.2% 是实打实的卖点；如果任务是日常代码补全、简单脚本，Hydrogen 便宜一半，没必要上 Neon。12 月 1 日之后，Neon 会成为家族里"强推理模型中每 token 最便宜的"，长期跑 Agent 的预算可以按这个时间点规划。

**和 GPT-6.2 与 Claude Fable 5.2 比：Neon 的位置是"第三名但有自己的长板"。** 综合指数 61 分落后于 Fable 5.2 的 65 分和 GPT-6.2 Astra 的 62 分，但编码 Agent 指数第一、成本又低于两者。团队已经在用 Claude Code 或 Codex 的，没有必要因为一篇公告就迁移；正在 Google 生态里（Antigravity、AI Studio、Vertex AI）做事的，Neon 是顺理成章的升级。关于 GPT-6.2 的详细价格与跑分，见本站 [GPT-6.2 发布：Astra 更强，Sol 更省](/posts/gpt-6-2-astra-sol-launch/)；关于 Claude Fable 5.2，见本站 [Claude Fable 5.2 发布解读](/posts/claude-fable-mythos-5-2-launch/)。

另外提醒一点：本站的 [Gemini 完全指南](/posts/gemini-guide/)目前写的是"三模型分工"，Neon 发布后家族已经是四个模型，指南里的版本与价格表需要同步更新，本文发布后会跟进。

## 谁该用、谁先别急

把上面的分析收成一张行动清单：

**现在就可以试的人：** 已有 Google AI Pro 或 Ultra 订阅，在 Gemini App 里直接选 Neon；用 Gemini API 付费层开发的开发者，把模型 ID 换成 `gemini-4-neon` 就能调用；Antigravity 的付费用户，可以让 Neon 当 Orchestrator 去指挥 Hydrogen 子代理跑长任务。入口都在官方公告里列明了：Gemini API（Google AI Studio）、Gemini for business、Antigravity、Gemini App。

**先观望的人：** 免费版用户——官方公告没有提到 Neon 的免费层，不要默认它会免费开放；只做短对话、翻译、改写的用户——Hydrogen 更便宜，Neon 的优势发挥不出来；对价格敏感、又在 11 月内就要上线的项目——先按 Carbon 促销价算账，等 12 月 1 日涨价后再切 Neon 更划算。

**国内用户注意：** Gemini 服务在中国大陆的可用性、订阅价格与支付方式，本文没有证实，以 Google 官方结算页与服务条款为准。不要默认"国内能用"或"能免费试用"。需要开通路径的读者，可以参考本站 [Gemini 完全指南](/posts/gemini-guide/)里的国内开通提醒一节，以及 [Gemini 4 Hydrogen 发布](/posts/gemini-4-hydrogen-launch/)里关于免费层开放范围的说明。

## 避坑：这五件事别弄错

**1. 别拿促销价当长期价。** 11 月 30 日前 Carbon 与 Argon 是 2／10 美元，12 月 1 日起是 4／20 美元。任何写着"Carbon 比 Neon 便宜"的结论，保质期只到 11 月 30 日。做预算时按 12 月的价格算，11 月的差价就当是限时优惠。

**2. 别把 xhigh 的分数当成默认表现。** 61 分是最高思考档的成绩，默认 high 档的分数官方没有公布。开 xhigh 意味着更多 token、更高成本、更慢返回。如果你的任务不需要最高档，别为了分数去开它。

**3. 别只看总榜，要看你的任务在哪个指数上。** Neon 总榜第三，但编码 Agent 指数第一、Vals 第二、Agent Arena 第二。做 Agent 开发、写代码、跑自动化流程的人，Neon 的排名比总榜好看；做纯知识问答、创意写作的人，总榜第三就是它的真实位置。

**4. 知识截止是 2026 年 3 月。** 模型卡明确写了 Neon 的知识截止时间是 2026 年 3 月。问 2026 年下半年的新事、新政策、新产品，它可能不知道，或者用旧信息回答。官方博客提到 Neon 在 Gemini App 里会联网查资料补新鲜信息，但 API 调用时是否联网取决于你的配置，不要默认模型自己知道最新消息。

**5. 跑分里的"环境红利"别忽略。** SWE-sweep 的例子已经说明了：同一个模型，在 Antigravity 里 39.0%，在通用 mini-SWE 环境里 12.8%。如果你不在 Antigravity 里用 Neon，别拿 39.0% 这个数字去预期自己的效果。反过来也成立：在 Antigravity 里用 Neon，它的编排能力（少读重复文件、可靠地压缩上下文）才是真正值钱的部分，跑分表上看不出来。

## 参考来源

- [Google 官方博客：Introducing Gemini 4 Neon（2026-11-18）](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-neon/)
- [Google DeepMind：Gemini 4 Neon 模型卡（PDF，2026-11）](https://storage.googleapis.com/deepmind-media/Model-Cards/Gemini-4-Neon-Model-Card.pdf)
- [9to5Google：Gemini 4 Neon launches（2026-11-18）](https://9to5google.com/2026/11/18/gemini-4-neon-announcement/)

## 更新记录

- 2026-11-19：首发。依据 Google 官方博客与 DeepMind 模型卡整理；跑分与价格以官方页面为准。
