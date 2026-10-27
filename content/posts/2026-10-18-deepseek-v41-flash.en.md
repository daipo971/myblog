---
title: "DeepSeek-V4.1-Flash: Faster, Cheaper, MIT-Licensed, and How to Use It"
date: 2026-10-18T16:30:00+08:00
description: "DeepSeek released V4.1-Flash-1017 on October 17: MIT-licensed open weights, API input from $0.15 per million tokens, cached input at $0.003, plus new Search and Fetch web APIs. Pricing explained, peak hours, and how to get started."
tags: ["DeepSeek", "Open-source models", "API", "LLM", "Chinese AI models"]
categories: ["China and Open Models"]
---

DeepSeek released another model yesterday (October 17): **DeepSeek-V4.1-Flash-1017**, where 1017 is the release date. This one is not chasing leaderboards. It is all about being fast and cheap: faster inference, lower API prices, and weights released under the MIT license. Bloomberg covered it in a single phrase: faster and leaner.

## Who it is for

- **Developers building apps**: the API is genuinely cheap. Input is $0.15 per million tokens off-peak, and cached input drops to $0.003. Great for high-volume calls.
- **Self-hosters**: MIT license, no commercial restrictions. Weights are on Hugging Face and ModelScope.
- **Users in China**: the DeepSeek API is reachable directly from mainland China without a VPN.

## Pricing, broken down

This release uses peak and off-peak pricing:

| Type | Off-peak | Peak |
|---|---|---|
| Input | $0.15 / 1M tokens | $0.30 / 1M tokens |
| Cached input | $0.003 / 1M tokens | $0.006 / 1M tokens |
| Output | $0.60 / 1M tokens | $1.20 / 1M tokens |

Peak hours are 06:30–09:30 and 11:30–15:30 on weekdays, in India Standard Time (IST), excluding Chinese public holidays. **The cached-input price is the real headline**: $0.003 is close to free. For RAG and agents that reuse the same context over and over, costs drop dramatically.

Context is 1 million tokens, with up to 384K output tokens per call. That is plenty for long documents and bulk rewriting.

## Two new APIs: Search and Fetch

DeepSeek is also selling its web tools separately:

- **Search API**: searches the web with DeepSeek's own engine, $0.75 per 1,000 calls.
- **Fetch API**: fetches a web page and converts it to Markdown, $0.75 per 1,000 calls.

A freebie: Search and Fetch calls made through server-side tools in DeepSeek Harness, Claude Code or Codex are **free until 21:30 IST on October 31, 2026**.

## How to get started

1. **API**: sign up on DeepSeek's official platform. Check the site for supported payment methods in your region.
2. **Weights**: download DeepSeek-V4.1-Flash-1017 from Hugging Face, or from ModelScope (modelscope.cn), which is faster inside China.
3. **Tooling**: DeepSeek recommends DeepSeek Harness v0.2.1-rc.1 or later. Tencent's CodeBuddy and WorkBuddy have also added support.

## Honest take

- Flash is built to be "good enough and cheap". Do not expect it to top reasoning leaderboards. For everyday development, customer support and content generation, it is the value pick.
- Peak and off-peak pricing looks complicated, but in practice: schedule high-volume jobs off-peak and make heavy use of caching, and your bill will look much better.
- The model is one day old. Community quantizations and deployment guides are still coming, so if you want to run it locally, it may be worth waiting a little.

DeepSeek's strategy here is clear: not the biggest model, but the cheapest one to actually run. For people using models in real work, that matters more than first place on a leaderboard.
