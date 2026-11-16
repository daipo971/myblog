---
title: "OpenAI 解散机器人团队：通用模型接手"
date: 2026-11-14T21:10:00+08:00
lastmod: 2026-11-16T09:16:47+08:00
draft: false
categories: ["AI工具实测"]
tags: ["快讯", "行业动态", "OpenAI"]
description: "Fortune 11 月 13 日独家、OpenAI 发言人证实：独立机器人团队解散，研究并入主研究团队、硬件并入 Applied 部门。理由是 GPT-6 Astra 等通用模型已能直接开机器人，人形演示仍以 2027 年为目标。"
summary: "OpenAI 第二次解散机器人团队：研究并入主研究团队，应用与硬件并入 Applied 部门。理由是 GPT-6 Astra 这类通用模型已经能直接开机器人，人形演示仍以2027年为目标。本文讲清分流去向、时间线，以及 74.8% 的模拟基准到底意味着什么。"
showtoc: true
---

先说结论：**OpenAI 解散了独立的机器人团队**。Fortune 11 月 13 日独家报道、OpenAI 发言人证实：研究人员并入首席研究官 Mark Chen 的主研究团队，应用机器人与硬件团队并入总裁 Greg Brockman 的 Applied 部门。理由很直接——GPT-6 Astra 这类通用模型已经能直接开机器人，不必再养一个专门做「机器人大脑」的团队。这是 OpenAI 第二次解散机器人团队，但发言人强调机器人仍是长期愿景，人形机器人演示仍以 2027 年为目标，不是放弃。

![插画：人形机器人身影逐渐化作神经网络节点与数据流，象征通用模型接手机器人控制](/images/openai-disbands-robotics-team/cover.webp)

## 发生了什么

| 项目 | 内容 |
| --- | --- |
| 报道方 | Fortune（11 月 13 日独家），OpenAI 发言人证实 |
| 变动 | 独立机器人团队解散 |
| 人员去向 | 研究团队 → 首席研究官 Mark Chen 的主研究团队；应用机器人与硬件团队 → 总裁 Greg Brockman 的 Applied 部门 |
| 官方理由 | GPT-6 Astra 等通用模型已能直接用于机器人控制 |
| 后续目标 | 人形机器人演示仍以 2027 年为目标 |

## 为什么是现在：一个模拟基准改写了路线

触发这次改组的数字，来自 NVIDIA 研究团队 10 月 14 日的一项研究。研究人员把 GPT-6 Astra 当作机器人控制器，放到模拟操作基准 RoboLab-120 上测试——没有做任何针对机器人的专门训练，成功率 74.8%，对照组里表现最好的专用机器人模型只有 51.0%。

这个对比要写准：**74.8% 是模拟成绩，不是实体机器人的实测**。RoboLab-120 是模拟的抓取放置基准，测的是模型在模拟环境里完成操作任务的能力，不能直接等同于真机表现。Fortune 报道里引用的成本也不低：每次尝试约 36.4 美元 token 费用、每次模型调用约 18.56 秒——离即时控制还有距离。

但方向已经很清楚：OpenAI 内部原先假设要靠视频模型打底再做机器人，后来发现通用前沿模型直接就能用，专门团队的边际价值就没了。

## 不是第一次：OpenAI 的机器人团队来来去去

这是 OpenAI 第二次关掉机器人团队，时间线值得写下来：

- **2020 年**：OpenAI 关掉第一代机器人团队，当时共同创办人 Wojciech Zaremba 给出的理由是机器人数据太少，换条路更划算。
- **2024 年**：重建独立机器人团队，并宣布与 Figure 合作开发人形机器人模型。
- **2026 年 11 月 13 日**：再度解散，团队并入主研究团队与 Applied 部门。

两次解散的理由正好相反：第一次是「数据不够、做不动」，这次是「通用模型已经够用、不必单独做」。同一批人没有离开公司，只是换了汇报线——这也是发言人强调「加速、不是收缩」的原因。

## 边界要说清

- **没有官方博客**：OpenAI 自己没有为这次改组发公告，也没有公布受影响人数，所有细节都来自 Fortune 的报道与发言人回应。
- **不是放弃机器人**：发言人向 Fortune 表示，机器人仍是公司长期愿景的一部分，人形机器人演示仍以 2027 年为目标。
- **财务数字是 Fortune 口径**：同篇报道称 OpenAI 上季营运亏损 109 亿美元、可能 2027 年初 IPO——这是 Fortune 的说法，OpenAI 未在本次回应中确认。

## 对普通用户意味着什么

- **短期没有产品变化**：这是组织调整，没有新产品、也没有产品下线。普通用户今天打开 ChatGPT 不会看到任何不同。
- **长期看，机器人可能来得更快、也更「通用」**：如果通用模型真的能直接开机器人，人形机器人的门槛就从「专门训练」变成「模型够不够强」。2027 年的人形演示是下一个验证点。
- **别把模拟成绩当实机成绩**：74.8% 对 51.0% 听起来差距很大，但那是模拟环境、且成本与延迟都还很高。写给读者时要留这个保留。

## 国内用户注意

这次改组对国内用户没有直接影响：没有产品上下线、没有服务范围变化，ChatGPT 与相关服务的国内使用方式不变。本文依据 Fortune 独家报道的二次整理（查阅于 2026-11-14），Fortune 原文为付费独家，细节来自授权引述的整理报道；OpenAI 未发布自己的公告，国内可用性未变。

## 参考来源

- [ExplainX：OpenAI Disbands Robotics Team: GPT-6 Astra Bet](https://explainx.ai/blog/openai-disbands-robotics-team-gpt-6-astra-robots-fortune-2026)：Fortune 独家内容整理、人员去向、RoboLab-120 数据（查阅于 2026-11-14）
- [Dev.to：OpenAI Disbanded Its Robotics Team. GPT-6 Astra Is the Robot Now](https://dev.to/paullovelace/openai-disbanded-its-robotics-team-gpt-6-astra-is-the-robot-now-3678)：改组细节、模拟基准说明（查阅于 2026-11-14）
- [PakTechStan：OpenAI Disbands Its Standalone Robotics Team](https://paktechstan.com/openai-disbands-its-standalone-robotics-team-betting-gpt-6-astra-can-run-robots-on-its-own)：时间线、2027 年演示目标（查阅于 2026-11-14）

## 核验记录

- 核对日期：2026-11-14。改组事实与人员去向以 Fortune 报道（经二次整理交叉确认）为准；OpenAI 未发布官方公告、未公布受影响人数。
- 74.8% 对 51.0% 是 NVIDIA 研究的模拟基准 RoboLab-120 成绩，不是实体机器人实测；每次尝试成本与延迟为研究报道数据。

## 相关阅读

- [OpenAI GPT-6 Cyber 发布：专攻网络安全](/posts/gpt-6-cyber-launch/)：OpenAI 11 月初发布的安全向模型。
- [智元 GO-3 Preview：具身基座模型年底开源](/posts/agibot-go-3-preview-launch/)：国内具身智能的最新进展。
- [OpenAI 又发新模型 GPT-6.1 Terra：不拼最强，拼每干一件事花多少钱](/posts/2026-10-27-gpt-6-1-terra-launch/)：OpenAI 上一款模型发布。
- 更多工具实测见 [AI工具实测](/categories/ai工具实测/)。
