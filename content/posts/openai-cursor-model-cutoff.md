---
title: "Cursor用户注意：11月12日起GPT模型可能停用"
date: 2026-11-08T12:25:00+08:00
lastmod: 2026-11-08T12:25:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["快讯", "行业动态", "Cursor", "OpenAI"]
description: "OpenAI 已正式通知：拟议 11 月 12 日起停止向 Cursor 供应模型，日期尚未最终确认。受影响的只是 Cursor 里约 5% 的 GPT 流量，Claude、Gemini 不受影响，本文说清来龙去脉和现在该做的切换动作。"
showtoc: true
---

先给结论：**如果你在 Cursor 里用 GPT 模型写代码，最晚从 11 月 12 日起，它可能就选不了了。**OpenAI 已正式通知 SpaceX：将终止向 Cursor 供应 OpenAI 模型的合同，**拟议**的停供日期是 2026 年 11 月 12 日。注意「拟议」两个字——OpenAI 自己的帮助页面写明，最终终止日期要等双方确认后才公布，目前两家还在谈，所以这不是板上钉钉的定局。但信号已经很明确，而且新款 GPT 模型事实上已经断供：Cursor 的模型列表停在 GPT-5.6 一代，10 月底发布的 GPT-6 全系一个都没上。正在用 Cursor 的读者不用慌——按 Cursor CEO 的说法，OpenAI 模型只占 Cursor 用户流量约 5%，Claude、Gemini、Grok 全部不受影响——但默认模型是 GPT 的人，现在就该动手切换，别等到 12 号当天被打个措手不及。

![插画：代码编辑器里的模型选择菜单中，几个选项正在变灰消失](/images/openai-cursor-model-cutoff/cover.webp)

## 发生了什么：收购触发了合同里的「换东家」条款

时间线很清楚：

- **8 月 14 日**：SpaceX 完成对 Cursor 母公司 Anysphere 的收购，交易规模约 600 亿美元。
- **8 月 28 日**：OpenAI 发布官方声明，称已通知 SpaceX，拟终止向 Cursor 供应模型的合同，停供日期**提议**为 11 月 12 日，并给了合同允许的最长通知期。
- OpenAI 给出的理由不是价格，是信任。官方原文写道：「我们无法确信 SpaceX 会在我们的服务条款内使用我们的技术，这是基于马斯克旗下公司以往违反合同的经历。」声明还提到，马斯克今年早些时候在宣誓作证时承认 xAI 违反过 OpenAI 的服务条款。OpenAI 与 Cursor 的定制合同里有一条「控制权变更」条款：Cursor 换了东家，OpenAI 有权在一个有限的时间窗口内取消合同——它用的正是这一条。
- 声明同时确认：**在合同结束前，OpenAI 不再向 Cursor 提供任何未来新模型**。所以这不是「12 号才开始」的事，断供其实已经以「不上新」的方式开始了。

这也是为什么本站之前的 [Cursor 使用指南](/posts/cursor-programming-tools/) 里还能选到的 GPT 阵容，和今天你打开 Cursor 看到的已经不是一回事：新款进不来，存量在倒计时。

## 先把最关键的一点说清：日期还没定死

这条新闻最容易被传歪的就是日期，所以单独强调：

- OpenAI 官方声明用的是 **proposed shutoff date（拟议停供日期）**，不是「将于 11 月 12 日终止」的确定语气。
- OpenAI 的帮助页面进一步说明：过渡期提议到 11 月 12 日，期间现有模型继续供应；**Cursor 也可能选择提前结束**；正式终止日期「将在双方确认后第一时间公布」——截至本文发稿（11 月 8 日），这个确认还没有出现。
- Cursor CEO Michael Truell 在声明当晚公开回应：OpenAI 模型约占 Cursor 用户流量的 5%，「我们正在与 OpenAI 团队沟通，争取解决此事」。11 月 6–7 日多家媒体因日期临近重新报道此事，口径仍是「谈判中、时间表未最终敲定」。

所以正确的读法是：**方向已定（合同要终止、新模型已停供），日子未定（可能谈出转机，也可能如期甚至提前）**。按最坏情况做准备，按最好情况等结果，这是普通用户该有的姿势。后续有确认消息，本文会更新，站内动态也可以在 [AI工具实测](/categories/ai工具实测/) 中心页跟踪。

## 对普通用户意味着什么

- **会消失的**：Cursor 官方供应的 GPT 系列模型（目前是 GPT-5.6 Sol、Terra、Luna 等）。合同终止后，这些会从模型列表里撤下。
- **完全不受影响的**：Claude（Anthropic 还承诺给 Cursor 增加算力供应）、Gemini、Grok、Cursor 自家的 Composer，以及 Kimi、GLM 等国产模型。写代码的主力体验不会塌。
- **非 GPT 不可的还有一条官方给的路**：按 OpenAI 的过渡指引，可以在 Cursor 的 Chat 和 Agent 里填**你自己的 OpenAI API 密钥**继续调用 GPT，或使用 Codex 扩展在 Cursor 里干活。注意自带密钥只覆盖本地 Chat 和 Agent，Tab 补全、云端 Agent 这些用的是 Cursor 官方供应的模型，换不了。
- **要不要换工具**：只为 GPT 订 Cursor 的人，可以对照本站的 [ChatGPT vs Claude vs Cursor 深度对比](/posts/chatgpt-vs-claude-vs-cursor-guide/) 重新算一笔账；主力本来就是 Claude 的，这条新闻对你基本无感。

## 现在就做：三步切换清单

1. **查默认模型**：打开 Cursor 设置，看 Chat 和 Agent 的默认模型是不是 GPT 系列。是的，往下走；是 Claude 的，到此为止，不用管。
2. **切主力模型**：把默认模型换成 Claude 或 Gemini，先跑一两天真实任务适应手感，别等停供当天被迫切换、连对比的机会都没有。
3. **留好后路**：手头项目强依赖某个 GPT 模型行为的，趁现在把关键提示词和工作流在 Claude 上验一遍；确实离不开 GPT 的，按上面说的自带 API 密钥方案提前配好、测通。

## 参考来源

- [OpenAI 官方声明：Our decision on Cursor following its acquisition by SpaceX](https://openai.com/index/our-decision-on-cursor-following-its-acquisition-by-spacex/)：拟议 11 月 12 日停供、不再提供未来模型、理由原文（查阅于 2026-11-08）
- [OpenAI to Cut Off Cursor's Model Access Nov. 12（evermx 案例整理）](https://evermx.com/case/openai-cursor-model-cutoff)：CNBC 等报道汇总，含 Cursor CEO「约 5% 流量、正在沟通」的回应（查阅于 2026-11-08）
- [OpenAI plans to cut Cursor off on November 12（enjoy.dev 备忘录）](https://enjoy.dev/blog/cursor-openai-november-12/)：帮助页面「日期待双方确认、Cursor 可能提前结束」的口径，以及自带密钥等过渡方案（查阅于 2026-11-08）

## 更新记录

- 2026-11-08：首发。11 月 12 日为 OpenAI 拟议日期、尚未经双方确认；如有正式终止日期或谈判结果，会更新本文。
