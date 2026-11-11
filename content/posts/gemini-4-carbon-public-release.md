---
title: "Gemini 4 Carbon 全面開放：價格與入口"
date: 2026-11-11T09:40:00+08:00
lastmod: 2026-11-11T09:40:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "Gemini", "Google"]
description: "Google 11 月 10 日把最強模型 Gemini 4 Carbon 全面開放：付費 API 與 Ultra 訂閱都能用，入門價輸入 2 美元、輸出 10 美元，只到 11 月 30 日。"
showtoc: true
---

先給結論：**Google 在 11 月 10 日把 Gemini 4 Carbon 全面開放了。**這是 Google 目前最強的模型，兩週前只給網路安全防禦者試用，現在付費開發者、企業和 Google AI Ultra 訂閱用戶都能用。入門價每百萬 tokens 輸入 2 美元、輸出 10 美元，只到 11 月 30 日，12 月 1 日起漲一倍。免費版用戶暫時還用不上。

![插畫：深色碳晶核心向外放射光線，象徵 Gemini 4 Carbon 全面開放](/images/gemini-4-carbon-public-release/cover.webp)

## 跟 10 月 28 日那次有什麼不同

Carbon 其實不是今天才問世。Google 在 10 月 28 日就發布了它，但當時只開放給 Fairwind 計畫裡的一小群網路安全防禦者，拿來找漏洞、打補丁，一般人碰不到。當時本站也寫過一篇快訊，講它強在哪、為什麼先給防禦者用（見[谷歌 Gemini 4 Carbon 發布：專攻網路安全](/posts/gemini-4-carbon-launch/)）。

11 月 10 日這次是**全面開放**：從受限預覽變成正式上線的產品，開發者、企業、一般消費者和科研人員都有各自的入口。這才是大多數人真正能開始用 Carbon 的時間點。

時機也很有意思：就在前一天，Anthropic 的 [Claude Fable 5.2 發布：更快、更便宜](/posts/claude-fable-mythos-5-2-launch/)，在第三方綜合榜 Artificial Analysis 上以 65 分反超 Carbon 的 60 分，搶走了第一名。Google 隔天就把 Carbon 全面推開，兩家最強模型的正面對決正式開打。

## 誰能用、從哪進

根據 [Google 官方公告](https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-4-carbon-now-available/)，入口分四條線：

- **開發者**：Gemini API 付費層，在 Google AI Studio 和 Android Studio 裡用。免費層不包含 Carbon。
- **企業**：Gemini for business，可走 API 或模型下拉選單，也能在 Google Antigravity 和 CodeMender 裡用。
- **一般消費者**：必須是 Google AI Ultra 訂閱用戶，在 Gemini App 和搜尋的 AI Mode 裡用。AI Pro 訂閱用戶繼續用 Argon，拿不到 Carbon。
- **科研人員**：Google 把 1 萬名科學家免費使用 Antigravity 最高用量層 6 個月的計畫擴大到 Carbon，申請仍開放中，按資格、名額分批通過。

另外，專攻網路安全的「Carbon for cyber」版本仍然只走 Fairwind 計畫申請，不在這次全面開放的範圍內。

## 多少錢：入門價只到 11 月 30 日

API 價格和 Argon 的入門價相同：

| 方案 | 每百萬 tokens 輸入 | 每百萬 tokens 輸出 | 期限 |
| --- | --- | --- | --- |
| 入門價 | 2 美元 | 10 美元 | 到 2026 年 11 月 30 日 |
| 標準價 | 4 美元 | 20 美元 | 2026 年 12 月 1 日起 |

對照一下：Claude Fable 5.2 的 API 是輸入 8 美元、輸出 40 美元，Carbon 的入門價只有它的四分之一，標準價也只有一半。Google 顯然想用價格換市佔——模型不是最強的那個，但便宜得多。

一般消費者這邊則要看訂閱：美國的 Google AI Ultra 是每月 99.99 美元（5 倍用量）或 199.99 美元（20 倍用量），才能在 App 裡用到 Carbon。只想偶爾試試的人，API 入門價划算得多。

## 新東西：/swarm 與官方跑分

這次開放還帶了一個新功能：**`/swarm`**，目前在 Google Antigravity 裡預覽。一個提示詞下去，變成一支互相配合的 Agent 團隊，各自在獨立的工作區裡平行做事，還有專門負責挑錯的驗證 Agent 檢查每一次改動，整個過程可以即時追蹤。開發者可以把 Carbon 指派給最需要深度推理的角色（架構設計、統籌、審查），再搭配更快更輕的模型處理其他部分。簡單說，就是把「多 Agent 協作」做成產品功能，而不是讓開發者自己拼。

跑分方面，以下均為 Google 官方公布的成績，**未經獨立驗證**，先看個大概：

- **Agent 工作流程**：CursorBench 4.0、Perplexity 的 WANDR、Zapier 的 AutomationBench 三個榜都是第一名，而且每個任務的成本比次佳模型低一半以上；
- **多模態知識 Agent**：Google 與 Artificial Analysis 合作的新基準 MKA 上排第二，但每個任務的平均成本比第一名低 6 倍以上；
- **安全**：Gray Swan 的提示注入基準上攻擊成功率 0%，模擬網攻測試中攔下 99% 的攻擊路徑；
- **誠實度**：375 項任務的 Agent 誠實基準通過率 92%，Argon 是 70%，缺資料時 98% 會拒絕瞎編。

官方同時強調，Argon 仍是大多數軟體工程與知識工作的合適選擇，Carbon 是為「挑戰模型極限的任務」準備的：複雜的多步驟寫碼與除錯、開放式科學研究。Carbon 會用比 Argon 更多的 tokens 去探索、深思與反覆驗證，成本與速度都要付出代價。

## 對一般使用者意味著什麼

- **不用急著換模型**：日常問答、寫作、一般寫碼，Argon 甚至更便宜的模型就夠了。Carbon 的價值在最難的長程任務——大型程式碼遷移、跨系統找問題根源、科學研究。
- **開發者可以先試入門價**：11 月 30 日前每百萬 tokens 輸入 2 美元，比 Fable 5.2 便宜得多，適合拿來跑原本不敢用頂級模型跑的長任務。
- **Ultra 訂閱用戶直接升級**：在 Gemini App 和 AI Mode 裡就能選到 Carbon，不用另外申請。
- **科研人員多一條路**：1 萬名科學家免費 6 個月的計畫現在也包含 Carbon，符合資格的可以去申請。

## 國內使用者注意

這部分要講清楚、不要誤導：Google **沒有公布 Carbon 分國家、分地區的上線時間表**，Ultra 雖然在 150 多個國家銷售，但 Carbon 是否覆蓋各地、各地何時上線，官方沒有說明。Gemini 在中國大陸也沒有正式提供服務，**國內能不能用上 Carbon，目前未證實**。價格是美元計價，實際到手成本還要看付款方式與匯率。等有明確的地區資訊，本站會再更新。

## 参考来源

- [Google 官方公告：Gemini 4 Carbon is now available](https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-4-carbon-now-available/)：發布日期、開放範圍、價格、/swarm、跑分與安全數據（查閱於 2026-11-11）
- [Google DeepMind 官方部落格：Gemini 4 Carbon is now available](https://deepmind.google/blog/gemini-4-carbon-is-now-available/)：與官方公告同文，確認發布內容（查閱於 2026-11-11）
- [VentureBeat：Google Gemini 4 Carbon is now publicly available](https://venturebeat.com/technology/google-gemini-4-carbon-is-now-publicly-available-and-it-undercuts-claude-fable-5-2-and-opus-5-5-on-api-price)：12 月 1 日起的標準價、Ultra 訂閱價與地區資訊（查閱於 2026-11-11）

## 核驗記錄

- 核對日期：2026-11-11。發布、價格與入口以 Google 官方公告為準；12 月 1 日起的標準價見 VentureBeat 報導的 Google 定價資訊。
- 跑分與安全數據均為廠商自報，未經獨立驗證；綜合榜分數（Fable 5.2 65 分、Carbon 60 分）為第三方 Artificial Analysis 榜單數據。
- 國內可用性未證實：Google 未公布分國家上線時間表，本文不作「國內能用」的推斷。

## 相關閱讀

- [AI前沿動態](/categories/ai前沿動態/)：本分類全部文章。
- [谷歌 Gemini 4 Carbon 發布：專攻網路安全](/posts/gemini-4-carbon-launch/)：10 月 28 日首發快訊，講 Carbon 的安全基準成績與 Fairwind 計畫。
- [Claude Fable 5.2 發布：更快、更便宜](/posts/claude-fable-mythos-5-2-launch/)：前一天發布的對手，綜合榜上剛反超 Carbon。
- [Gemini Omni 1.2 發布：15 秒影片，降價 30%](/posts/gemini-omni-1-2-flash-launch/)：Google 另一條 Gemini 產品線的最新動態。
- [ChatGPT、Claude、Gemini 國內開通總綱](/posts/chatgpt-claude-gemini-china-access-guide/)：國內使用者開通海外 AI 服務的總整理。
