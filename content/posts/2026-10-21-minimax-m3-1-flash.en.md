---
title: "MiniMax M3.1 Flash: Half the Price of DeepSeek, With One Big Caveat"
date: 2026-10-21T22:55:00+08:00
draft: false
description: "Shanghai-based MiniMax released M3.1 Flash on October 19: 1M context, text/image/video input, 200+ tokens per second, and $0.15 per million input tokens, half of DeepSeek V4.1 Flash. Its independent intelligence score rose from 29 to 42, but its hallucination rate is 93%. What it is good at, where it fails, and how to try it free."
tags: ["MiniMax", "LLM", "Chinese AI models", "API", "Guide"]
categories: ["China AI"]
---

The price war among Chinese models just took another step. On October 19, Shanghai-based MiniMax released **M3.1 Flash**, built to be fast and cheap: API input costs just **$0.15 per million tokens**, exactly half of DeepSeek V4.1 Flash, which launched days earlier. Here is what it does well, where it falls down, and how to try it free.

## Highlights: fast, cheap, and a 1M-token context

- **Speed**: MiniMax says inference is 3x faster than the previous generation, with **200+ output tokens per second**. You feel the difference in chat and in chained agent calls.
- **Context**: **1 million tokens**, enough for long documents or large codebases without chunking.
- **Multimodal**: text, image and video input, not just a text model.
- **Price** (per million tokens): $0.15 input, $0.60 output, $0.015 cached input. It was already popular before launch: its anonymous test version reportedly served over 200 trillion tokens.

## What independent tests say (beyond the official benchmarks)

Official benchmarks are mostly self-reported. Data from the independent evaluator Artificial Analysis is more useful:

- **Intelligence Index of 42**, up from 29 for the previous generation. Real progress.
- **Average cost per task down from $0.51 to $0.22**: faster and cheaper at the same time.
- HLE (hard knowledge questions) up from 39% to 48%.

## The caveat: a 93% hallucination rate

This is the most important part. In the same independent testing, M3.1 Flash showed a **93% hallucination rate on AA-Omniscience**. In other words, when it is unsure, it almost never says "I don't know". It confidently makes up an answer instead.

So be deliberate about where you use it:

- **Good for**: coding, agent workflows, processing long documents, creative generation. Tasks where output is easy to verify or there is no single right answer.
- **Not good for**: being your only source for factual questions. If you do use it for knowledge work, pair it with retrieval (RAG) or ask it to cite sources, and check them yourself.

## How to access it (including free options)

- **MiniMax's official API, M Plan and MiniMax Code**: the official channels.
- **OpenRouter**: free for the first 72 hours after launch, then official pricing (check the platform page for current limits).
- **Vercel**: offers a free route to get a feel for it.

One date to note: **the weights are due to be open-sourced this Friday (October 23)**, but the license has not been published. Whether commercial use is allowed, and on what terms, should wait for the official license text. Do not rely on second-hand reports.

## Summary

**M3.1 Flash has a clear role: cheap, fast and long-context, a good "workhorse" for agents and coding. But it is not an honest knowledge model, and the 93% hallucination rate is a red line to remember.** Run two of your own real tasks through a free route to test it; that tells you more than any benchmark. If the license turns out to be friendly when the weights land, it becomes another strong low-cost option for self-hosting.
