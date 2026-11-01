---
title: "Hermes Agent 手机版开公测：安卓名额已满"
date: 2026-11-01T20:45:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["快讯", "AI Agent", "自动化"]
description: "Nous 的开源 Agent Hermes 官方手机版开启测试：iOS 走 TestFlight、安卓走官方分发，手机是遥控端，Agent 在自己电脑上跑。安卓名额 10 月 31 日已满；商店同名 App 全是第三方，官方警告仿冒多欺诈。"
lastmod: 2026-11-01T20:45:00+08:00
showtoc: true
---

Nous Research 的开源 AI Agent **Hermes Agent**，官方手机版开启公开测试了。官方专门做了一个页面（hermes-agent.nousresearch.com/mobile），标题就是「Hermes Mobile Beta」，可以选平台预约测试名额。先把性质说清：**这是公开测试（beta），不是应用商店正式版**——iOS 走 TestFlight 邀请，安卓走 Firebase 官方分发，应用商店里暂时还搜不到官方版。

Hermes Agent 是今年 2 月发布的开源 Agent，特点是装在你自己的电脑上运行：能执行命令、写代码、上网、记住学到的东西、按计划定时干活，GitHub 星标今年 4 月就破了 10 万，是这一年最火的开源 Agent 之一（Agent 是什么、能干什么，本站 [AI Agent 完全指南](/posts/ai-agent-complete-guide-2026/) 有系统介绍；同类工具本站也做过 [AI 自动化工具对比](/posts/ai-automation-tools-2026/)）。这次的手机版不改变这个架构，它解决的是「人不在电脑前，Agent 怎么管」的问题。

## 手机版是干什么的：遥控端

手机 App 本身不跑 Agent，它是连回你自己电脑的遥控端：

- 在手机上和自己的 Agent 聊天、派活；
- 实时看它执行的每一步；
- 它要运行命令时，在手机上点批准或拒绝；
- 换句话说，电脑在家跑长任务，你在外面用手机盯着、批着、接着派新活。

前提也写明了：你需要先有一台自己的电脑（Mac 或 Linux）把 Hermes Agent 跑起来并打开 API 服务，手机才有对象可连。没有部署过 Hermes 的人，这个手机版暂时和你没关系，它不是那种下载就能聊的聊天 App。这和 [用 n8n 搭建 AI 自动化工作流](/posts/ai-agent-workflow-guide-2026/) 那类「流程跑完就结束」的自动化也不同：Hermes 是常驻在你机器上、有记忆、能被你随时遥控的个人 Agent。

## 怎么加入：安卓名额已经满了

加入入口只有一个：官方 /mobile 页面，选 iOS 或安卓，跳到对应的测试分发渠道。两个平台现状不一样：

- **iOS**：通过 TestFlight 邀请加入，名额以官方页面实际显示为准。
- **安卓**：通过 Firebase App Distribution 分发，安装包名是 ai.nousresearch.hermes.mobile。但截至 **10 月 31 日，安卓测试名额已经被报满**——官方 GitHub 仓库里有专门的 issue，多位用户在 10 月 31 日确认：页面还显示可以预约，点进去却提示测试人数已达上限，进不去。名额什么时候补、补多少，官方还没说。

节奏上值得一提：就在一周前的 10 月 25 日，Nous 还专门发提醒说「官方移动应用尚未上架应用商店」；一周之内，口径就从「还没上架」变成了「公开测试开始」。10 月初他们宣布 9000 万美元 B 轮融资时就说过要做手机版，现在算是兑现了第一步。

## 避坑：商店里的同名 App 都不是官方的

这条最重要。**现在 App Store 和 Google Play 里能搜到的所有「Hermes」应用，没有一个是 Nous 官方的**：有的是独立开发者做的第三方客户端（有的还不错，但性质是社区作品），有的纯粹蹭名字。Nous 10 月 25 日的原话是，高度模仿 Hermes 品牌的第三方应用「通常属于欺诈」。

所以：
- 想进测试，只从官方 /mobile 页面给的链接走，不要在商店里搜名字下载；
- 任何要求你在里面填 API 密钥、订阅账号的同名 App，先默认它不是官方的；
- 另有一个 hermesapp.dev 的同名独立客户端，是其他开发者做的开源项目，也不是 Nous 官方，别混淆。

## 先说清的几件事

- **本站未实测**：编辑部没有加入这次测试，文中信息来自官方页面、官方 GitHub 仓库 issue 和官方新闻页；实际加入流程以你点开页面看到的为准。
- **正式版时间未公布**：官方只说现在是 beta，应用商店正式上架没有时间表。
- **安卓名额状态会变**：本文发稿时是已满，之后官方补名额的话以页面为准，不要拿着这篇旧文当现状。

## 参考来源

- [Nous Research 官方页面：Hermes Mobile Beta](https://hermes-agent.nousresearch.com/mobile)
- [官方 GitHub 仓库 issue：安卓测试名额已满（#147269）](https://github.com/NousResearch/hermes-agent/issues/147269)
- [Hermes Agent 官方新闻页（含 10 月 25 日「官方应用尚未上架」提醒）](https://hermes-ai.net/zh/news/hermes-agent/)
