---
title: "百度 ERNIE 5.5 Flash 权重开源了"
date: 2026-11-25T09:36:00+08:00
lastmod: 2026-11-25T09:36:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "国产大模型", "开源模型", "文心一言"]
description: "百度 11 月 24 日开源 ERNIE 5.5 Flash Preview 权重：280B 总参数、每 token 激活 14B、100 万上下文，Apache 2.0。但这只是中间检查点，跑分自报，本地部署要 288GB 显存。"
summary: "百度 11 月 24 日开源 ERNIE 5.5 Flash Preview 权重，Apache 2.0，比承诺提前一天：280B 总参数、每 token 激活 14B、100 万上下文。但这只是中间检查点，跑分全是自报，本地部署门槛不低，能信的和不能信的这篇分开讲。"
showtoc: true
---

先说结论：百度 11 月 24 日把 ERNIE 5.5 Flash Preview 的权重放上了 Hugging Face 与 ModelScope，Apache 2.0 协议，比自己在 11 月 11 日发布时承诺的「11 月 25 日前开源」提前了一天。模型总参数 280B，每 token 只激活 14B，上下文 100 万 token，三个版本一次放出，支持 SGLang 与 vLLM 部署。这是今年中国实验室规模最大的一次开源权重发布之一——但三句话先说清再往下看：第一，百度自己把这次放出的版本叫做「中间检查点」，后训练还没完成；第二，所有跑分都是百度自报，没有独立验证；第三，本地跑它不便宜，最小也要一块 288GB 显存的 Blackwell 卡，普通电脑不用想。本文的数字后面都标了出处，官方说法和第三方说法分开写。

![插画：深蓝夜空下发光的神经网络与一扇敞开的金色大门，象征开源权重向全球开发者开放](/images/ernie-5-5-flash-preview-open-weights/cover.webp)

## 1. 发布了什么：从 Base 到 Preview，三步走完

这次开源不是突然发生的，百度 11 月上半月分三步走完：

| 时间 | 事件 | 状态 |
| :--- | :--- | :--- |
| 2026-11-05 | ERNIE 5.5 Flash Base 开源 | 底座检查点，百度自有协议 |
| 2026-11-11 | ERNIE 5.5 Flash Preview 发布 | 对话版上线，API 走百度千帆，OpenRouter 有免费档，承诺 11 月 25 日前开源权重 |
| 2026-11-24 | Preview 权重上架 Hugging Face 与 ModelScope | Apache 2.0 协议，比承诺提前一天 |

Preview 是 Base 之上的后训练版本，也就是真正能对话、能干活的版本。按 Hugging Face 官方模型卡，关键参数如下：

| 项目 | ERNIE 5.5 Flash Preview（Hugging Face 模型卡） |
| :--- | :--- |
| 总参数 / 每 token 激活 | 280B / 14B |
| 架构 | MoE：43 层（1 层 dense + 42 层 MoE），512 个路由专家、每 token 选 10 个，另有 1 个共享专家 |
| 上下文 | 1,048,576 token（100 万） |
| 思考模式 | 默认开启，`reasoning_effort` 可设 low / medium / high |
| 推测解码 | 带 DSpark 草稿头（draft head） |
| 精度 | 块 FP8，路由专家用 MXFP4，FP8 KV 缓存 |
| 词表 | 201,216 |
| 权重版本 | 默认版（FP4 专家权重）、FP8 版、BF16 版（官方推荐微调用 BF16） |
| 部署框架 | SGLang、vLLM |

和 11 月 5 日的 Base 比，Preview 最大的变化不在参数，而在两点：第一，上下文从 12.8 万 token 扩到 100 万 token，是在中期训练阶段扩的；第二，后训练对准了四个方向——编程、3D 建模、知识工作与内容创作。百度官方发布页展示的实例包括用 C++ 与 Unreal Engine 5.8 写一个第三人称武侠游戏（11 小时编码任务）、在 Blender 里建机场与客机、CAD 建模与研究报告。这些都是官方 showcase，证明链路能跑通，不等于在你的任务上也能一次跑通。

## 2. 许可证才是这次真正的新闻：Apache 2.0，但只覆盖 Preview

这次发布最值得写进标题的不是参数，而是许可证。Preview 的权重用的是 **Apache 2.0**，这是最宽松的主流开源协议之一：允许商用、允许修改、允许分发，还附带专利授权。对国内团队来说，最实际的意义有三条：不用再等 API、不怕服务下线、可以拿权重做私有化微调。

但协议细节必须讲清，有两处容易踩坑：

**第一，Apache 2.0 只覆盖 Preview 的权重，不覆盖 Base。** Base 仍在百度自己的《ERNIE 5.5 Flash Base Model License Agreement v1.0》之下。两个检查点共享架构与分词器，工具链可以通用，但协议是两份。下载时认准仓库名 `baidu/ERNIE-5.5-Flash-Preview`，别下成 Base。

**第二，拿 Apache 2.0 和同行横向比，百度的这次选择是偏开放的一端。** 智谱 GLM-5.3 用 MIT 协议，同样宽松；美团 LongCat-2.5 也是 MIT。但 MiniMax 的 H3 系列用的是自家社区协议，明确排除美国、欧盟、英国与韩国四个地区。ERNIE Preview 的 Apache 2.0 没有这类地域排除条款——这是它和 MiniMax 路线的实质区别。当然，最终以仓库里的 LICENSE 文件原文为准，商用前自己读一遍协议文本，别只看新闻标题。

还有一个背景值得提：百度在发布页里承诺权重「11 月 25 日前开源」，这次 11 月 24 日兑现，提前一天。承诺兑现本身也是信号——11 月是国产模型开源密集落地的月份，GLM-5.4 刚在 11 月 23 日发布（权重还没影），ERNIE Preview 是同期唯一一个「发布两周内就把权重交出来」的旗舰对话模型。

## 3. 横向比：先看清哪些数字能信、哪些不能

把 ERNIE 5.5 Flash Preview 放进同一张表里，再逐行讲可信度：

| 模型 | 参数（总/激活） | 上下文 | 权重与协议 | API 状态 |
| :--- | :---: | :---: | :--- | :--- |
| **ERNIE 5.5 Flash Preview（百度，11-24）** | **280B / 14B** | **1M** | **已开源，Apache 2.0** | **已上线，千帆 + OpenRouter 免费档** |
| GLM-5.3（智谱，08-14） | 744B / 40B | 以官方模型卡为准 | 已开源，MIT | 已上线 |
| GLM-5.4（智谱，11-23） | 约 750B | 1M | 计划开源，无日期 | 未上线（Coming Soon） |
| Qwen4-Max（阿里，11-16） | 2.4T / 71B | 1M | 闭源 | 已上线，$1.50 / $4.50 |
| Kimi K3.1 Pro（月之暗面） | 未公开 | 未公开 | 未公开 | 已上线 |
| DeepSeek-V4.1-Flash | 未公开 | 未公开 | 未公开 | 已上线 |
| LongCat-2.5（美团） | 1.6T | 未公开 | 已开源，MIT | 已上线 |

（GLM-5.4 见本站[智谱 GLM-5.4 发布](/posts/glm-5-4-loop-transformer/)；Qwen4-Max 见 [Qwen4-Max 正式上线](/posts/qwen4-max-launch/)；LongCat-2.5 见 [LongCat-2.5 权重开源](/posts/longcat-2-5-open-weights/)。）

这张表最值得说的不是参数，而是**三组数字的可信度完全不同**：

**能信的：架构、规模、许可证、上线渠道。** 280B / 14B、100 万上下文、43 层结构、Apache 2.0、三个权重版本、Hugging Face 与 ModelScope 双渠道，这些是百度官方模型卡原文，多家独立报道交叉一致。API 在千帆上线、OpenRouter 有免费档，也是模型卡与第三方报道一致的事实。

**半信的：解码速度。** SGLang 官方账号 11 月 24 日发帖称，单批次解码从 102 tokens/s 推到 1,074 tokens/s，用的是 4 块 Blackwell 卡。这是 SGLang 自己的说法，不是百度模型卡里的数字，也不是独立第三方复测。速度数字的测试条件（批次、精度、上下文长度）不同，结果会差很多，先当作「框架方的优化成绩」看，别当成你部署后就能拿到的速度。

**不能直接信的：所有跑分。** 模型卡里列了 20 项基准，但明确写着「所有 ERNIE 分数都来自百度自己的评测」。目前流传的几个数字都要按这个口径理解：CodeArena WebDev 1,668 分，开源模型第二、国内模型第四（排在 Kimi K3.1 Pro 与 Qwen3.8-Max 之后）；Terminal-Bench 4.0 得分 46.5，而同一张表里的 Claude Opus 5.5 是 66.4，差距不小；AutomationBench 与 SpreadsheetBench V2 排第一，同样是百度自报。跑分本身没造假的证据，但出题、跑分、报分都是同一方，等 Artificial Analysis 与 LMArena 这类独立评测收录后再下结论。尤其注意：Terminal-Bench 4.0 上 46.5 对 66.4 的差距说明，在终端编码这类硬任务上，Preview 和最顶级的闭源模型还有明显距离，别只看「开源第二」这个排名就下单。

还有一个对照值得注意：同样是 11 月开源权重的国产旗舰，LongCat-2.5 是 1.6T 参数、BF16 约 3.56TB，部署示例要 194 块国产加速器；ERNIE Preview 的 FP4 版约 155GB，门槛低得多。两者定位不同：LongCat 赌的是超大参数的 Agent 能力，ERNIE 赌的是「大参数、小激活」的性价比——280B 的底子，每 token 只花 14B 的算力。

## 4. 现在怎么用：API 今天就能调，本地部署先算显存账

普通人今天能用上 ERNIE 5.5 Flash Preview 的路径有两条，门槛完全不同：

**第一条：调 API，不用部署。** 百度千帆平台的模型 ID 是 `ernie-5.5-flash-preview`，国内开发者直接走千帆调用。OpenRouter 上也有 `baidu/ernie-5.5-flash-preview:free` 的免费档——注意 OpenRouter 是海外平台，国内直连情况未核实，免费档是预览期临时安排，不是长期定价。价格方面：据第三方统计，千帆国际站标价约 $0.28 / 百万输入 token、$1.13 / 百万输出 token；国内站据 AI Tech Review 报道为峰时 2 元 / 8 元、谷时 1 元 / 4 元（每百万 token 输入 / 输出），并有 5 折优惠到 11 月 30 日。国内价格以千帆官网价目为准，本文的数字是第三方报道口径，下单前自己在官网核对。

**第二条：本地部署，先算清三笔账。** 三个权重版本的体积，据 SGLang 官方手册：FP4 版约 155GB、FP8 版约 280GB、BF16 版约 560GB。按百度 vLLM 插件的说法，能装下 FP4 版的最小配置是一块 288GB 显存的 Blackwell 卡。部署细节：vLLM 需要 0.32.0 版本的轮子加百度插件，且只支持 NVIDIA 显卡；SGLang 的部署命令模型卡里直接给了。还有两个限制要先知道：目前没有 GGUF 量化，llama.cpp 与 Ollama 暂不支持，普通笔记本与 Mac 本地跑暂时没戏；BF16 版是官方推荐的微调版本，体积最大，微调之前先确认自己的卡够不够。

给不同人的建议很直接：

1. **只想试试效果的，先调 API。** 千帆有国内入口，OpenRouter 有免费档。先拿一个真实任务试：比如长文档改写、多文件改代码，重点感受 100 万上下文是不是真能装下你的材料，以及思考模式默认开启会不会让简单问题也等很久。
2. **想私有化部署的，先算显存账再动手。** 155GB 只是权重，还要留 KV 缓存与激活的空间。一块 288GB 的卡是起步价，不是「够用」的保证。等不及的可以先看本站的[中国大模型 API 价格表](/posts/china-llm-api-pricing/)，对照已上线模型的输入输出价算账：很多时候调 API 比自己买卡便宜。
3. **想微调的，等正式版。** Preview 是中间检查点，百度明说后训练还没完成。现在基于它微调，正式版出来后可能要重做。真要动手，用 BF16 版，别用 FP4 版。

## 5. 三个提醒：下单之前先看完

### ⚠️ 提醒 1：Preview 不是正式版，别按正式版排期

百度在模型卡里写得很直白：Preview 是后训练的中间检查点，「因为训练还没完成，有些能力可能还达不到」。正式版的发布时间没公布。任何基于 Preview 的长期规划——比如把它定为公司的主力模型、或围绕它做微调管线——都要留出正式版出来后可能要返工的余地。

### ⚠️ 提醒 2：跑分全是自报，「开源第二」不等于「第二强」

CodeArena WebDev 1,668 分、开源第二，这个排名本身是百度自报的成绩。同一张自报表里，Terminal-Bench 4.0 上 Preview 46.5 分，Claude Opus 5.5 是 66.4 分。两个数字放在一起看，结论是：Preview 在网页开发这类任务上有竞争力，在终端编码这类硬任务上和顶级闭源模型还有明显差距。等独立评测出来之前，别把任何一个排名当成选型结论。

### ⚠️ 提醒 3：别和 Base 搞混，下载认准 Preview 仓库

11 月 5 日的 Base 是底座检查点，不能对话，用的是百度自有协议；11 月 24 日开源的 Preview 才是对话版，用 Apache 2.0。两个仓库共享架构与分词器，但协议、用途、下载地址都不同。下载认准 `baidu/ERNIE-5.5-Flash-Preview`，ModelScope 上也是同名仓库。任何现在就卖「ERNIE 5.5 本地部署包」「ERNIE 5.5 免费额度」的第三方，都与官方口径对不上。

## 6. 总结

ERNIE 5.5 Flash Preview 的权重开源，是百度 11 月兑现的一张期票：280B 总参数、每 token 激活 14B、100 万上下文，Apache 2.0 协议，Hugging Face 与 ModelScope 双渠道，比承诺提前一天。对开发者来说，这是同期国产旗舰里唯一一个「发布两周内就把对话版权重交出来」的模型，许可证也是偏开放的一端；对普通人来说，今天能用的还是 API，本地部署的门槛摆在那里，155GB 权重与 288GB 显存不是小数目。值得跟的三件事：正式版何时发布、Artificial Analysis 与 LMArena 的独立分数、国内云厂商会不会出开箱即用的一键部署镜像。任何一项落地，都值得再写一篇跟进。

## 参考来源

- [Hugging Face 官方模型卡：baidu/ERNIE-5.5-Flash-Preview](https://huggingface.co/baidu/ERNIE-5.5-Flash-Preview)：280B / 14B、100 万上下文、三版本权重、Apache 2.0、中间检查点声明（2026-11-24）
- [百度官方发布页：Introducing ERNIE 5.5 Flash Preview](https://ernie.baidu.com/release/ernie-5-5-flash-preview/)：11 月 11 日发布原文，API 上线千帆、权重承诺 11 月 25 日前开源（2026-11-11）
- [Superpower Daily：Baidu publishes ERNIE 5.5 Flash Preview weights under Apache 2.0](https://superpowerdaily.com/posts/baidu-publishes-ernie-5-5-flash-preview-weights-under-apache-2-0)：权重 11 月 24 日上架、Terminal-Bench 4.0 自报分数对照（2026-11-24）
- [EastFrontier：Baidu Launches ERNIE 5.5 Flash Preview, With Open Weights Due by November 25](https://eastfrontier.com/2026/11/12/baidu-launches-ernie-5-5-flash-preview-with-open-weights-due-by-november-25/)：发布背景、国内 API 价格与 5 折优惠（2026-11-12）
- [DEV：How to Run ERNIE 5.5 Flash Preview Locally](https://dev.to/alanwest/how-to-run-ernie-55-flash-preview-locally-the-minimum-is-a-288-gb-gpu-4ag6)：三版本体积、288GB 显存门槛、vLLM 部署要求、暂无 GGUF（2026-11-24）
- [Times of AI：Baidu Opens ERNIE 5.5 Flash Preview Under Apache 2.0](https://timesof.ai/2026/11/baidu-ernie-5-5-flash-base-280b-moe)：权重 11 月 24 日发布、许可证只覆盖 Preview（2026-11-24）

## 核验记录

- 核对日期：2026-11-25。权重发布事实（2026-11-24、Hugging Face 与 ModelScope 双渠道、Apache 2.0、三版本）以 Hugging Face 官方模型卡为准，百度官方组织页标注的发布日期与 Superpower Daily、Times of AI 交叉一致；发布时间线（Base 11-05、Preview 11-11、权重 11-24）以百度官方发布页与模型卡为准。
- 参数（280B / 14B、100 万上下文、43 层、512 路由专家）以 Hugging Face 模型卡原文为准；三版本体积（155GB / 280GB / 560GB）、288GB 显存门槛、vLLM 0.32.0 要求、暂无 GGUF，以 DEV 文章引用的 SGLang 手册与百度 vLLM 插件说明为准，本文未亲自部署验证。
- 跑分（CodeArena WebDev 1,668、Terminal-Bench 4.0 46.5 对 Claude Opus 5.5 的 66.4、AutomationBench 第一）均为百度自报，模型卡明确标注；SGLang 的 1,074 tokens/s 是 SGLang 官方账号的说法，未经独立复测。价格（国际站 $0.28 / $1.13、国内峰谷价与 5 折到 11 月 30 日）为第三方报道口径，以千帆官网价目为准；OpenRouter 免费档为预览期临时安排，国内直连情况未核实，本文未写「国内直连可用」。

## 相关阅读

- [智谱 GLM-5.4 发布：28 层跑两遍的旗舰模型](/posts/glm-5-4-loop-transformer/)：11 月 23 日发布的国产旗舰对照，750B 参数、Loop Transformer，API 与权重都还没影。
- [Qwen4-Max 正式上线：2.4 万亿参数按量计费，$1.50/$4.50——但旗舰本身不开源](/posts/qwen4-max-launch/)：11 月 16 日上线的国产旗舰对照，2.4T 参数、1M 上下文，基准口径同样冲突。
- [LongCat-2.5 权重开源：1.6 万亿参数能下载，3.56TB 却拦住大多数人](/posts/longcat-2-5-open-weights/)：同是 11 月开源权重的国产模型，MIT 协议，但部署门槛高得多。
- [Kimi K3.1 Pro 权重开源了：本地部署完整教学](/posts/kimi-k3-1-pro-local-deploy/)：国产模型本地部署的参照，硬件账与 vLLM 步骤。
- [中国大模型 API 价格表](/posts/china-llm-api-pricing/)：8 家旗舰模型输入输出价、缓存价对照，ERNIE 5.5 Flash Preview 的 API 价上线后会补进这张表。
- 更多中国与开源模型见 [中国与开源模型](/categories/中国与开源模型/)。
