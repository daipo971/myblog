---
title: "你复制的 Claude 文字，带着隐形水印"
date: 2026-11-03T15:51:00+08:00
lastmod: 2026-11-03T15:51:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "AI政策", "AI安全", "Claude", "Anthropic"]
description: "Claude 生成的文字带着肉眼看不见的水印，今天起 Mythos 5、Opus 4.7 等四个旧模型也补上了：复制会跟随、普通人查不了。本文讲清水印怎么运作、谁能检测，以及为什么别买「改写去水印」服务。"
showtoc: true
---

![Claude 文字水印封面图](/images/claude-text-watermark/cover.webp)

**一句话结论：** 你用 Claude 写的文字，一直带着肉眼看不见的隐形水印；从今天起，连四个旧模型也补齐了。它不影响你写稿、发稿，不用做任何设置——但市面上收费的「改写去水印」服务别买，那笔钱花得冤。

## 发生了什么：四个旧模型今天补齐

据科技媒体 The Decoder 10 月 31 日报道，Anthropic 在发给平台客户的邮件中通知：自 11 月 3 日起，Claude Mythos 5、Opus 4.7、Opus 4.6、Sonnet 4.6 四个模型的输出补上文字水印，与新模型同款，覆盖 Claude 平台和 API；经 Amazon Bedrock 调用的上线可能晚几天；按报道口径，用户无法关闭这项标记。

这里要把口径分清：「11 月 3 日」和具体四个型号，来自客户邮件的二手报道，不是 Anthropic 公开页面写明的。Anthropic 官方支持页《How Claude marks AI-generated content》证实的是项目本身：公司已签署欧盟 AI 法案 Article 50(2) 的透明度行为准则，并明确写道正在为 2026 年 8 月 2 日之前发布的模型添加水印。但截至该页 10 月 28 日的官方表格，这四个模型还只标了文件内容凭证（C2PA），文字水印一栏没有勾，也没有给出日期。一句话：补水印这件事和方向是官方的，具体日期和名单是报道的。

## 水印是什么：织在文字里，不是藏了字符

按官方说法，文字水印是在模型生成那一刻、于模型层面织入文本的不可察觉标记。它不添加任何字符，不改变文字的含义、质量和可读性，你把 Claude 的回答和没水印的版本放在一起，肉眼分不出区别。

早就带水印的是 2026 年 8 月 2 日之后发布的模型，官方表格里文字水印全勾的有 9 个，包括 Fable 5.1、Fable 5、Mythos 5.1、Opus 5.5、Opus 5、Opus 4.8、Sonnet 5.5、Sonnet 5 和 Haiku 5.5。也就是说，如果你最近半年用的是新款 Claude，输出带水印早就是常态，只是没人提醒你而已。

因为标记就在文字本身里，复制粘贴到任何地方都会跟着走，经过一定程度的编辑之后仍可能保留。它回答的问题是「这段文字带没带 Claude 的标记」，这是欧盟法案对 AI 生成内容透明度的要求方向。另外注意区分：Claude 生成的图片等文件还会附带 C2PA 内容凭证，那是给文件用的另一套标记，和文字水印不是一回事。还有一点让人安心的：水印不溯及既往，今天之前生成的文字不会被回头打标。

## 谁能检测：普通人查不了

这是最容易被误解的一点。官方明确说，文字水印的检测目前处于 private preview（私有预览）阶段，只向符合条件的组织开放：监管机构、执法部门、媒体、事实核查机构、独立研究者和教育组织等，这是欧盟法的配套要求。

面向公众的免费工具 Claude Content Checker 只能检查文件里的 C2PA 凭证，查不了文字水印。所以结论很直接：现阶段没有任何官方渠道能让你把一段文字贴进去、验一验有没有 Claude 水印。网上声称能做这件事的工具，都不是 Anthropic 的能力。

补一句行业背景：这不是 Anthropic 一家在动。xAI 已在官方文档中写明 Grok 的文字标记将于 11 月 7 日起生效，OpenAI 10 月也推出了 textGrain 标记（欧盟地区 ChatGPT 与 Codex 默认开启）。三家殊途同归，推手都是同一部欧盟 AI 法案。Anthropic 的其他产品动作，本站收在 [AI前沿动态](/categories/ai前沿动态/) 中心页的 Anthropic 小节里，比如 [Claude Duet 发布](/posts/2026-10-22-claude-duet-launch/)一文。

## 对普通用户和写作者：照常用，别花冤枉钱

使用层面零变化：不另外收费，不用开任何开关，claude.ai、手机 App、API 写出来的东西看起来和以前一模一样。你拿 Claude 辅助写稿、润色、翻译，再发到自己的博客或公众号，流程一个字都不用改。想系统补一补 Claude 的用法，看本站的 [Claude 入门完整指南](/posts/claude-guide/)即可。

真正要提醒的是另一件事：已经能预见会冒出一批收费的「AI 去水印」「humanizer 改写」服务，话术多半是「重写一遍，洗掉 AI 痕迹」。别买。原因有两个：第一，水印信号在统计层面的模式里，不是藏了几个特殊字符、删掉就没了，常规改写的话术对它并不对症；第二，检测器根本不对公众开放，卖服务的人连「已经洗干净了」都无法向你证明，你花钱买的是一个没法验收的承诺。

最后把证据边界说透，免得以后有人拿水印吓唬你：查出水印，只说明 Claude 参与过这段文字——整篇生成算，润稿、扩写、翻译也算，它不是「全文 AI 代写」的铁证；反过来，查不出水印也不能证明就是人写的，今天之前生成的旧文字、还没被覆盖到的模型，天然就没有标记。知道有这回事、心里有数，就够了。

## 参考来源

- Anthropic 官方支持页：[How Claude marks AI-generated content](https://support.claude.com/en/articles/16266773-how-claude-marks-ai-generated-content)
- The Decoder 报道（11 月 3 日补齐四模型的客户邮件消息源）：[Anthropic's watermark rollout leaves a loophole on two older Claude models](https://the-decoder.com/anthropics-watermark-rollout-leaves-a-loophole-on-two-older-claude-models/)
