---
title: "Qwen4-Max 正式上线：2.4 万亿参数按量计费，$1.50/$4.50——但旗舰本身不开源"
date: 2026-11-16T17:39:00+08:00
lastmod: 2026-11-16T17:39:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "国产大模型", "AI Agent", "通义千问"]
description: "阿里 11 月 16 日正式上线 Qwen4-Max：2.4 万亿参数 MoE，每 token 激活 71B，1M 上下文，按量 $1.50/$4.50。旗舰本身不开源，更小的 Qwen4 模型之后才开源；基准均为厂商自报，口径冲突。"
summary: "Qwen4-Max 今天正式上了按量 API：2.4 万亿参数、1M 上下文，$1.50/$4.50，比上一代便宜 25%，自家 Work360 任务成本降 62%。但旗舰本身不开源，等的是更小款的开源权重；Terminal-Bench 自家幻灯片上 48.5 分，还落后 Opus 5.5 和 Kimi，另一组报道却说接近榜首——两组读数先并列，结论等独立基准。"
showtoc: true
---

先说结论，也是先更正今早简报的一句话：**Qwen4-Max 今天正式上线了**——今早写的"截至今早仍无正式发布"在同一天就过时了。这是 Qwen4 家族第一个真正能用的模型：2.4 万亿参数、1M 上下文，按量 API 输入 $1.50、输出 $4.50 每百万 token。但别搞错性质：**旗舰本身不开源**，Hugging Face 上今天仍无 Qwen4 仓库，等的是更小款的开源权重。本文讲清四件事：新架构到底改了什么、价格便宜是真便宜还是口径游戏、两组冲突的基准读数怎么看、普通人三条上手路径。

![插画：机器人团队在流水线上协作，几条被点亮的金色路径穿过专家节点，象征长程智能体分工完成任务](/images/qwen4-max-launch/cover.webp)

## 1. 核心底层逻辑与原理解析

时间线先摆清：11 月 11 日 Qwen4-Max-Preview 先在 Token Plan 上开预览（模型 ID `qwen4-max-preview`）；11 月 16 日北京时间 10:01，Qwen 官方账号发文"Meet Qwen4-Max, your new AI teammate for work, creativity, and discovery!"，正式版 `qwen4-max` 上了按量 API。预览版 11 月 25 日 24:00（UTC+8）退役，之后下线。

**新架构的三个改动，都冲着"长上下文更便宜"去。** Qwen4-Max 是稀疏 MoE：2.4T 主干参数，每 token 只激活 71B，另加 328B 的 N-gram Embedding 参数。三个关键改动：

- **GDN + Qwen Sparse Attention（QSA）。** 三层 Gated DeltaNet 把历史压缩成固定大小的状态，配一个轻量索引器在微块粒度上选相关上下文——上下文 1M 的时候，注意力成本先降下来。
- **Gated Residual（GR）。** 四路并行残差分支加动态读写门，目标是信息流更强、训练更稳。
- **N-gram Embedding。** 在第二层做基于上下文的查找，给模型局部 token 模式的表示，用很少的额外算力扩容量。

训练本身也是官方叙事的一部分：2.4T 参数的训练全程 loss 曲线平稳、没有 loss spike；base 模型在知识、代码、问答、STEM 内测上，bits-per-byte 是五个检查点里最低的，比 Qwen3.8-Max-Base 低约 5–13%，激活参数还少约 25%。

**原生视觉与思考模式。** 输入支持文本、图片、视频；上下文 1M；思考默认开启（reasoning_effort 默认 high，low 与 xhigh 可选）。定位是"24/7 AI teammate"——长程 agent，不是聊天机器人。官方还推了一个"Live Delivery"模式：长任务先交付可用第一版、再迭代改进，用户随时可以介入改方向，配套的 Qwen-Live-Delivery-Plugin 正在开源——注意，这次开源的是插件，不是模型。

**官方演示挑了最能打的场景，但都是单点 showcase。** 3D 与游戏：用 Blender 做几何、材质、灯光、渲染，Unity、Unreal Engine、Godot 一句话做出可玩游戏，跑起来后按视觉反馈迭代镜头、动画与节奏。制造：在 SANF、Pacific Union 的真实产线里规划产线、设计零件、验证加工，单件工件编程人工从约 475 分钟降到 24 分钟，约 95%。金融、法律、医疗：投资研究调 90 个 MCP 工具出 Excel 与 PPT，图表与底层数据一一对应；IPO 前法律尽调把 198 份格式不一的工作底稿分进 14 个文件夹、出 86 页 6 万多字报告、每条结论带引用；重症监护复核 6 天病程、几十份化验与 1,433 张医学影像，4 条管理建议与主管医生实际医嘱逐条一致。科学演示走得最远：48 小时连续运行，筛 270 万候选分子、指挥自动化湿实验室走完 4 轮设计-合成-测试，做出数据中心芯片新型冷却剂的实物样品；NLRP3 药物发现做了 454 次工具调用、3,239 次计算评估、24 个候选分子，候选物结合亲和力约专利参照分子的 3.6 倍——候选物有专家背书，仍待湿实验室验证。这些演示证明长程 agent 循环能跑完，不证明它在你的问题上也能跑完。

## 2. 核心方案与多维对比横评

先放价格与规格对照（价格以 Model Studio 定价页为准）：

| 模型 | 参数（总/激活） | 上下文 | 输入/输出（$/百万 token） | 缓存读 | 权重 |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Qwen4-Max** | **2.4T / 71B** | **1M** | **$1.50 / $4.50** | **$0.075** | **闭源** |
| Qwen3.8-Max | 未公布 | 未核实 | $2 / $6 | $0.25 | 闭源 |
| LongCat-2.5 | 1.6T / 48B | 1M | $0.30 / $1.20（限时价） | $0.006 | MIT 开源 |

再放基准对照——**全部是厂商自报，而且口径冲突，先并列再判断**：

| 指标 | Qwen4-Max | 对照与口径 |
| :--- | :---: | :---: |
| Work360 平均任务成本 | $1.67（上一代 $4.43，-62%） | Qwen 自家基准；分数 52.69 vs 47.74 |
| Work360 token 用量 | Xhigh -24%、High -35% | 相对 Qwen3.8-Max |
| Terminal-Bench 4.0 token 用量 | -48~49% | 相对 Qwen3.8-Max |
| Terminal-Bench 4.0 分数 | 48.5（自家幻灯片） | 同幻灯片对照：Opus 5.5 59.6、Kimi K3.1 67.2 |
| 编码基准（彭博引述的报道） | 接近榜首、领先 Claude Fable 5.1 与 Kimi K3.1 Pro | 与上一行冲突，均为厂商口径 |
| LMArena WebDev | 初榜第 6、1,750 分（初步），中文模型最高 | 首个独立信号，分数仍是初步 |

怎么读这两张表：

- **便宜是真便宜。** 输入输出各降 25%（$2/$6 降到 $1.50/$4.50），缓存读降 70%（$0.25 降到 $0.075）。这是硬数字，不依赖任何基准。
- **-62% 是自家口径。** Work360 是 Qwen 自己的工作建模框架（26 个一级领域、182 个二级、721 个三级），任务成本 $4.43→$1.67 的降幅来自"更少 token + 更低单价"的组合；分数 52.69 vs 47.74 也是自家榜。方向可信，幅度别当通用结论——你的工作负载上能省多少，要自己测。
- **两组编码读数打架。** 自家幻灯片 Terminal-Bench 4.0 是 48.5，落后 Opus 5.5（59.6）与 Kimi K3.1（67.2）；彭博引述的报道却说编码基准接近榜首、领先 Fable 5.1 与 Kimi K3.1 Pro。两边都不是独立结论，写"领先"或"落后"之前，先写"按谁的口径"。等 Artificial Analysis 与 LMArena 的完整分数。LMArena WebDev 初榜第 6、1,750 分是第一个独立信号，但分数仍是初步。
- **安全数字有进步，但绝对值仍低。** Last Secure Code Bench 函数级通过率从 22.0% 升到 31.8%，三级粒度全安全的代码从 8% 升到 14.7%——翻倍是真进步，也提醒生成代码默认仍不安全，关键代码还是要审。

## 3. 手把手完整实战流程

普通人三条路，按门槛从低到高：

### 步骤一：零成本先试——Qwen Studio

Qwen Studio（chat.qwen.ai）模型选择器里已有 Qwen4-Max，登录即用，不用建 Key、不用充值。先拿它跑一个真实长任务（比如一万字资料整理，或一段多文件改代码），感受 1M 上下文与思考模式，再决定要不要上 API。QwenWork 与 Qoder 里也有。

### 步骤二：走按量 API

QwenCloud 建 Key，调 `qwen4-max`。API 兼容 OpenAI 与 Anthropic 两种格式，已有任一格式的代码，改个模型 ID 就能测。价格：新加坡国际价输入 $1.50、输出 $4.50 每百万 token，缓存读 $0.075；美国（弗吉尼亚）/法兰克福/东京/香港是 $1.413/$4.24、缓存 $0.071。思考默认开启（reasoning_effort 默认 high，low 与 xhigh 可选）。

```python
response = client.chat.completions.create(
    model="qwen4-max",  # 按量 API：输入 $1.50、输出 $4.50 每百万 token
    messages=[{"role": "user", "content": "..."}],
)
```

算一笔账：10 万 token 输入、2 万 token 输出，不命中缓存是 $0.15 + $0.09 = $0.24；同样任务 Qwen3.8-Max 要 $0.20 + $0.12 = $0.32，省 25%。显式缓存创建 $1.875（5 分钟）/$3（1 小时），缓存读 $0.075。注意按量 API 的 Key 与 Token Plan 的 Key 不通用，Token Plan 的 Key 以 `sk-sp-` 开头，不能用在按量端点上。

### 步骤三：Token Plan 里继续用（预览版用户注意）

正式版也在 Token Plan Personal 与 Team 里。预览版 `qwen4-max-preview` 只在 Token Plan 里，11 月 25 日 24:00（UTC+8）退役，之后下线——调用代码里别长期写预览版 ID。Token Plan 只供交互式使用，脚本批量、后端调用走按量 API；仅新加坡区域；个人版 Lite $6/月起（新用户 $3）、Essential $10、Standard $18、Pro $43，Credits 制不结转、目前不支持取消订阅。

## 4. 工业级避坑守则

### ⚠️ 避坑点 1：别把"Qwen4 发布"当成"Qwen4 开源"
Max 是纯托管、不开源；Hugging Face 上今天仍无 Qwen4 仓库。阿里说更小的 Qwen4 模型之后会开源，尺寸与日期都没公布。等的是更小款，不是 Max。LongCat-2.5 那种 MIT 权重故事，这次没有。

### ⚠️ 避坑点 2：两组编码基准读数冲突，别只报一组
自家幻灯片 Terminal-Bench 4.0 是 48.5，落后 Opus 5.5（59.6）与 Kimi K3.1（67.2）；彭博引述的报道说接近榜首、领先 Fable 5.1 与 Kimi K3.1 Pro。两边都不是独立结论。写"领先"或"落后"之前，先写"按谁的口径"。

### ⚠️ 避坑点 3：-62% 是自家工作负载上的成本，不是通用降价
Work360 任务成本 $4.43→$1.67 是 Qwen 自己的 26 领域工作建模，来自"更少 token + 更低单价"。硬数字是输入输出价各降 25%、缓存读降 70%。拿 -62% 去算自己账单会算错。

### ⚠️ 避坑点 4：最大输出有两个口径
Model Studio 文档写 131,072（无思考）/262,144（有思考，含思考内容）；QwenCloud 模型页写最大输出 393K。引用时注明按哪份文档，别把两个数字混着用。

### ⚠️ 避坑点 5：预览版 11 月 25 日退役
`qwen4-max-preview` 只在 Token Plan 里，11 月 25 日 24:00（UTC+8）后下线。正式版模型 ID 是 `qwen4-max`，调用代码、文档与教程里别留着预览版 ID。

### ⚠️ 避坑点 6：演示是单点 showcase，不是可靠性证明
48 小时筛出新型冷却剂、NLRP3 候选物结合力 3.6 倍、475 分钟变 24 分钟——都是官方演示的单次结果（候选药物仍待湿实验室验证）。长程 agent 能不能在你的问题上跑完，要自己拿真实任务测。

## 5. 总结与后续行动建议

一句话结论：Qwen4-Max 是 Qwen4 家族第一个真正能用的模型，便宜是真便宜（$1.50/$4.50、缓存降 70%），长程 agent 的定位也清晰；但旗舰不开源、基准口径冲突，等独立分数与更小款开源才是下半场。

行动路径就三步：今天先去 Qwen Studio 免费试 → 觉得顺手再开按量 API（10 万输入 + 2 万输出约 $0.24）→ 有集群也别等 Max 的权重，等更小款的开源消息。待观察三件事：更小 Qwen4 模型的尺寸与开源时间、Artificial Analysis 与 LMArena 的完整分数、Qwen4-Plus/Flash/27B 有无日期。

## 参考来源

- [Qwen 官方博客全文转述：2.4T 参数、任务成本降 62% 的另一面](https://dev.to/ton_thnhthy_ba110cce85/qwen4-max-is-here-a-24t-parameter-teammate-that-cuts-your-agent-bill-by-62-with-a-catch-3ek1)：Qwen 博客 "Qwen4-Max: Your New Teammate Has Arrived"（2026-11-16）全文转述
- [Qwen4-Max 发布整理：价格、规格与上手方法](https://aifirstlook.com/qwen-4/)：Model Studio 文档与定价页核对（2026-11-16）
- [Qwen4-Max GA 报道：价格与上线渠道](https://tmlnews.tech/stories/alibaba-qwen4-max-general-release-pricing/)：按量价与上线渠道（2026-11-16）
- [Qwen4-Max 上线整理：闭源与更小模型开源承诺](https://scanradar.site/news/alibaba-qwen4-max-launch-api-price-1m-context-closed-weights)：不开源、更小模型承诺（2026-11-16）
- [Qwen4-Max 使用指南：各渠道对比](https://apidog.com/blog/how-to-use-qwen-4-max/)：QwenCloud、Token Plan、QwenStudio 各渠道（2026-11-16）

## 核验记录

- 核对日期：2026-11-16。Qwen 官方博客原文未直接打开，数字经 dev.to 全文转述、aifirstlook（Model Studio 文档与定价页）与多家追踪站交叉一致；价格以 Model Studio 定价页为准；基准均为厂商自报，Terminal-Bench 4.0 两组读数冲突；Hugging Face 无 Qwen4 仓库为今早实测；预览版 11 月 25 日退役以阿里官方文档为准。

## 相关阅读

- [Qwen4-Max 预览上线：百万上下文、只开 15 天](/posts/qwen4-max-preview-launch/)：11 月 11 日预览版的 Token Plan 与退役时间。
- [美团 LongCat-2.5 权重开源：1.6 万亿参数能下载，3.56TB 却拦住大多数人](/posts/longcat-2-5-open-weights/)：同一天发布的国产开源权重对照——MIT 可商用。
- [Kimi K3.1 Pro 发布：编程跑分超 GPT-6，11 月 4 日开源全部权重](/posts/2026-10-24-kimi-k3-1-pro-launch/)：基准表里的对照模型，权重已开源。
- [中国大模型 API 价格表](/posts/china-llm-api-pricing/)：8 家旗舰模型输入输出价、缓存价对照，每月更新。
- 更多中国与开源模型见 [中国与开源模型](/categories/中国与开源模型/)。
