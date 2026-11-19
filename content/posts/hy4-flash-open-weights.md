---
title: "Hy4 Flash 权重开源了：220B、每 token 只激活 12B，每任务成本是旗舰的 1/20——但旗舰 Hy4 还没影"
date: 2026-11-19T10:49:00+08:00
lastmod: 2026-11-19T10:49:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "国产大模型", "开源模型", "腾讯混元"]
description: "腾讯 11 月 17 日把 Hy4 Flash 权重放上 Hugging Face：220B 参数、每 token 激活 12B、1M 上下文，每任务成本只有旗舰 Hy4 的 1/20。但许可证不是 Apache 2.0，旗舰权重仍未公开。"
summary: "Hy4 的便宜款先把权重开源了：11 月 17 日，Hy4 Flash、FP8 版与 base 版三个仓库同时上架 Hugging Face，220B 总参数、每 token 激活 12B，腾讯自报每任务成本只有旗舰 Hy4 的 1/20。但这不是旗舰 Hy4 本人——旗舰权重今天仍未公开；许可证也不是 Apache 2.0，年收入超 5000 万美元的模型服务商要另签书面许可；Transformers 支持还没合入主分支。本文先把三件事拆开：落地的到底是什么、便宜是真便宜还是口径游戏、普通人现在能不能跑起来。"
showtoc: true
---

先说结论，再说限定：**Hy4 Flash 的权重真的开源了**——11 月 17 日，腾讯把 Hy4 Flash、Hy4 Flash-FP8 与 Hy4 Flash-base 三个仓库同时放上 Hugging Face，另有 ModelScope 与 GitCode 镜像。11 月 16 日它刚以 API 形态上线（$0.070/$0.281 每百万 token），一天之后权重就跟着来了，兑现了发布时"计划开源"的说法。

但三句话限定要先写死。第一，**这是 Flash，不是旗舰 Hy4**：旗舰 Hy4 的权重今天（11 月 19 日上午）仍未公开，`tencent/Hy4` 直接查还是 401，能下载的仍只有 8 月的 Hy4-preview。第二，**许可证不是 Apache 2.0**：Hy4 Flash 用的是腾讯自己的 Tencent Hy License 1.0，大客户要另签书面许可。第三，**便宜是腾讯自报**：成本与盲测数字全部来自腾讯自己的 WorkIndex 与内部盲测，没有独立第三方评分，Artificial Analysis 上至今没有 Hy4 Flash 的条目。

## 1. 落地的到底是什么：三个仓库，别下错

| 仓库 | 是什么 | 用途 |
| :--- | :--- | :--- |
| `tencent/Hy4-flash` | 指令微调版（instruct） | 聊天、agent，直接部署 |
| `tencent/Hy4-flash-FP8` | FP8 量化版 | 生产 serving，官方 vLLM/SGLang 示例用的就是它 |
| `tencent/Hy4-flash-base` | 预训练基座（无指令微调） | 微调起点；模型卡明说聊天示例不适用它 |

三者都在 Hugging Face、ModelScope、GitCode 同步上架。参数构成要按模型卡写：总参数 220B，其中主干 155.5B、Engram n-gram 嵌入表 63.5B、视觉编码器 0.43B、推测解码器 DFly2 0.85B；每 token 激活文本 11.3B 加视觉 0.43B，约 12B。注意一个口径出入：11 月 16 日发布稿称 224B，模型卡各项相加是 220.3B，本文按模型卡的 220B 写。

架构上有三处改动，都是冲着便宜去的。第一，混合注意力：稀疏注意力（IndexPool）与滑窗注意力按 1:3 交错，KV 缓存只有 Hy3 的 1/24、Hy4 的 1/6。第二，LatentMoE：每 token 路由 16/512 个专家加 1 个共享专家，专家在低维隐空间里算。第三，Engram：bigram 与 trigram 的 n-gram 嵌入表，用哈希查表代替一部分计算。另有内置的 5 层推测解码器 DFly2，复用目标模型的 KV 缓存，官方称解码速度超过 150 tokens/s。后训练是拿 Hy4 当老师做自蒸馏，再用强化学习把平均输出 token 砍掉一半——便宜一半靠架构，一半靠少说话。

## 2. 便宜是真的，但三组数字要分开读

腾讯自报的成本账是这样的：WorkIndex（腾讯内部以日常办公任务为基准的评测，含做幻灯片、修表格、改文档等 8 类任务）上，Hy4 Flash 得 42.1 分，Hy4-preview 39.7 分，旗舰 Hy4 是 51.4 分；每任务成本是 Hy4-preview 的 1/13、旗舰 Hy4 的 1/20、DeepSeek-V4.1-Flash 的 1/8。盲测里，85 名内部用户、259 个任务，Hy4 Flash 的用户满意度 2.79/4，接近 Claude Haiku 5.5 的 2.81/4，中位完成时间 6.7 分钟，每任务 0.26 元。

三组数字没有一组能直接当结论。第一，42.1 对 51.4 说明 Flash 比旗舰弱一档，腾讯自己也写明：日常生产力任务用 Flash，长程软件工程等复杂任务仍推荐旗舰 Hy4——便宜款不是旗舰平替。第二，1/20 是"每任务成本"，不是标价比：API 标价 $0.070/$0.281 本来就便宜，成本口径还叠加了输出 token 更少、缓存更好这些因素，换一套任务集数字会变。第三，WorkIndex 与盲测都是腾讯自己的尺子，基座模型的公开基准表（MMLU 88.7、MMLU-Pro 71.1、SimpleQA 37.5）同样出自模型卡自报，且模型卡自己加了免责：基座在中期训练里见过大量合成指令数据，few-shot 评测的格式遵循可能失真，分数量化上要打折。

对照表把定位一次讲清：

| 模型 | 总参数 / 激活 | 上下文 | WorkIndex | 每任务成本（相对） | 权重状态 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Hy4 Flash | 220B / 12B | 1M | 42.1 | 基准（最便宜） | 已开源（11 月 17 日） |
| Hy4-preview | 约 770B / 49B | 1M | 39.7 | 约 13 倍 | 8 月已公开 |
| Hy4（旗舰） | 未公布 | 1M | 51.4 | 约 20 倍 | 未公开，只有预览版 |
| DeepSeek-V4.1-Flash | 未列 | — | 未列 | 约 8 倍 | — |

## 3. 实战：现在能不能跑起来

能，但有三处要先踩点。

**部署路线是现成的。** 生产 serving 腾讯推荐 vLLM 或 SGLang，都有官方预制镜像：`vllm/vllm-openai:hy4-flash` 与 `lmsysorg/sglang:hy4-flash`，官方示例用 FP8 版、8 卡张量并行、开 DFly2 推测解码。微调有完整 pipeline，文档在模型卡的 Finetuning 一节。

**Transformers 还没接上。** 模型卡明说支持"很快合入主分支"，今天要用的话，得从 transformers 的 PR 50903 分支安装。这是今天最容易踩的坑：按常规 `from_pretrained("tencent/Hy4-flash")` 直接跑，版本不对会报错。

**本地跑的门槛要算清。** 官方还给了 AngelSlim 工具做的 GGUF 压缩版，第三方整理最小的 IQ2-AH 约 125.7 GiB；但 llama.cpp 的支持还在 open PR，没合入，要从分支自己编译。220B 的模型，FP8 也要 200GB 量级显存加 KV，官方示例就是 8 卡并行——权重可下载，不等于人人能本地跑，和 Inkling 2 Small、LongCat-2.5 是同一个道理。先用 API（$0.070/$0.281）试任务，确认值得再谈自部署。

## 4. 五个避坑点

- **别把 Flash 当 Hy4。** WorkIndex 42.1 对 51.4，复杂长程任务官方仍推荐旗舰；旗舰权重今天仍未公开，距腾讯 11 月 4 日"未来几天"已 15 天。
- **许可证先读第 10.2 条。** Tencent Hy License 1.0 是 Apache 2.0 的衍生：年收入超 5000 万美元的模型即服务业务，或月活超 1 亿的产品，用权重前要另签书面许可；内部使用豁免。个人与小团队自用不受影响，但要拿它对外卖 API，先走法务。
- **224B 与 220B 别混用。** 发布稿 224B、模型卡 220.3B，写 220B 并注明按模型卡。
- **Transformers 别直接装正式版。** 今天要用，先按模型卡从 PR 50903 分支装，等合入主分支再换回来。
- **成本数字是腾讯自报。** WorkIndex、盲测、每任务 1/20 都是腾讯自己的尺子，Artificial Analysis 至今没有 Hy4 Flash 的评分；写进选型结论前，先拿自己的任务跑一遍 API。

## 总结

Hy4 Flash 权重开源的正确读法是三句话：便宜款先落地了，220B、12B 激活、1M 上下文，每任务成本自报只有旗舰的 1/20；许可证留了个大客户条款，不是无条件开源；旗舰 Hy4 的权重仍未公开，15 天前那句"未来几天"至今没有下文。对普通人，先走 API 试任务（$0.070/$0.281）；对要自部署的人，等 Transformers 合入主分支、确认 8 卡之外的跑法再动手；对要拿它对外卖服务的人，先读许可证第 10.2 条。

相关阅读：旗舰 Hy4 的 API 上线背景见 [Hy4 与 Hy4 Flash 发布：旗舰 API 与便宜款的定位](/posts/hunyuan-hy4-launch/)；同样"权重可下载不等于能本地跑"的对照见 [LongCat-2.5 权重开源解读](/posts/longcat-2-5-open-weights/)；旗舰本身不开源、只走 API 的另一例见 [Qwen4-Max 正式上线解读](/posts/qwen4-max-launch/)。

## 参考来源

- [Hugging Face 模型卡：tencent/Hy4-flash（本文直接查阅，2026-11-19）](https://huggingface.co/tencent/Hy4-flash)
- [OrcaRouter：Hy4 Flash 开源权重与许可证解读](https://www.orcarouter.ai/blog/tencent-hy4-flash-open-weights)
- [MLQ：腾讯发布 Hy4 Flash 开源权重](https://af.net/realtime/tencent-releases-open-weight-hy4-flash-model-with-220b-parameters/)
- [Toolhalla：GGUF 体积与 llama.cpp 支持状态](https://toolhalla.ai/huginn)

核验记录（2026-11-19 上午）：三仓库上架、参数构成、WorkIndex 与盲测数字、部署镜像与 Transformers PR 状态均来自 Hugging Face 模型卡原文直接查阅；旗舰 Hy4 权重未公开为同日直接查 `tencent/Hy4` 返回 401；许可证大客户条款来自 Tencent Hy License 经 OrcaRouter 与 MLQ 交叉；GGUF 最小体积与 llama.cpp PR 状态来自第三方整理，未独立实测。本文未亲自跑分，所有基准均为厂商自报口径。
