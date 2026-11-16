---
title: "Cursor 遭供应链攻击：毒扩展套件进市场"
date: 2026-11-14T21:10:00+08:00
lastmod: 2026-11-16T09:16:47+08:00
draft: false
categories: ["AI工具实测"]
tags: ["快讯", "AI安全", "行业动态", "Cursor"]
description: "Cursor 11 月 13 日公布调查：攻击者用 Fireworks AI 外泄的密钥，10 月 29 日把带后门的 Claude Code 2.1.312／2.1.313 放上市场缓存，11 小时内最多 5,000 人可能收到。"
summary: "10月29日，带后门的 Claude Code 扩展套件出现在 Cursor 官方市场缓存里，11小时内最多5000人可能收到。本文讲清整条攻击链、谁该检查，以及为什么只卸载可能不够。"
showtoc: true
---

先说结论：**Cursor 在 11 月 13 日公布完整调查结果，10 月 29 日出现在官方扩展套件市场的带后门 Claude Code 扩展套件，是一次供应链攻击**。攻击者先用 Fireworks AI 外泄的一枚密钥偷到未涂销的凭证，再把篡改过的 `Anthropic.claude-code` 2.1.312／2.1.313 放上 Cursor 市场的缓存，约 11 小时后下架，最多 5,000 人可能收到。Anthropic 没有发布这两个版本，这也不是 Claude Code 本身的漏洞。如果你 10 月 29 日在 Cursor 市场装过或更新过这两个版本，照 Cursor 安全公告检查——只卸载可能不够。

![插画：代码编辑器窗口前，一个带警告标志的扩展套件图示，象征市场缓存被植入篡改版本](/images/cursor-security-incident-fireworks/cover.webp)

## 发生了什么

| 项目 | 内容 |
| --- | --- |
| 公布方 | Cursor（Anysphere） |
| 公布时间 | 2026 年 11 月 13 日（完整事后报告） |
| 事件时间 | 2026 年 10 月 29 日（毒扩展套件上架） |
| 篡改版本 | `Anthropic.claude-code` 2.1.312／2.1.313（Windows 与 macOS） |
| 暴露窗口 | 约 11 小时（美西时间 10 月 29 日 2:27–13:35） |
| 影响人数 | 最多 5,000 名索取该缓存版本的用户可能收到 |
| 攻击起点 | Cursor 发给 Fireworks AI 的存取密钥遭外泄 |

## 攻击链是怎么走的

Cursor 的调查把整条链拼了出来，一共五步：

1. **起点在供应商**。攻击者拿到一枚 Cursor 发给 Fireworks AI（训练与推理供应商）的存取密钥。按 Cursor 的说法，这枚密钥是「被 Fireworks 外泄的」，攻击者用它复制了一个唯读共享存储桶里的资料——主要是 2025 年、非 Privacy Mode 会话的编码 agent 记录，Cursor 原本允许用这些记录做模型训练。
2. **记录里有没涂销的凭证**。少数记录含有未经涂销的凭证，不到 0.01% 的客户有 API 凭证外泄；非 Privacy Mode 用户的 agent 记录外泄比例不到 0.05%。攻击者拿这些凭证进入 Cursor 的部分 SaaS 工具，进一步接触到非生产环境的旧源代码库、客服资料与邮件对话、产品用量数据，以及用户曾寄给客服团队的凭证。
3. **毒扩展套件上架**。10 月 29 日，攻击者用偷来的凭证，把篡改过的 Claude Code 扩展套件直接放到 Cursor VS Code 扩展套件市场的缓存上。据安全媒体的技术分析，篡改版本会在扩展套件载入时执行注入的代码，不需要先开启 Claude 对话。
4. **通知与清理**。10 月 30 日，Cursor 在博客与 X 发布安全公告，附上入侵指标（IOC）、修复步骤与检查脚本，并开始通过应用内通知与邮件联系受影响用户与团队管理员；凭证外泄的团队会收到一份要轮换的密钥清单。
5. **事件已受控**。Cursor 认为事件已经受控，最后一次观测到的攻击者活动是 11 月 1 日，且已被挡下。推理流量已全部移出 Fireworks，发给 Fireworks 的密钥已停用，相关数据集的存取也已切断。

## 三件事要先说清

这次事件很容易被写错，先把三个关键定性写清楚：

- **Anthropic 没有发布这两个版本**。2.1.312／2.1.313 是攻击者冒用 Anthropic 官方账号名义放上缓存的，Anthropic 自己的系统没有被入侵。
- **不是 Claude Code 本身的漏洞**。问题出在 Cursor 市场的缓存与被偷的凭证，不在 Claude Code 的代码。
- **市场源头是干净的**。上游市场 Open VSX 从来没有托管过恶意软件，毒版本只出现在 Cursor 的缓存里。Cursor 已下线并重建整个市场，验证过其他扩展套件都是真的。

没受影响的部分，Cursor 也列得很细：Privacy Mode 用户的提示词与代码、正在传输的即时流量、生产系统、Cursor 应用程序与官方更新、客户的代码仓库、发布签名密钥，都不在这次事件里。Cursor 的正式更新是从另一套代码托管系统发布的，攻击者没有碰到。

## 10 月 29 日装过这两个版本，该怎么办

如果你是 Cursor 用户，先对照两个条件：**10 月 29 日当天、在 Cursor 的 VS Code 扩展套件市场里安装或更新到 `Anthropic.claude-code` 2.1.312 或 2.1.313**。两个都符合，就按 Cursor 10 月 30 日安全公告的步骤检查与清理。Cursor 官方特别提醒：**只卸载扩展套件可能不够**——公告附了检查脚本，照着跑一遍再确认。

没收到 Cursor 通知的用户，资料不在外泄的记录里，不必额外动作。已经收到通知的，按通知里列的项目轮换密钥。

## 同一起外泄，也波及 Notion

值得顺带一提的是，同一波 Fireworks 外泄也影响了 Notion。据报道，Notion 证实部分 Notion AI 对话记录外泄，涉及不到 1% 的工作区，多数记录未标注作者与工作区、且不含工具调用结果。Notion 已直接联系受影响客户，没收到通知就不必动作；如果收到了，把曾贴进 Notion AI 的密码与密钥轮换一遍。这条来自二次整理，未读到 Notion 公告原文，写在这里是提醒同一供应商外泄的波及面不只一家。

## 对普通用户意味着什么

- **信任链比代码更脆弱**：这次没有任何产品本身被攻破，破的是「供应商密钥 → 共享存储桶 → 市场缓存」这条信任链。一把外泄的密钥，最终变成 5,000 人可能收到的毒扩展套件。
- **市场缓存也是攻击面**：恶意软件不一定要混进上游市场，放在缓存里就能发出去。Cursor 事后重建了整个市场并加强检查，其他用类似架构的编辑器市场也会被拿来对照。
- **大多数人不用慌**：影响范围很小（不到 0.05% 用户的记录、最多 5,000 次毒版本发送），且事件已受控。关键是 10 月 29 日那个窗口期有没有装到那两个版本。

## 国内用户注意

Cursor 在国内有不少用户，这次事件不分地区——只要 10 月 29 日在 Cursor 市场里装过那两个版本，就在检查范围内。Cursor 的安全公告与检查脚本在官网公开，照着做即可。本文依据 Cursor 官方公告与公开报道整理（查阅于 2026-11-14），没有亲自测试，国内可用性未变。

## 参考来源

- [Cursor 官方公告：An update on our recent security incident](https://cursor.com/blog/security-incident-update)：攻击链、影响范围、已采取措施（查阅于 2026-11-14）
- [Cyber Security News：Cursor Reveals How a Leaked Fireworks AI Key Led to a Backdoored Claude Code Extension](https://cybersecuritynews.com/cursor-data-breach/)：事件经过、5,000 人上限、11 小时窗口（查阅于 2026-11-14）
- [PakTechStan：Cursor Traces Its October Breach to a Leaked Fireworks Key](https://paktechstan.com/article/cursor-traces-its-october-breach-to-a-leaked-fireworks-key-closing-a-two-week-investigation)：调查结论整理（查阅于 2026-11-14）
- [AI Cyber Brief：Notion Fireworks AI breach（二次整理）](https://aicyberbrief.com/article/notion-fireworks-ai-breach-exposed-notion-ai-chat-transcripts-from-under-1-of-workspaces)：Notion 受影响情况（查阅于 2026-11-14）

## 核验记录

- 核对日期：2026-11-14。攻击链、版本号、时间窗口与影响人数以 Cursor 官方公告为准；「被 Fireworks 外泄」是 Cursor 的说法，Fireworks 自己的安全公告未提及 Cursor。
- 篡改版本的具体行为（载入时执行注入代码）来自安全媒体的技术分析，非 Cursor 官方公告原文。

## 相关阅读

- [Cursor 使用指南：功能、价格、上手配置与常见坑](/posts/cursor-programming-tools/)：Cursor 的功能、订阅与使用方式总整理。
- [2026年AI安全工具完全指南：从数据保护到模型安全](/posts/ai-security-tools-2026/)：常见 AI 安全工具与防护做法。
- [OpenAI GPT-6 Cyber 发布：专攻网络安全](/posts/gpt-6-cyber-launch/)：OpenAI 11 月初发布的安全向模型。
- 更多工具实测见 [AI工具实测](/categories/ai工具实测/)。
