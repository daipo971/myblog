---
title: "DeepSeek 开源超级 Agent 原型：会自己接活干活"
date: 2026-11-02T14:30:00+08:00
description: "DeepSeek 10 月 31 日在 GitHub 开源内部同款超级 Agent 原型 dsh-superagent：盯仓库、接工单、自己干活再交 PR。两天近万星，但官方明确说它只是研究原型，普通人还用不上。"
categories: ["中国与开源模型"]
tags: ["快讯", "AI Agent", "开源模型", "DeepSeek"]
showtoc: true
---

DeepSeek 又开源了，不过这次不是模型。

10 月 31 日，DeepSeek 在 GitHub 上放出 `dsh-superagent-prototype`（简称 dsh-superagent），是把内部团队日常使用的「超级 Agent」改版后公开的研究原型，MIT 协议随便用。热度涨得很快：11 月 1 日本站第一次查时是 3,683 星，11 月 2 日发稿前再查已经 9,689 星、986 个 fork。

## 它是干什么的

一句话：一个盯着代码仓库、能自己接活的编程 Agent。

按官方 README 的说明，它以 DeepSeek Harness 组件包的形式运行，监听 GitHub（可选接飞书）：团队里有权限的人在对话里派一件活，它就自动开一个工单，在自己独立的会话和目录里把活干完，再回到原来的对话里交结果——比如直接提交一个 Pull Request。另外有一个网页面板，专门列出「需要真人来处理」的事情。

它的设计理念写得很直白：**尽量少占人的注意力**。能干活的 Agent 也能浪费整个团队的注意力，所以它只在被人叫到、或团队事先写好的规则允许时才行动；只在「必须有人拍板」或「有人能用上结果」时才开口说话。

配套文章《Exploring Super-agent Design》里还给出了更大的架构设想：一个常驻的 Router 负责从群聊、GitHub、邮件里接收和分发消息，多个互相隔离的 Worker 会话并行干活。动因很实际——一个人同时只能盯住 3 到 5 个 Agent 会话，那就干脆把「管理会话」这件事也交给系统。（Router/Worker 架构与「3 到 5 个会话」的说法来自配套文章与媒体报道。）

## 先把限定说清楚

这条新闻很容易被标题党放大，先把官方自己的提醒放在前面：

- **它只是研究原型**。README 开头明确写着：仅供参考、不是 DeepSeek 的正式产品、不适合直接用在生产环境、可能还有 bug，代码风格和工程实践也不统一。
- **公开版和内部版不完全一致**。官方说发布前做过适配改版，配套文章里讨论的部分设计属于未来方向，在这份原型里并没有实现。
- **普通用户现在用不上**。它需要一个 GitHub 仓库加 DeepSeek Harness 的配置才能跑，官方建议先审查、适配再在自己的环境里用。这不是一个下载就能玩的产品。
- 二手报道里提到的内部测试数据（约 20 个任务、中位完成时间 12.4 分钟），本站在官方材料里没有核实到出处，看看就好，别当成官方成绩。
- 别和 10 月 20 日开源的 DeepInfer 混淆：那是推理引擎，是另一回事。

## 为什么值得看一眼

第一，这是 DeepSeek 的动作从「发模型」往「发 Agent 的工作方式」延伸的信号。模型解决的是聪不聪明，这套东西解决的是 Agent 怎么融入一个团队的日常协作——派活、隔离执行、交结果、只在必要时打扰人。

第二，对开发者来说，仓库里编号 000 到 008 的设计文档（理念、领域模型、授权、执行、提示词、面板、部署、架构、扩展）是目前少见的一线团队 Agent 系统完整设计稿，就算不用这套代码，文档也值得读。

第三，对普通读者，这件事的正确打开方式是先看懂概念：Agent 到底怎么运转，看站内这篇 [AI Agent 完全指南](/posts/ai-agent-complete-guide-2026/)；想亲手体会「模型思考→调用工具→看结果→再思考」的循环，昨晚刚发的 [从零手写一个会干活的 AI Agent](/posts/build-your-own-ai-agent-tutorial/) 用半小时就能跑通一个迷你版；想看 Agent 长在手机上的产品形态，则有 [Hermes Agent 手机版公测](/posts/hermes-agent-mobile-beta/) 那条路线。

模型竞赛之外，Agent 的「组织方式」竞赛已经开始了。这次开源的，是后者的一份参考答案。

## 参考来源

- DeepSeek 官方 GitHub 仓库：[deepseek-ai/dsh-superagent-prototype](https://github.com/deepseek-ai/dsh-superagent-prototype)（README 与设计文档，含「研究原型」声明）
- 新浪财经 2026 年 11 月 1 日报道：[DeepSeek 超级智能体相关报道](https://finance.sina.cn/2026-11-01/detail-inixeyiz3146996.d.html)（Router/Worker 架构与内部测试数据的二手来源）
