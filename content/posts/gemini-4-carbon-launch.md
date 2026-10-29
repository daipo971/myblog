---
title: "谷歌 Gemini 4 Carbon 发布：专攻网络安全"
date: 2026-10-29T10:20:00+08:00
lastmod: 2026-10-29T10:20:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "Google"]
description: "谷歌昨天发布前沿模型 Gemini 4 Carbon，主攻网络安全：找漏洞、利用、打补丁都是官方口径的 SOTA，安全代码生成成功率是 Argon 的两倍多。本文讲清它强在哪、先给谁用、定价多少，以及国内能不能用。"
showtoc: true
---

**一句话结论：** 谷歌昨天（2026 年 10 月 28 日）发布前沿模型 Gemini 4 Carbon，Gemini 4 家族的第二个成员，主攻网络安全和长程工程任务，综合基准登顶。但普通用户现在还用不上：本周先给一部分网络安全防御者，开发者、企业和消费者要等下一阶段。

![谷歌 Gemini 4 Carbon 发布封面图](/images/gemini-4-carbon-launch/cover.webp)

## 强在哪

Carbon 是在两周前发布的 Argon 基础上推出的，谷歌称之为「最强的网络安全与长程能力模型」。官方给出的成绩：

- **找漏洞**：SEC-bench Pro 88.2%，找复杂软件系统弱点的基准；
- **利用漏洞**：ExploitGym 54.8%，验证漏洞可利用性的基准；
- **打补丁**：CWE-bench 71.0%，根因修复基准；
- **安全代码**：内部基准上，生成安全代码的成功率是 Argon 的两倍多；谷歌 Chrome 团队称，Carbon 生成高质量补丁的表现比另一家大厂的前沿模型高 10 倍以上；
- **长程任务**：内部团队让它连续跑几天，处理大代码库里的多步骤工程任务，中间走死胡同也能接着做下去；
- **综合榜**：Artificial Analysis Intelligence Index v5.0 第 1 名，59 分，Argon 是 50 分；
- **真人投票榜**：Arena 上 Text Arena 第 1（1528 分）、Agent Arena 第 2、WebDev 第 4，三个榜单都进了帕累托前沿。

## 也不是全方位第一

先泼一盆冷水，免得只看标题以为它什么都最强：

- 上面三个安全基准的成绩，是在**无护栏条件**下测出来的，不是日常使用状态；
- 据第三方测试报道，在事实性知识测试里，Carbon 的幻觉率比 Argon 高（约 4% 升到约 11%）；
- 个别专业任务和单项工程测试上，仍有对手排在它前面。

也就是说，Carbon 是「网络安全和长程工程」这个方向上的专长生，不是全科第一。

## 先给谁用、多少钱

谷歌这次是分阶段、有意放慢的 rollout：

- **本周起**：先给一部分网络安全防御者；
- **随后**：经 Fairwind 计划逐步扩大到更多受信任伙伴；
- **再之后**：收集反馈、迭代护栏后，才向开发者、企业和消费者开放，官方说法是「尽快」；
- 谷歌还提到，正在参与美国政府的自愿发布前测试流程。

定价和 Argon 的介绍价一致：**输入 2 美元 / 百万 token，输出 10 美元 / 百万 token，缓存输入打 95 折**。注意这是介绍价，介绍期结束后涨到输入 4 美元、输出 20 美元，官方没说介绍期到什么时候结束。

## 国内能不能用

官方公告没有给出国家和地区名单，当前又是受限的分阶段开放，普通用户和国内可用性目前都未证实。本文不写「国内能用」，也不写「免费试用」，等开放范围扩大后再更新。

## 参考来源

- [Google 官方博客：Introducing Gemini 4 Carbon（英文）](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-carbon/)
- [路透社：Google launches Gemini 4 Carbon AI model with cybersecurity focus（英文）](https://www.reuters.com/technology/google-launches-gemini-4-carbon-ai-model-with-cybersecurity-focus-2026-10-28/)

## 更新记录

- 2026-10-29：首发。

## 相关阅读

- [AI前沿动态](/categories/ai前沿动态/)：本分类全部文章。
- [Gemini 代理：统一的工作 AI Agent](/posts/2026-10-09-gemini-agent/)
- [Gemini App 上线 Task 模式](/posts/2026-10-14-gemini-task-mode/)
