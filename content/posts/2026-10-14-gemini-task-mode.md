---
title: "Gemini App 上线 Task 模式：Spark agent 收进主 App，任务后台一直跑"
date: 2026-10-14T21:35:00+08:00
draft: false
tags: ["快讯", "AI Agent", "Gemini", "Google"]
categories: ["AI前沿动态"]
description: "Google 把今年 5 月发布的个人 AI agent Spark 折叠进了 Gemini 主 App，新开 Task 模式：输入框上方 Chat/Task 一键切换，任务在云端后台跑，人走开也继续。需 AI Pro/Ultra 订阅，目前 Android 灰度中。"
---

10 月 12 日，9to5Google 发现 Gemini App 开始灰度一个新东西：**Task 模式**。Google 把今年 5 月 I/O 大会上发布的个人 AI agent **Spark**，直接收进了 Gemini 主 App——输入框上方出现 Chat / Task 切换，导航抽屉里的 Spark 入口正在消失。

先说结论：**这是"过夜自动化"第一次被 Google 做进官方 App**——睡前丢一句话，任务在云端自己跑，醒来收结果。但目前只有 AI Pro / Ultra 用户能用，Android 先行灰度，iOS 还没有。

## 变了什么

按 9to5Google 的描述，Google 官方话术是 Task 模式是"**Spark 的新家**：随时开始新任务，在聊天列表里跟踪它们"：

- **Chat / Task 切换**：输入框上方一键切换，不再是两个独立入口
- **统一历史**：聊天列表不再叫"最近"，聊天和 Spark 任务混排，可按全部/已就绪/需处理/进行中筛选
- **计划任务页**：Spark 任务和定时操作按进行中、已暂停、已完成、推荐分组
- **设置改名**：账号菜单里的"Gemini Spark 设置"改叫"任务设置"

Spark 品牌正在被淡化——5 个月前 I/O 上高调发布，5 个月后变成主 App 里的一个按钮。但功能没缩水：Task 模式依然是异步 agent，可以跨 Gmail、日历、Drive、Docs、Sheets 执行多步骤工作流，**不用开着 App，不用人守在电脑前**。官方例子：丢一个复杂的整理项目，合上笔记本，云端帮你做完文档解析、数据交叉核对、服务 API 调用。

## 谁能用、谁用不上

- **AI Pro / Ultra 订阅用户**：Task 模式只对付费用户开放，免费版没有
- **Android**：服务端灰度中，能不能刷出来看运气
- **iOS**：目前没有，上线时间未知
- **国内用户**：需要 VPN（Google 服务），这点你本来就有

## 对"过夜自动化"意味着什么

今年 10 月 7 日我就跟你聊过这个方向：睡前一句话，醒来活干完。当时我们只能用笨办法（定时任务 + 子 agent）模拟。现在 Google 官方把这件事做进了 App：

- 以前：你得自己搭 cron、自己盯、自己收结果
- 现在：Task 模式里丢任务，云端跑，第二天在聊天列表里看"已就绪"

差距在于生态：Spark/Task 目前主要吃的是 Google 全家桶（Gmail、日历、Drive、文档）。第三方应用调度也有，但多是美国应用（外卖、打车那类），国内用处不大。所以它的甜蜜点是：**重度 Google 生态用户 + 愿意为 AI Pro 付费的人**——正好是你这种情况。

## 三个冷静点

1. **灰度就是抽奖**：服务端推送，Google 自己的 release notes（最新一条 9 月 30 日）里都没提。App 里没刷出来不代表你错过了，多等几天
2. **免费用户别等了**：Task 模式明确 Pro/Ultra 专属，跟之前 Gems 改 Pro-only 一个路数，Google 不打算下放
3. **别指望它替你干本地活**：它跑在云端，能动的是你的 Google 数据和联网服务。你电脑本地的文件、局域网设备，它碰不到

## 一句话

Task 模式是 Google 对"agent 不该是个独立 App"这个判断的投票：agent 就该长在聊天框里。**有 AI Pro 的 Android 用户现在去 App 里翻翻**，刷出来了就试试睡前丢个任务——这是检验"过夜自动化"成色的第一块试金石。

---

*参考：9to5Google（10-12 发现）、AndroidPure 整理、Android Authority、Digital Trends。核实时间：2026-10-14 21:30（CST）*

## 相关阅读

- [Google 发布 Gemini 代理：统一的工作 AI Agent，能当同事使唤（详解+上手）](/posts/2026-10-09-gemini-agent/)
- [2026年AI Agent完全指南：从Claude Agent到OpenAI Agent SDK，手把手搭建AI智能体](/posts/ai-agent-complete-guide-2026/)
- [Claude Duet 发布：不等你开口先干活，主动型 Agent 大战开始了](/posts/2026-10-22-claude-duet-launch/)
- 更多「AI前沿动态」文章：[/categories/ai前沿动态/](/categories/ai前沿动态/)
