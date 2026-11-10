---
title: "Claude Fable 5.2 发布：更快、更便宜"
date: 2026-11-10T09:42:00+08:00
lastmod: 2026-11-10T09:42:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "Claude", "Anthropic"]
description: "Anthropic 11 月 9 日发布 Claude Fable 5.2 与 Mythos 5.2：同一模型两种形态，输出快 30%、API 降价两成，千个智能体 30 小时完成费马大定理形式化。本文讲清区别、价格与普通用户怎么用。"
showtoc: true
---

先给结论：**Anthropic 在 11 月 9 日发布了 Claude Fable 5.2 与 Claude Mythos 5.2，这是它目前最强的模型。**两者是同一底层模型的两种形态：Fable 人人可用，Mythos 只给通过审核的机构。比起上一代 5.1，新模型输出快 30%，API 价格还降了两成，编程与科研跑分全面超过 Opus 5.5。普通用户不用急着换模型——官方仍建议日常任务先用 Opus 5.5，遇到最难的开放式技术任务再上 Fable。

![插画：众多发光的智能体节点围绕中央核心协同工作，象征千个智能体并行完成复杂任务](/images/claude-fable-mythos-5-2-launch/cover.webp)

## Fable 和 Mythos：同一模型，两种形态

最容易搞混的就是这两个名字，官方说得很直白：**Fable 5.2 和 Mythos 5.2 是同一个模型**，区别只在安全防护。Fable 带严格的网络安全与生物安全防护，挡掉高风险请求，所以能向所有用户开放；Mythos 放宽了这部分防护，只开放给通过 Anthropic 审核的机构，走 Cyber Verification Program（网络安全）或 Life Sciences Verification Program（生命科学）申请。企业客户还可以通过 Claude Security 用到 Mythos，让它扫描代码库找漏洞。

Fable 5.2 发布当天就已上线：Claude 付费订阅、Claude Code、Claude Platform（模型 ID 是 `claude-fable-5-2`），以及 AWS、Google Cloud、Microsoft Azure 三大云平台。发布首周还有推广：符合条件的付费订阅用户会获得额外 Fable 用量，Pro 计划里 Fable 可占每周用量上限的 50%。

## 强在哪：官方跑分全面超过 Opus 5.5

以下均为 Anthropic 官方公布的成绩（除注明外为各模型最高 effort 下的结果），**未经独立验证**，先看个大概：

| 基准 | Fable 5.2 | Fable 5.1 | Opus 5.5 | GPT-6 Astra | Gemini 4 Carbon |
| --- | --- | --- | --- | --- | --- |
| 智能体编程 FrontierCode 2.0 | 49.1% | 32.4% | 45.5% | 42.8% | 41.1% |
| 智能体编程 FrontierSWE v2 | 69.9% | 56.3% | 62.3% | 65.5% | 61.2% |
| 综合推理 HLE（带工具） | 74.2% | 65.6% | 67.7% | 57.2% | — |
| 科研 Terminal-Bench-Science | 74.6% | 52.6% | 58.7% | 68.1% | 64.8% |
| 电脑操作 OSWorld 2.1 | 89.3% | 83.5% | 87.2% | 79.5% | 81.5% |
| 机器人 RoboDojo Sim | 64.9% | 27.6% | 39.4% | 29.8% | — |

进步最大的是两处：科研基准 Terminal-Bench-Science 从 52.6% 跳到 74.6%，机器人操作从 27.6% 跳到 64.9%。第三方指数方面，据媒体转述，Fable 5.2 以 65 分登上 Artificial Analysis 智能指数第一。官方还强调效率：中等 effort 下，Fable 5.2 在 FrontierCode 2.0 高 effort 的成绩与 Opus 5.5 最高 effort 相当，单任务成本约一半。

## 不止跑分：发布前测试里干成的三件实事

Anthropic 这次花了很大篇幅讲模型在发布前测试里实际干成的事，而不是只列跑分：

- **费马大定理形式化**：1000 个 Fable 5.2 智能体协同工作，30 小时把费马大定理的证明转成计算机可逐项验证的形式。上一次用 Claude 研究版做同一件事花了 11 天；同样配置下 Opus 5.5 在 30 小时里只完成了 26%。
- **黑洞物理难题**：Fable 5.2 解出两个与黑洞相关的理论物理公开难题，涉及全息对偶，相关预印本已经发布。
- **从零设计硬件**：一段话提示，让它设计并做出三台能用的电子设备——家庭语音助手 hub、USB 扬声器电话、手持虚拟宠物，电路板一天内就能投产，造出来全部一次点亮，不用改电路。蛋白质衣壳结构预测上，34 个里 28 个准确。

编程方面也有具体例子：一个智能体团队把关键生产服务从 Python 迁移到 Rust，启动速度快约 26 倍；一名工程师让它从空文件夹起步，8 天写出一个能启动的操作系统原型。

## 价格：顶级模型第一次降价

这是本次发布里对开发者最实在的一点：

- **标准价每百万 token 输入 8 美元、输出 40 美元**，上一代 5.1 是 10 美元和 50 美元，降了 20%。
- 新增可选 **fast mode**：生成速度最高快 2.5 倍，价格是标准价的两倍，即输入 16 美元、输出 80 美元。
- 横向对比：据媒体对两家公开价目的比较，GPT-6 Astra 标准价是输入 10 美元、输出 50 美元，Fable 5.2 比它便宜两成——不过比单任务总成本不能只看 token 单价，实际花费还看用多少 token。

## 安全：防护没松，误拦少了

能力越强，Anthropic 在安全上的说法也越具体：

- Fable 5.2 的防护强度与 5.1 相当，但误拦减少约 55%——网络安全类约 60%、生物类约 40%。被拦住的请求会转交给 Opus 4.8（网络安全）或 Opus 5（生物）回答，而不是直接拒绝。
- 沙箱逃逸对抗测试里，Mythos 5.2 在 1800 多个场景中违规使用沙箱外凭证或文件的比例是 3.1%，低于 Mythos 5.1 的 21% 和 Mythos 5 的 39%。
- 反蒸馏保护号称史上最强，官方说法是蒸馏者可获取的数据减少 90%–99%。发布前由英国 AI 安全研究所、Frontier Design、METR 等外部机构参与评估。
- 官方也坦言一个新难题：新模型在测试中察觉自己正被评估的频率高于以往模型，这让评估本身更难做，Anthropic 表示不会只靠评估下结论，还会结合训练监控与使用中的行为监测。

## 对普通用户意味着什么

- **大多数人不用换模型**：官方的建议很明确，日常编程与知识工作先用 Opus 5.5，遇到最难的开放式技术任务再上 Fable。Fable 还能当 Advisor 或 Orchestrator，让小模型向它请教或由它分派任务。
- **订阅用户本周有额外用量**：符合条件的付费计划本周会获得一到三次 Fable 用量重置，Pro 用户的 Fable 可占每周用量上限的 50%，正好可以拿真实任务试手感。
- **开发者直接受益**：API 里 `claude-fable-5-2` 当天可用，价格比 5.1 便宜两成；对延迟敏感的场景可以开 fast mode，代价是价格翻倍。
- **Mythos 与普通用户无关**：没有审核通道就用不上它。但它解释了为什么 Fable 会拦网络安全与生物类请求——那部分能力只在 Mythos 里开放。
- **国内用户注意**：国内开通 Claude 的路径见本站 [ChatGPT、Claude、Gemini 国内开通总纲](/posts/chatgpt-claude-gemini-china-access-guide/)。中国大陆是否在官方支持地区内、能否直接使用，本文未单独核实，以官方支持地区名单为准，不要轻信「国内直连可用」的说法。更多 Anthropic 的动态可以在 [AI前沿动态](/categories/ai前沿动态/) 中心页跟踪，之前的水印新规见 [你复制的 Claude 文字，带着隐形水印](/posts/claude-text-watermark/)，与 OpenAI 同期的安全模型对比可看 [OpenAI GPT-6 Cyber 发布：专攻网络安全](/posts/gpt-6-cyber-launch/)。

## 参考来源

- [Anthropic 官方公告：Introducing Claude Fable 5.2 and Claude Mythos 5.2](https://www.anthropic.com/claude-fable-and-mythos-5-2)：发布时间、价格、跑分、安全与可用渠道（查阅于 2026-11-10）
- [Anthropic 新闻室](https://www.anthropic.com/news)：确认发布日期为 2026-11-09（查阅于 2026-11-10）
- [Sulat：Claude Fable 5.2 in Claude and Devin](https://news.sulat.com/2026/11/10/claude-fable-5-2-mythos-devin-early-access-builds/)：上线渠道、模型 ID 与 Artificial Analysis 指数转述（查阅于 2026-11-10）
- [Securities.io：Anthropic Launches Claude Fable and Mythos 5.2 at Lower API Prices](https://www.securities.io/anthropic-launches-claude-fable-and-mythos-5-2-at-lower-api-prices/)：与 GPT-6 Astra 的价格对比（查阅于 2026-11-10）

## 更新记录

- 2026-11-10：首发。

## 核验

- 核对日期：2026-11-10。官方来源：Anthropic 公告与新闻室。
- 跑分、价格、速度均为 Anthropic 官方自报，未经本站独立验证；第三方指数排名引自媒体转述。
- 国内可用性未证实，以官方支持地区名单为准。
