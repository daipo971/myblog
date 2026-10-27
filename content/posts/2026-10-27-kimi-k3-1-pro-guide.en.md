---
title: "Kimi K3.1 Pro Is Out: China's 3T-Parameter Model Takes On Claude Opus, and How to Use It for Free"
date: 2026-10-27T07:35:00+08:00
draft: false
tags: ["Kimi", "Moonshot AI", "LLM", "Chinese AI models", "Guide"]
categories: ["China AI"]
description: "Moonshot AI released Kimi K3.1 Pro on October 23: a ~3T-parameter mixture-of-experts model whose coding and financial-document scores come close to Claude Opus 5.5 at half the API price. Free entry points, membership tiers, five ways to access it, and four pitfalls."
summary: "Moonshot AI released Kimi K3.1 Pro on October 23: a ~3T-parameter mixture-of-experts model whose coding and financial-document scores come close to Claude Opus 5.5 at half the API price. Free entry points, membership tiers, five ways to access it, and four pitfalls."
---

The short version: **on October 23, Moonshot AI released Kimi K3.1 Pro**, the first "3T-class" model from a Chinese lab. On Moonshot's own scorecard it reaches Claude Opus 5.5 territory in coding, financial documents and long context, while its API costs half as much as Opus. It launched on the web, mobile apps, desktop app, coding assistant and API on the same day.

This guide covers what it is good at, how it compares with MiniMax M3.1 Flash (released the same day), where ordinary users can try it for free, and how to avoid overpaying for a membership.

## K3.1 Pro in one sentence: 3T parameters, but only ~3% used per answer

K3.1 Pro is a **mixture-of-experts (MoE) model**: about 2.8 trillion parameters in total, split across 896 "experts". For any single request, **only 16 experts are activated** (roughly 100 billion parameters doing the work).

The benefit: the model has a large knowledge base, but the compute per request stays manageable. That is what lets Moonshot price the API at half of Opus 5.5.

Two more headline specs: a **1 million token context window** (a whole book plus a codebase in one go) and **multimodal input** (text, images and video).

## The scorecard: impressive, but self-reported

The official numbers (note: **all measured by Moonshot itself**, not yet independently verified):

- **Terminal-Bench 4.0 (coding): 65.7%**, versus 66.4% for Claude Opus 5.5. Very close.
- **BenchCAD (3D modeling code): 92.7%**, its standout result, close to the top tier.
- **OfficeQA Pro v2 (financial documents): 64.4%**, which Moonshot calls best in class. Its demos build full financial models with traceable formulas.
- **Hallucination rate**: on Moonshot's hardest factuality test, down from 23.4% on K3 to **8.3%**.

To be fair: the 8.3% figure comes from a stress-test set and does not describe everyday Q&A error rates, and vendor benchmarks always run warmer than independent ones. **Do not choose a model on benchmarks alone. One round with your own real tasks tells you more.**

## K3.1 Pro or M3.1 Flash? Two Chinese models, one launch day

October 23 was a big day for Chinese models: MiniMax also released the weights of M3.1 Flash. The two are aimed at different jobs:

| | Kimi K3.1 Pro | MiniMax M3.1 Flash |
|---|---|---|
| Positioning | All-round flagship: coding, documents, long context, agents | Fast and cheap: 3x speed, 70% lower cost |
| API price (input/output, per 1M tokens) | $2 / $10 | $0.15 / $0.60 |
| Open weights | Promised before November 4 | Already released |
| Best for | Quality: coding, documents, agents | Speed and price: high-volume calls |

In one line: **if quality matters more than cost, pick K3.1 Pro; if you need cheap and fast, pick M3.1 Flash.** If you just use the Kimi app, you do not need to think about API prices at all.

## How to use it: five entry points, all live on day one

This was a hosted-first launch. You **do not need to wait for the weights**; five channels opened on release day:

1. **Web, kimi.ai**: open it and start chatting. Sign-up uses a phone number.
2. **Mobile apps**: iOS, Android and HarmonyOS. Search for "Kimi" in your app store.
3. **Kimi Work desktop app** (version 3.1.0 or later): Windows and Apple Silicon Macs, the main tool for documents, slides and deep research.
4. **Kimi Code**: the coding assistant. Use the `/model` command to switch to Kimi K3.1 Pro.
5. **API**: platform.kimi.ai, model ID `kimi-k3.1-pro`, plus a `highspeed` variant that runs 2–3x faster.

One detail: **K3.1 Pro only supports thinking mode.** Requests with thinking turned off are rejected. It always reasons before answering, so there is nothing to switch on.

## Free or paid: check the app first, then decide

**Step 1: look at the free tier.** Open the Kimi app or website and check whether "Kimi K3.1 Pro" appears in the model picker. If it does, you can use it free. If not, it is still rolling out or requires a membership, so hold off on paying and read on.

**Step 2: membership tiers (China pricing, from Kimi's site as of October 2026; ¥ is Chinese yuan).**

| Tier | Monthly | Annual, per month | Relation to K3.1 Pro |
|---|---|---|---|
| Free | ¥0 | — | Depends on rollout; try it first |
| Go | ¥49 | ¥39 | **Does not include** Kimi Code; skip it if you code |
| Plus | ¥99 | ¥79 | **Includes K3.1 Pro** (Kimi Code needs Plus or higher) |
| Pro | ¥199 | ¥159 | Highspeed variant plus the full 1M context |
| Max/Ultra | ¥699/¥1399 | — | Heavy users only |

A caveat: Kimi's membership quota is a **shared pool shown only as a percentage**, without telling you how many tokens remain. Community tests show the same tier draining up to ten times faster depending on usage. Our advice: **measure your own usage on the free tier first, then buy Plus if you need it. Only move to Pro if you really need the speed and long context.** Existing subscribers: after September's plan changes you can renew old plans at the old price, so do not switch plans by accident.

## Four pitfalls to know before you start

1. **The weights are not out yet.** They are promised before November 4, but **the license has not been published**. If you plan to self-host or use it commercially, wait for the license text instead of relying on second-hand reports (we learned this lesson with M3.1 Flash).
2. **The benchmarks are self-reported.** Treat every "close to Opus 5.5" claim with caution until independent evaluations appear.
3. **It is off by default in Kimi Enterprise.** For company and team accounts, an admin has to enable the model before you can see it.
4. **API and membership are billed separately.** A Plus membership does not include API credit, and topping up the API does not upgrade your membership. Developers pay per token through the API ($2/$10); everyday users pick a membership tier in the app.

## Bottom line

Kimi K3.1 Pro is the strongest push yet from a Chinese lab on raw quality: a 3T-class MoE, 1M context, strong coding and finance results, at half the price of Opus 5.5. Try it free first and start with Plus if you need more. Once the weights are released before November 4, we will follow up with a self-hosting guide for anyone who wants to run it commercially or on their own servers.

---

*Fact check: release details come from Moonshot's official announcement of 2026-10-23 and its X account @Kimi_Moonshot. Benchmarks are self-reported by Moonshot. Membership prices are from the Kimi help center as captured on 2026-10-19; check the official site for current rates.*
