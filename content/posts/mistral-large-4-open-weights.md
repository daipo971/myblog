---
title: "Mistral Large 4 权重开源：万亿参数"
date: 2026-10-30T09:40:00+08:00
lastmod: 2026-10-30T09:40:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "开源模型", "AI编程", "Mistral"]
description: "法国 Mistral 昨天发布旗舰模型 Large 4 的开源权重：万亿参数、原生多模态，主攻编程与网络安全，号称开源模型编程最强。本文讲清它强在哪、许可证的限制、价格，以及普通用户和开发者能怎么用。"
showtoc: true
---

**一句话结论：** 法国 Mistral 在 2026 年 10 月 29 日发布旗舰模型 Mistral Large 4（昵称 Le Chonk）的开源权重。10 月 6 日它先以 API 预览版上线，经过三周强化学习和开发者反馈，改进版权重正式放出，权重已上架 Hugging Face，可下载自托管。官方定位很明确：开源模型里编程最强，同时主攻网络安全防御。

![Mistral Large 4 开源权重封面图](/images/mistral-large-4-open-weights/cover.webp)

## 这次发布了什么

先分清两个时间点，免得和本月初的新闻混淆：

- **10 月 6 日**：Mistral Large 4 以 API 预览版上线，只能通过官方接口调用，权重不公开。
- **10 月 29 日**：改进版权重正式发布，这才是真正的「开源」一步：开发者可以下载权重，用 vLLM 或 SGLang 在自己的基础设施上部署、微调，不再依赖 Mistral 的 API。

模型本身的规格，依据官方公告和模型卡整理如下：

- **规模**：混合专家（MoE）架构，总参数约 1.05 万亿，每 token 实际激活约 490 亿（算上词嵌入和输出层为 520 亿），128 个路由专家、每 token 激活 4 个；
- **多模态**：原生多模态，文本加图像输入、文本输出，16 亿参数视觉编码器；
- **上下文**：100 万 token，适合长代码库、长文档任务；
- **语言**：原生支持 160 多种语言，包括欧盟全部官方语言；
- **训练**：在欧洲自有数据中心从头训练，用了 3800 块英伟达 Grace Blackwell GPU；
- **推理档位**：新增 Low、Medium、High 三档推理模式，默认 High，简单任务切 Low 可以省 token、省成本。

## 编程：官方成绩单确实亮眼

这是 Mistral 主推的方向，官方给出的成绩：

- **FrontierCode 2.0 得分 19.7%**：这个基准测的是端到端代码质量，看模型改完代码仓库后维护者是否愿意合并，Mistral 称这是开源模型第一；
- **Artificial Analysis 编程 Agent 指数 48%**：与中国开源模型 GLM-5.3 持平，但平均每个任务少用 47% 的 token，也就是同样的活花更少的钱；
- **Terminal-Bench 4.0 得分 41%**：比预览版提高 13 个百分点，同时输出 token 减少 30%，官方称这是开源模型在该基准上的领先成绩；
- **真人盲测**：Surge Code 的并排对比中，评审更偏好 Large 4 而非 GLM-5.3、Kimi K3 和 DeepSeek V4.1 Flash，在受测模型里只排在 Claude Opus 5.5 之后；
- **独立指数视角**：Artificial Analysis 的 Intelligence Index v5 给 Large 4 打 26 分，是西方开源模型最高，但仍低于中国开源模型 DeepSeek V4.1 Flash 1017 和 GLM-5.3；同一家机构测得的单任务成本从预览版的 5.54 美元降到 2.06 美元，降幅约 63%。

提醒一句：上面多数成绩来自官方公告，完整技术报告官方说「即将发布」，独立验证还需要时间。编程最强的说法，目前是「官方说法加第三方指数」，不是定论。

## 安全：主打防御，但官方自己也留了口子

Large 4 的另一条主线是网络安全，卖点是「会干活的防御者」：

- **Artificial Analysis 网络安全指数 51%**：测的是在代码库里发现漏洞、复现验证、打补丁且不破坏现有功能，官方称这是开源模型里的领先水平；
- **恶意请求拒答率平均 96.6%**：在 JailbreakBench、StrongREJECT、AgentHarm 三组恶意网络安全提示上测得，官方称是其测过的开源模型最高；
- **Agent 安全基准 B3 抗攻击率 97.1%**：比预览版的 93.3% 又提高一截。

但官方在公告里也坦承了风险：预览期监测真实流量时，看到模型「对真实攻击有潜在提升作用」，正在据此调整护栏。专攻渗透测试、漏洞评估和红队任务的变体不公开发布，只给 Orange Cyberdefense 这类经过严格审查的企业伙伴，且测试限定在自有或明确授权的系统内。开源权重一旦放出就无法收回，这一点官方和评论者都提到了，普通用户不必因此恐慌，但要知道这条边界确实存在。

## 许可证和价格：开源，但有一条红线

Large 4 用的是 Mistral 自家的生态开源权重许可证（Mistral Ecosystem Open-Weight License），即改版 MIT 许可证：

- **允许**：免费使用、修改、微调、商业化；
- **唯一条件**：以 Model-as-a-Service（模型即服务）形式对外提供模型服务时，必须先另外取得 Mistral 的商业许可。自己部署自己用、做成产品卖给客户，不触发这一条；把模型本身当服务转售，才需要谈许可。

官方 API 定价同步公布：**输入 0.70 美元 / 百万 token，缓存输入 0.07 美元 / 百万 token，输出 2.10 美元 / 百万 token**。上线渠道包括 Mistral Studio、Mistral API、OpenRouter、Microsoft Foundry（首家上线的云厂商，支持 Azure 私有部署）和英伟达 NIM 容器；自托管推荐 vLLM 或 SGLang，另有面向 Blackwell GPU 的 NVFP4 量化版，权重里还内置了 DSpark 推测解码头，官方称吞吐最高可提升 1.9 倍。

## 对普通用户和开发者意味着什么

**普通用户**：现在就能在 Mistral Studio 和编程助手 Vibe Code 里试用新模型，Hugging Face 上的官方演示合集在发布首周提供小额共享体验额度，具体以页面为准。日常聊天、写代码、改 Bug 都可以直接用，不需要自己部署。

**开发者和企业**：这次的意义更大。权重可下载、可微调、可私有化部署，加上欧洲从头训练、来源清晰，Mistral 打的是「主权 AI」牌：企业可以把模型放进自己的机房，围着自家数据和规则定制。但要提醒一句：1 万亿参数的权重不是个人电脑能跑的东西，自托管需要多卡集群，大多数团队走 API 或云端托管更现实。

**国内可用性**：官方公告没有给出国家和地区名单，国内能否直接使用目前未证实。本文不写「国内能用」，等开放范围和接入渠道明确后再更新。

**放在开源竞赛里看**：这是欧洲实验室第一次拿出一个在编程效率上追平中国顶级开源模型、且更省 token 的旗舰权重。综合指数上它仍落后于 DeepSeek V4.1 Flash 1017 和 GLM-5.3，但开源权重竞赛从「中国领跑」变成了「中欧对打」，对开发者来说可选的顶级开源底座又多了一个。

## 参考来源

- [Mistral 官方公告：Mistral Large 4 (Le Chonk) is now open weight（英文）](https://mistral.ai/news/mistral-large-4-oss/)
- [Hugging Face 模型卡：mistralai/Mistral-Large-4-1T-A52B（英文）](https://huggingface.co/mistralai/Mistral-Large-4-1T-A52B)
- [VentureBeat：Mistral Large 4 'Le Chonk' arrives as the top open model outside China（英文）](https://venturebeat.com/technology/mistral-large-4-le-chonk-arrives-as-the-top-open-model-outside-china-with-improved-coding-performance-and-63-lower-cost-per-task)

## 更新记录

- 2026-10-30：首发。

## 相关阅读

- [AI前沿动态](/categories/ai前沿动态/)：本分类全部文章。
- [谷歌 Gemini 4 Carbon 发布：专攻网络安全](/posts/gemini-4-carbon-launch/)
- [Reflection Beam 模型档案：501B 开源模型的规格、Apache 2.0 许可、跑分与部署门槛](/posts/reflection-beam-guide/)
