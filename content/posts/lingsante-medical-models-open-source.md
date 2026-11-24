---
title: "蚂蚁 LingSante 医疗模型开源了：普通人能用吗？"
date: 2026-11-24T21:30:00+08:00
lastmod: 2026-11-24T21:30:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "开源模型", "国产大模型"]
description: "蚂蚁 11 月 23 日开源 LingSante 医疗模型家族：flash 560B、air-VL 124B，MIT 协议。普通人能不能用、部署门槛多高、分数可不可信，一次说清。"
summary: "蚂蚁开源了两款医疗模型，MIT 协议、权重可下载，但普通人直接用不上：flash 要 4 张数据中心 GPU，air-VL 是研究模型不是医疗器械。真正马上能用的是 Afu App，分数则全是厂商自测。"
showtoc: true
---

**结论先说：蚂蚁 11 月 23 日把 LingSante 医疗模型家族的两款核心模型开源了，权重挂在 Hugging Face 上，MIT 协议，谁都能下载。但「开源」不等于「普通人能用」——大模型 flash 量化后约 292GB，要 4 张数据中心 GPU 才跑得动；轻量版 air-VL 是研究模型，不是医疗器械，不能拿来问诊。真正马上能用的是 Afu App 里已经上线的服务。分数也要打折看：目前所有成绩都是厂商自测，唯一独立评分只有 23.3%。**

![插画：一位医生站在大屏幕前，屏幕上有心电图波形与肺部影像轮廓，桌上放着听诊器](/images/lingsante-medical-models-open-source/cover.webp)

## 1. 这次到底开源了什么

11 月 23 日，蚂蚁旗下 AI 健康应用 Afu（原名 AQ）通过 BusinessWire 通稿宣布推出 LingSante 医疗健康 AI 模型家族。家族基于蚂蚁 Ling 基础模型，在 Afu 上已经大规模应用：截至 2026 年 9 月，Afu 有 1.5 亿用户，每天处理近 2000 万次健康咨询。

开源是分阶段进行的，第一批放出两款核心模型，权重已上 Hugging Face（inclusionAI 组织）：

- **LingSante-3.1-flash**：专业级深度推理模型，面向复杂临床任务。
- **LingSante-3.1-air-VL**：轻量原生多模态模型，面向个人用户与小机构。

值得注意的是，权重实际上在 11 月 19 日前后就已悄悄上架，官方直到 11 月 23 日才正式官宣——这个时间差是第三方追踪记录，通稿里没有提。

家族里另外三款这次没有开源：Pulse 是健康预测模型，能评估 150 多种疾病的风险；MedGuard 是安全模型，管医疗安全、合规与生物伦理；Live 是实时多模态智能体，源自中医「望闻问切」，已经集成进 Afu App 做 AI 视频问诊。想用这三款，只能走 Afu App，没有权重可下载。

蚂蚁同时还推了 InclusionMed 评测平台，联合了 29 家全球机构，包括斯坦福、哈佛与北京协和医学院。首期排名里，flash 拿了开源医疗模型第一——这个名次后面还要细说，不能只看标题。

## 2. 参数对照表：两款模型差在哪

| | LingSante-3.1-flash | LingSante-3.1-air-VL |
| --- | --- | --- |
| 总参数 | 560B | 124B |
| 每 token 激活参数 | 约 25B | 5.5B |
| 上下文 | 1M（模型卡宣称） | 256K |
| 输入 | 文本 | 文本、图像（通稿还提到视频） |
| 架构 | 混合线性 MoE，基于 Ling-3.1-flash | 原生多模态 MoE，基于 Ling-3.0-flash-VL |
| 定位 | 复杂临床推理、证据检索、长流程任务 | 个人用户与小机构：医学影像、皮肤、饮食、报告解读 |

两个上下文数字千万不要搞混：**air-VL 是 256K，不是 1M**。1M 是 flash 模型卡上写的数字，而且还有一个出入要提醒：第三方分析指出，flash 仓库实际配置文件的上限是 262,144 tokens，与模型卡宣称的 1M 对不上。部署之前，以实测为准，不要只信宣传数字。

air-VL 的四个临床方向写在模型卡上：医学影像报告、多模态健康评估（皮肤识别、饮食营养分析、体检报告解读）、医学搜索与证据综合、医疗界面智能体。它是蚂蚁医疗团队开源的第一个大型多模态医疗模型。上一代医疗版本 Ling-3.0-flash-Sante 是 124B 总参数、5.1B 激活，这次 air-VL 算是它的换代。

## 3. 普通人到底能不能用

三种人，三种答案。

**只想问健康问题：用 Afu App，不用碰模型。** Afu 就是这次模型的实际应用场景：AI 视频问诊已经上线，AI 的回答由 16 个专科的真人医生复核。国际版计划覆盖 170 多个国家和地区，但没有给上线时间。8 月升级的「AQ for Doctor」医生平台连接了 30 多万名认证医生。

**研究者与开发者：可以下载权重做研究。** MIT 协议非常宽松，在临床 AI 领域算是少见的。但要遵守模型卡的用途限制：研究与评测可以，临床使用不行。

**想自己部署给病人用：不行。** 两个模型卡都明写：这是研究模型，不是医疗器械；输出可能不完整、不准确，不能替代专业医疗建议、诊断或治疗；不能作为诊断、处方、治疗的独立依据。模型卡还写明，基准与模拟环境的结果不能证明临床有效性。

本地部署的思路可以参考站内已有的文章，例如 [Kimi K3.1 Pro 本地部署](/posts/kimi-k3-1-pro-local-deploy/) 与 [Open WebUI 部署指南](/posts/open-webui-deploy-guide/)，但要先明白一件事：部署一个 560B 的医疗模型，和部署 Kimi 完全不是一个量级，硬件账要先算清楚。

## 4. 部署门槛：下载只是第一步

flash 的部署门槛很高。FP8 原始权重约 578GB，量化后约 292GB，需要 4 张数据中心 GPU。官方 Quickstart 给的例子更夸张：SGLang 部署要 8 张 H200（张量并行 8、专家并行 8），或者 4 张 GB300；vLLM 也要 8 卡张量并行。普通人没有这种硬件，下载了也跑不起来。

air-VL 轻得多，但 124B 总参数仍然是百亿级模型，个人电脑跑不动。它的定位是小机构本地部署与端侧应用，不是装在手机里自己问诊。

所以这次开源的主要受益者很明确：有算力的研究机构与开发者，而不是普通用户。普通人真正能摸到的，是 Afu App 里已经跑起来的服务——模型开源与否，对 App 用户没有直接区别。

## 5. 分数怎么看：全是厂商自测

先列厂商公布的自测成绩，全部来自模型卡与官方通稿，没有独立实验室在发布时复核过：

- HealthBench Pro：**65.72**
- HLE-with-tools：72.22
- BrowseComp：94.10

关键的一行对比在 HealthBench Pro 上：LingSante-3.1-flash 只比底座 Ling-3.1-flash 高 0.37 分（65.72 对 65.35）。也就是说，医疗专项训练带来的提升很小，底座本身已经很强了。只看 65.72 这个绝对值，会高估这次医疗训练的增量。

InclusionMed 的排名也要拆开看。官方通稿说 flash 在首期排名中位列开源医疗模型第一；但同一平台的性能-成本综合榜上，flash 总分 45.064，在 23 个配置里只排第 5。两个榜单口径不同，「第一」是开源分组里的第一，不是全场第一。

目前唯一的独立评分来自 Artificial Analysis 的 MLCR-AA（长上下文医疗推理测试）：**23.3%**。这个数字和厂商自测给人的印象差距很大。差距本身不等于模型不行——测试口径不同、长上下文医疗推理本来就难——但它说明一件事：在独立评测跟上之前，厂商的分数只能参考，不能当成临床有效的证据。

## 6. 放到国产开源格局里看

2026 年，国产大模型开源已经是常态。[DeepSeek 完全指南](/posts/deepseek-complete-guide-2026/) 里的路线、[Kimi 的开源与本地部署](/posts/kimi-guide/)、智谱 GLM 的持续放量，都是同一条线。医疗是其中最敏感的一条垂直线，LingSante 的特殊之处有三点：规模（560B 是目前开源医疗模型里最大的之一）、协议（MIT 协议在临床 AI 里少见地宽松）、真实场景（Afu 每天 2000 万次咨询的真实流量，不是实验室数据）。

风险点也很直接：医疗模型一旦开源，滥用门槛也低了，模型卡上的限制全靠使用者自觉。蚂蚁同时推 InclusionMed 评测平台，联合 29 家机构做标准，多少也是想把评测话语权握在自己手里。标准是中立的还是有利于自家模型，要等独立评测多起来才能判断。

对普通读者来说，这次发布真正值得记住的只有三句话：模型是真的开源了，MIT 协议；普通人用不上权重，用 Afu App 就行；分数全是厂商自测，独立评测还没跟上。至于它以后能不能变成靠谱的医疗助手，要看独立评测与真实临床验证，不看发布会通稿。

## 常见问题

**问：普通人能直接下载 LingSante 用吗？**

答：技术上能下载，实际上跑不起来。flash 量化后约 292GB，要 4 张数据中心 GPU；air-VL 也要专业部署。想体验这次的技术，直接用 Afu App，里面的 AI 视频问诊已经上线。

**问：air-VL 和 flash 该选哪个？**

答：个人或小机构做研究，用 air-VL；复杂临床推理研究，用 flash。两个都是研究模型，不是医疗器械，选哪个都不改变这个前提。

**问：1M 上下文是真的吗？**

答：模型卡这么写，但第三方分析指出 flash 仓库实际配置文件的上限是 262,144 tokens，与宣称的 1M 对不上。air-VL 只有 256K，部署之前以实测为准。

**问：能拿它看病、开药吗？**

答：不能。两个模型都不是医疗器械，输出可能不完整、不准确，不能替代医生，更不能作为诊断、处方、治疗的依据。有问题去医院，或者用 Afu App 里有真人医生复核的服务。

## 来源

- [Ant Group's AI App Afu Open Sources Medical and Health AI Model Family（BusinessWire，2026-11-23 07:10 UTC）](https://www.businesswire.com/news/home/20261122564652/en/Ant-Groups-AI-App-Afu-Open-Sources-Medical-and-Health-AI-Model-Family)：LingSante 家族发布、两款开源模型参数、Pulse/MedGuard/Live 介绍、InclusionMed 首期排名。
- [inclusionAI/LingSante-3.1-flash 模型卡（Hugging Face）](https://huggingface.co/inclusionAI/LingSante-3.1-flash)：560B/25B/1M 上下文、架构参数、Quickstart 部署配置、用途限制（研究模型，非医疗器械）。
- [inclusionAI/LingSante-3.1-air-VL 模型卡（Hugging Face）](https://huggingface.co/inclusionAI/LingSante-3.1-air-VL)：124B/5.5B/256K 上下文、四个临床方向、「研究模型，不是医疗器械」声明。
- [Ant Group releases LingSante medical AI models（TechNode，2026-11-24）](https://technode.global/2026/11/24/ant-group-open-weight-lingsante-medical-ai-models/)：两款模型参数与 MIT 协议、权重分阶段上架、Afu 用户数据与视频问诊。
- [Ant open-sources LingSante-3.1-flash, a 560B medical MoE（AI Weekly，2026-11-23）](https://aiweekly.co/alerts/ant-open-sources-lingsante-31-flash-a-560b-medical-moe)：flash 配置上限 262,144 tokens 与 1M 宣称的出入、MLCR-AA 独立评分 23.3%、厂商自测成绩汇总。
- [LingSante-3.1-flash and LingSante-Pulse-1.0 deployment scale（ThreatCluster，2026-11-23）](https://threatcluster.io/cluster/lingsante-31-flash-and-lingsante-pulse-10-deployment-scale-a-9493d137)：权重 11 月 19 日上架、FP8 约 578GB、量化后约 292GB、4 张数据中心 GPU、HealthBench Pro 仅比底座高 0.37 分。

以上来源均于 2026-11-24 查阅。基准分数除 MLCR-AA 外均为厂商自测成绩，未经独立复核；部署体积与硬件需求来自第三方部署分析与官方 Quickstart。

## 核验

- 核对日期：2026-11-24
- 官方来源：BusinessWire 通稿（2026-11-23 07:10 UTC）与两份 Hugging Face 模型卡原文；参数、上下文、许可证均以模型卡与通稿为准。
- 经验/转述标注：权重 11 月 19 日上架、flash 配置上限 262,144 tokens、量化后约 292GB 与 4 张 GPU、HealthBench Pro 65.72 与 MLCR-AA 23.3%，均来自第三方报道或厂商自测，未经本文独立复核，已在正文标明出处与性质。
- 利益披露：本文无商业合作，不推荐任何医疗行为；模型输出不能替代专业医疗建议。

## 更新记录

- 2026-11-24：首发。

## 相关阅读

- [DeepSeek 完全指南：从注册到 API 与本地部署](/posts/deepseek-complete-guide-2026/)
- [Kimi 模型档案：K3 到 K3.1 Pro 全版本、价格、开源进度与国内用法](/posts/kimi-guide/)
- [GLM 模型指南](/posts/glm-guide/)
