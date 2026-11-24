---
title: "The Complete AI PPT Workflow: From Outline to a Deck You Can Present"
date: 2026-11-24T09:44:00+08:00
lastmod: 2026-11-24T09:44:00+08:00
draft: false
categories: ["AI Tools Hands-On"]
tags: ["Guide", "AI Office", "Gamma", "Kimi"]
description: "AI slides fail on order, not tools: conclusion first, outline second, design last. Five steps, a copy-paste outline prompt, three scenario playbooks, and four pitfalls to avoid."
summary: "The right order for AI slides is content, outline, then design — not the other way around. This guide walks through five steps: a one-sentence conclusion, an AI-drafted outline, the right tool per scenario, slide-by-slide polish, and an export check."
showtoc: true
---

**The short version: the easiest way to ruin an AI-made deck isn't the tool — it's the order.** The right order is conclusion first, outline second, and let AI handle the design last. Do it the other way around — click "one-click generate" first — and you usually get a deck that looks complete and says nothing. This guide gives you the full workflow, from outline to a deck you can present: five steps, then small adjustments for three scenarios (work reports, thesis defense, and pitches), and a checklist to close. Prices and free tiers are based on each product's official site and public sources as of November 24, 2026; they change often, so check the official links at the end before you start.

![Illustration: a presenter standing beside a large screen showing slide cards with geometric shapes and bar charts, a laptop on the table](/images/ai-ppt-workflow/cover.webp)

A note before we start: most of the tools in this guide — Doubao, Kimi, Xunfei Zhiwen, WPS AI — are built for users in China, and their Chinese interfaces are the strongest. Gamma is the global option. If you are outside China, availability varies by product; check each site before you commit to a workflow.

## 1. The core idea: what AI actually does for your slides

A deck is three things: **content** (what you claim, what data you use), **structure** (how many slides, in what order, one idea per slide), and **design** (template, colors, layout, images). AI is not equally good at all three:

```
+-------------------------------------------------------------+
|              What AI is good at (and what it is not)         |
+-------------------------------------------------------------+
|  Design: strongest. Templates, auto-layout, icons in seconds |
|  Structure: middling. Drafts an outline, but logic drifts    |
|  Content: weakest. It does not know your real numbers —      |
|  it invents plausible-looking ones                           |
+-------------------------------------------------------------+
|  Your job: set the conclusion, supply real data, cut filler, |
|  check every slide                                           |
+-------------------------------------------------------------+
```

That is why "type a topic, generate the deck" fails so often: you hand AI its weakest layer (content) and skip the work only you can do (conclusion, data). Flip it around — **you own content and structure, AI owns design** — and the workflow becomes:

**One-sentence conclusion → 10-slide outline → pick a tool and generate a draft → polish slide by slide → export and check**

The outline matters most. Your audience will not remember how pretty a slide was; they will remember the chain of logic: what the problem is, what you found, what should happen next. If reading just the slide titles lets someone retell that chain, the outline is good enough. No template fixes a broken chain. For a rundown of the tools themselves, see our [AI slide-generator comparison](/posts/ai-presentation-tools-2026/) (in Chinese) first, then come back to this workflow.

## 2. Three routes, compared: pick the tool before you start

As of November 2026, AI slide tools fall into three routes. Pick the wrong route and everything after it is rework:

| | Model-first (Doubao, Qwen, Kimi, Baidu Wenku) | Vertical tools (Gamma, Xunfei Zhiwen, AiPPT) | Office suites (WPS AI, Copilot, Canva) |
|---|---|---|---|
| **How it works** | Talk through the content in a chat, then apply a template | Type a topic or upload a document, get a whole deck | Generate, polish, and rewrite inside your existing office app |
| **Chinese output** | Best — phrasing fits Chinese workplace habits | Xunfei Zhiwen and AiPPT are good; Gamma sometimes sounds translated | WPS AI is best, native Chinese office environment |
| **Long documents** | Strongest — Kimi can turn a 20,000-word document into a defense outline | Middling — logic sometimes drifts on long content | Depends on the quality of your source document |
| **Export** | PPTX and PDF, mostly free | PPTX and PDF; Gamma also exports a shareable web link | Native PPTX, best compatibility |
| **Free tier** | Most generous — Doubao and Qwen currently free | Tight — Gamma gives 400 credits once, never refreshed monthly | Basic features free, advanced features need a membership |
| **Access from China** | Direct | Gamma needs an overseas connection; the rest are direct | Direct |
| **Best for** | Chinese reports, thesis defense, everyday drafting | Public sharing, design-led presentations | People who already use WPS or Microsoft 365 |

One-line rule: **Chinese reports and defenses go the model route, public pitches go Gamma, everyday office work goes WPS AI.** The free tiers deserve detail, because that is where people get caught:

- **Gamma**: the free plan gives 400 credits on signup — once, never refreshed monthly. One deck costs about 40 credits; rewriting and images cost extra. Plus is about $9/month (billed annually). Free exports carry a Gamma badge, and each generation caps at 10 slides. Source: [Gamma pricing](https://gamma.app/pricing); prices follow the live page.
- **Doubao and Qwen**: Doubao's slide generation is currently free; Qwen's PPT Agent is officially free forever. A third-party roundup from October 2026 reports Qwen compressing a 400+ page report into a 30-slide deck in one pass. Policies change often — check the official pages.
- **Kimi**: the PPT assistant is free 3 times a month (tightened in January 2026) — save it for polished occasions like turning a thesis into a defense deck. Kimi+ membership starts at ¥49/month for unlimited use. See [Kimi](https://www.kimi.com/).
- **Xunfei Zhiwen**: credit-based, with a free entry point. Memberships come in Pro, Expert, and Ultra tiers, with 1,000, 3,000, and 5,000 credits a month respectively; PPT download packs are also sold, and exact prices require signing in to the membership center. Vision Agent mode exports both PPTX and PDF. Sources: [Xunfei Zhiwen](https://zhiwen.xfyun.cn/) and its [official docs](https://zhiwen.xfyun.cn/docs/#/).
- **WPS AI**: basic features are free; advanced features need a WPS membership, with a 7-day trial for new users. Output is native PPTX, so continuing to edit in WPS is the smoothest path.

One more thing: Tome, once popular, shut down its slides business in 2025 and moved to CRM products. Old articles still recommend it — if you see it, switch to Gamma.

## 3. The hands-on workflow: five steps to a presentable deck

### Step 1: Write a one-sentence conclusion before opening any tool

Before you open any AI tool, write three lines on paper or in a note:

```
Audience: ________________ (e.g. department heads, defense committee, clients)
Length: ________________ (e.g. 15 minutes)
The one sentence they should remember: ________________
```

That sentence is the anchor for the whole deck. Example: "Q3 growth came mostly from repeat customers, so Q4 budget should shift from acquisition to retention incentives." Once the conclusion is set, every slide has a test: if it supports the conclusion, keep it; if it only fills pages, cut it. Skip this step and every slide AI generates can be correct and useless at the same time.

### Step 2: Let a chat AI draft the outline — then fix it yourself

Hand the conclusion and your materials to a chat AI (ChatGPT, Claude, DeepSeek, or Kimi — see our [Kimi model profile](/posts/kimi-guide/) (in Chinese) for versions, pricing, and how to use it in China), using the prompt template below. The key is **pasting real data and materials** — never just a topic. Give it only a topic and it has to invent.

```
I need to make a slide deck. Here is the information:
- Topic: {topic}
- Audience: {e.g. department heads / defense committee / clients}
- Length: {minutes}
- The one sentence I want the audience to remember: {conclusion}
- Data and materials I already have: {paste real data and key points}
Please give me an outline of 8–12 slides: one title, one core point,
and 2–3 supporting points per slide. Mark which slides need real data
from me. Do not invent numbers — leave slides without data blank for me
to fill in.
```

Once you have the outline, do three things: **cut filler slides** (delete generic "Background" or "Future Outlook" slides with no specific information); **add real numbers** (turn "significant growth" into "repeat-purchase rate rose from 31% to 44%"); **check the titles flow** (read only the titles — can you retell the whole argument?). A finished outline is usually 8–12 slides. If it runs past 15, cut content before you touch the design.

### Step 3: Pick a tool by scenario and generate the draft

Only now pick a tool. The three most common scenarios work differently:

| Scenario | Recommended route | What to do |
| :--- | :--- | :--- |
| **Chinese work reports** (weekly, monthly, project updates) | Xunfei Zhiwen, Doubao, or WPS AI | Paste the finished outline, pick a restrained business template, and generate; polish data slides further in WPS AI |
| **Thesis defense** (paper → slides) | Kimi PPT assistant | Give Kimi the paper or long document to build the outline first, then apply a defense template; save the 3 free monthly uses for this |
| **Public pitches and launches** | Gamma for the draft + human polish | Generate card-style slides from the outline and share the web link; for important occasions, do not rely on AI alone — have a designer review it or polish it yourself |

Two settings to watch while generating: **slide cap** (Gamma's free plan caps at 10 slides per generation — split long decks into two runs and merge); **template style** (start with a restrained business template and consistent colors and fonts — cheaper to adjust later).

### Step 4: Polish slide by slide — this is where quality is decided

Do not start by changing fonts or colors. Run through these five checks on every slide — this step improves quality more than swapping templates:

1. **One idea per slide?** AI loves cramming three or four points onto one slide. Split or cut.
2. **Do the titles tell a story?** Reading only the titles should retell the whole argument.
3. **Does every number have a source?** Unsourced numbers get a source or get deleted. AI inventing numbers is routine; every number in a presentation is your responsibility to check.
4. **Do the images match the content?** Auto-picked images often just "look right." Replace irrelevant ones with charts or white space.
5. **Any empty slides?** Slides with no specific information ("Background", "Outlook") go straight in the bin.

And polish in the right order: **content and logic first, design second.** Fix the slides, their order, and what stays or goes; then unify fonts and colors; then images and animations. Doing it the other way is decorating a house before the floor plan is set.

### Step 5: Export, then check in the software you will present with

After exporting to PPTX, always open the file in the software you will actually present with — do not trust how it looked in the generator:

- **Fonts**: export can swap fonts. Check titles and body text haven't fallen back to defaults; if your company has brand fonts, replace them once in PowerPoint or WPS.
- **Alignment and overflow**: check for text spilling out of boxes and tables getting cut off — Gamma's PPTX export sometimes shifts the layout.
- **Animations and links**: the web version and the exported PPTX don't always animate the same way. Run the full deck once before presenting.
- **File size**: AI-picked images can be huge. Compress before the meeting so the file doesn't stutter when opened live.

Five steps done, the deck is presentable. Once the routine is familiar, a 10-slide work report takes about 30–45 minutes: 10 minutes on the outline, 5 on generation, 15–20 on polishing, 5 on the export check. Most of the time goes to fixing the outline and checking numbers — exactly the parts AI can't do for you.

## 4. Four pitfalls: get one wrong and the rest is wasted

### ⚠️ Pitfall 1: AI-invented numbers can sink the whole presentation

This is the most dangerous trap in AI-made decks. AI-generated numbers, cases, and citations look convincing and can be made up. One false number challenged live in the room, and the credibility of the whole deck is gone. Rule: **check the source of every number, date, name, and citation before keeping it.** No source? Delete it or mark it "to verify." Put "do not invent numbers" in your outline prompt every time — AI may still invent them, so the checking step can't be skipped.

### ⚠️ Pitfall 2: Free credits are one-time — you only notice when they're gone

Gamma's 400 free credits are a one-time grant, not monthly; a few decks, rewrites, and images burn through them. Kimi gives 3 uses a month. Rule: **learn the workflow on the most generous free tier first** (run the outline-to-deck routine on Doubao or Qwen), and only spend Gamma or Kimi credits on real occasions. Don't burn one-time credits while you're still figuring out the process. Free exports often carry a brand badge or watermark — check before a formal presentation.

### ⚠️ Pitfall 3: The export looks different — and you find out on stage

A deck that looks fine in the web tool can come out of PPTX export with different fonts, spacing, and animations. Rule: **always do a full run-through in PowerPoint or WPS after exporting**, and export the final version a day early for important occasions — never on the spot. Missing fonts are the most common cause; prefer system fonts or your company's standard fonts.

### ⚠️ Pitfall 4: Don't upload sensitive company material as-is

Client data, financial figures, unpublished plans — desensitize before uploading to any third-party AI service. Rule: **ask first, "is this material allowed to leave the company?"** If not, swap real numbers for sample numbers while you run the workflow, then replace them locally in the finished file. Follow your company's rules where they exist, and check image licensing before commercial use.

## 5. Summary and next steps

The whole workflow in one sentence: **you set the conclusion and the outline, AI handles the layout and the first draft, and you check every slide before exporting.** For tools: Chinese reports go with Doubao, Qwen, Xunfei Zhiwen, or WPS AI; save Kimi's 3 monthly uses for thesis defense; use Gamma for public pitches and polish the draft by hand. On free tiers: Gamma's 400 credits are one-time, Kimi gives 3 uses a month — learn the routine on the generous free tools first.

Three things you can do next:

1. Take a real upcoming report (this week's weekly, for example) and run steps 1–5 on it end to end, timing which step costs you the most.
2. Save the outline prompt from Step 2 as a template — next time, only swap the topic, audience, conclusion, and materials.
3. Compare the tools with the same outline: generate one deck each in two or three tools and keep editing the one that lands closest to what you need. That is the fastest way to find the tool that fits you.

To build this workflow into everyday office work, see our [AI office automation guide](/posts/ai-automation-office-2026/) (in Chinese), which covers meeting notes, weekly reports, and document organization.

## FAQ

**Can I present an AI-generated deck as-is?**
Not recommended. AI can produce structure and layout in minutes, but data, conclusions, and company-specific information need your checking and input. Let AI draft, spend your time on content and the talk track, and do a full run-through in PowerPoint or WPS after exporting.

**Which tool for a Chinese-language work report?**
Try Xunfei Zhiwen, Doubao, Qwen, or WPS AI first — their Chinese phrasing and templates fit Chinese workplaces best. Gamma works in Chinese too and looks more designed. All have free tiers; run the same outline through each once and compare.

**Is Gamma's free plan enough?**
For occasional decks, yes: 400 credits once, about 40 credits per deck, extra for rewrites and images, a 10-slide cap per generation, and exports carry a Gamma badge. If you make decks every week, consider the paid plan or a Chinese tool with a more generous free tier.

**Are Kimi's 3 free uses a month enough?**
Not for everyday drafting — but enough for polished occasions. Save them for thesis defense or important reports where the outline is complex and worth refining, and use Doubao, Qwen, or Xunfei Zhiwen for weekly and monthly reports.

**The PPTX export looks broken. What do I do?**
First check in PowerPoint or WPS whether fonts were replaced or text is overflowing — those are the two most common causes. Prefer system fonts or your company's standard fonts, export the final version a day early, and run through it once.

## Sources

- [Gamma pricing](https://gamma.app/pricing): free plan's 400 credits, 10-slide cap per generation, export formats, and Plus/Pro/Ultra benefits (accessed November 24, 2026).
- [Xunfei Zhiwen](https://zhiwen.xfyun.cn/) and [official docs](https://zhiwen.xfyun.cn/docs/#/): one-click Word and PPT generation; Pro, Expert, and Ultra memberships grant 1,000, 3,000, and 5,000 credits a month; Vision Agent mode exports PPTX and PDF; prices require signing in (accessed November 24, 2026).
- [Kimi](https://www.kimi.com/): Kimi PPT assistant, long-document organizing, and defense templates.
- [Doubao](https://www.doubao.com/): slide generation and free availability.
- [2026 AI slide-generator free-tier comparison (Guozhangmen AIGC, October 25, 2026)](https://guozhangmen.com/articles/ai-ppt-free-guide.html): free tiers of 12 tools compared; free-tier figures for Doubao, Qwen, Kimi, Xunfei Zhiwen, WPS AI, and Gamma cross-checked here — official pages still rule.
- [AI PPT tools: the November 2026 landscape (361way)](https://www.361way.com/ai/07/): Chinese fidelity and export ability of Gamma, Kimi PPT, WPS AI, and Xunfei Zhiwen compared.

## Changelog

- 2026-11-24: First published. English version of the Chinese guide published the same day. Five-step workflow, three scenario playbooks, four pitfalls, and a copy-paste outline prompt; free tiers and prices as checked on official sites and public sources on November 24, 2026.

## Related reading

- [Kimi model profile: K3 to K3.1 Pro versions, pricing, and open-source status](/posts/kimi-guide/) (in Chinese)
- [AI slide-generator comparison: Gamma, Xunfei Zhiwen, Kimi, and more](/posts/ai-presentation-tools-2026/) (in Chinese)
- [AI office automation: meeting notes, weekly reports, and document organization](/posts/ai-automation-office-2026/) (in Chinese)
- More AI Tools Hands-On articles: [/en/categories/ai-tools-hands-on/](/en/categories/ai-tools-hands-on/)
