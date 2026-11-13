---
title: "Gemini 4 Hydrogen 發布：免費版也能用"
date: 2026-11-13T09:30:00+08:00
lastmod: 2026-11-13T09:30:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "Gemini", "Google"]
description: "Google 11 月 12 日發布 Gemini 4 Hydrogen：主打速度與日常 Agent 任務，輸入每百萬 tokens 1.5 美元，比 3.8 Flash 快 2.5 倍，免費版 App 與搜尋都能用上 Gemini 4。"
showtoc: true
---

先給結論：**Google 在 11 月 12 日發布了 Gemini 4 Hydrogen**，這是 Gemini 4 家族的第三個成員，定位和 Carbon、Argon 完全不同——Carbon 與 Argon 負責最難的長程推理，Hydrogen 是日常執行的快車：寫程式、跑測試、做研究、處理文件，講究又快又便宜。更關鍵的是，**這是第一個免費版用戶也能用上的 Gemini 4**：Gemini App 會自動選用它，Google 搜尋也全面換上它。

![插畫：淡藍色的氫原子光球沿著發光軌跡高速穿過深藍色數位空間，象徵快速執行](/images/gemini-4-hydrogen-launch/cover.webp)

## 發生了什麼

| 項目 | 內容 |
| --- | --- |
| 發布方 | Google（Google DeepMind） |
| 發布時間 | 2026 年 11 月 12 日 |
| 模型定位 | Gemini 4 家族的快速執行模型，主打日常寫碼與 Agent 工作流程 |
| 價格 | 輸入每百萬 tokens 1.5 美元、輸出 7.5 美元，100 萬上下文全程統一定價 |
| 上下文 | 輸入 100 萬 tokens，輸出最高 100 萬 tokens |
| 開放範圍 | Google AI Studio 全部層級、Gemini API、Gemini for business、Gemini App、Google 搜尋，以及付費 Pro／Ultra 訂閱的 Antigravity |

Google 在同一天還為搜尋單獨發了一篇公告，稱這是「搜尋至今最大的一次模型升級」：Hydrogen 即日起在全球搜尋向**所有用戶**開放，不限付費訂閱。

## 關鍵變化

**第一，快，而且是官方拿來對標上一代的快。**Google 官方說法：與 Gemini 3.8 Flash 相比，Hydrogen 在預設的高思考（high）檔位下完成任務快 2.5 倍；Terminal-Bench 4.1 得分 57%，對比 3.8 Flash 的 18.2%，超過三倍；編造內容的情況減少 5 倍以上。合作夥伴的早期測試顯示，在複雜的程式碼與企業工作流程中，Hydrogen 比 3.8 Flash 快 2 至 2.8 倍，同時 token 用量減少 12% 至 23%。

**第二，跑分上已經追平家族裡的旗艦 Argon。**在 Artificial Analysis 綜合智慧指數（Intelligence Index）上，Hydrogen 預設 high 檔位得 51 分，略高於 Argon 的 50 分；開到最高的 xhigh 檔位可達 54 分。其他官方公布的成績包括：Agent Arena 實時榜第 5 名、HLE-Diamond 58.8%（同級領先）、Vals 稅務 Agent 基準第 1 名（52.3%）、Vals 法律研究基準並列第 1（55.8%）、多模態知識 Agent 基準 53.4%、Agents' Last Exam 71.6%。

**第三，四檔思考深度可以自己調。**Hydrogen 提供 low、medium、high（預設）、xhigh 四個思考層級，任務簡單就少想一點、省時間省錢，任務難就拉到 xhigh。這是 Gemini 4 家族裡第一次出現 xhigh 檔位。

**第四，Google 開始推「多模型自動分工」。**Antigravity 裡新上線的 Orchestrator 會在同一個工作階段裡動態切換模型：Carbon 負責架構判斷，Hydrogen 負責執行與驗證。官方數據稱，在 Terminal-Bench 4.0 上，Orchestrator 達到接近 Carbon 的任務成功率，同時少用 24% 的額度、快 19%。多個 Agent 並行時，Carbon 可以當協調者，Hydrogen 同時驅動多個工作與驗證 Agent。

**第五，搜尋體驗跟著升級。**Google 搜尋的公告列出四點：更準地理解多段式、帶錯字或很具體的提問；回答更視覺化、更好掃讀；查詢擴展（query fan-out）技術升級，會連到更多元的相關連結。不過這篇搜尋公告沒有給任何數字，也沒有說明分國家、分裝置的上線時間表。

**第六，安全數據也一起公布了。**官方說法：Hydrogen 在 Agent 任務中過度執行（overreach）減少最高 81%、服務不足減少最高 79%，錯誤行動與走捷徑的情況減少 12 倍；面對不可能完成的任務，繞過權限邊界的機率降低一半，內部 Agent 誠實度評估達 96.7%；推理鏈可讀性維持 99.9%，20 多萬輪審計中沒有發現欺騙性推理編輯；對間接提示注入攻擊的抵抗力比 3.8 Flash 高 2.3 倍以上。

## 對普通用戶意味著什麼

- **免費版用戶第一次摸到 Gemini 4**：之前 Carbon 與 Argon 都要付費，Hydrogen 是第一個下放到免費版的 Gemini 4。Gemini App 會依提問自動選用，搜尋則是全部用戶直接用上，不用動手切換。
- **寫程式與日常任務變快變便宜**：API 價格輸入 1.5 美元、輸出 7.5 美元，比 Carbon 入門價（輸入 2 美元、輸出 10 美元）更低，定位就是「每天都在用的執行模型」。開發者從 3.8 Flash 升級上來，是這次發布最直接的受益者。
- **不用急著追 Carbon**：日常問答、寫作、一般寫碼與 Agent 任務，Hydrogen 已經夠用；Carbon 的價值仍在最難的長程任務——大型程式碼遷移、跨系統找問題根源、科學研究。
- **搜尋結果會變**：Google 說搜尋會給出更視覺化、連結更多元的回答。寫部落格、做內容的人可以留意：搜尋帶來的流量結構可能跟著變化，值得觀察一兩週再下結論。

## 國內使用者注意

這部分要講清楚、不要誤導：Google **沒有公布 Hydrogen 分國家、分地區的上線時間表**，搜尋公告只說「全球向所有用戶推出」，沒有說明各地何時上線、哪些語言優先。Gemini 在中國大陸也沒有正式提供服務，**國內能不能用上 Hydrogen，目前未證實**。API 價格是美元計價，實際到手成本還要看付款方式與匯率。等有明確的地區資訊，本站會再更新。

## 参考来源

- [Google 官方公告：Introducing Gemini 4 Hydrogen for Agentic Workflows](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-hydrogen/)：發布日期、開放範圍、價格、跑分、四檔思考層級與安全數據（查閱於 2026-11-13）
- [Google 搜尋官方公告：Google Search gets a major upgrade with Gemini 4 Hydrogen](https://blog.google/products-and-platforms/products/search/gemini-4-hydrogen-search-upgrade/)：搜尋全面換上 Hydrogen、向所有用戶開放（查閱於 2026-11-13）
- [Digital Trends：Google's next-gen Gemini 4 Hydrogen AI model is here](https://www.digitaltrends.com/cool-tech/googles-next-gen-gemini-4-hydrogen-ai-model-is-here-touting-faster-intelligence-for-all/)：第三方報導，確認發布內容與上線範圍（查閱於 2026-11-13）

## 核驗記錄

- 核對日期：2026-11-13。發布、價格與入口以 Google 官方公告為準；搜尋上線範圍見 Google 搜尋官方公告。
- 跑分與安全數據均為廠商自報，未經獨立驗證；綜合榜分數（Hydrogen 51 分、Argon 50 分、xhigh 54 分）為第三方 Artificial Analysis 榜單數據，由 Google 官方公告引用。
- 國內可用性未證實：Google 未公布分國家上線時間表，本文不作「國內能用」的推斷。

## 相關閱讀

- [AI前沿動態](/categories/ai前沿動態/)：本分類全部文章。
- [Gemini 4 Carbon 全面開放：價格與入口](/posts/gemini-4-carbon-public-release/)：11 月 10 日開放的家族旗艦，入門價輸入 2 美元、輸出 10 美元，只到 11 月 30 日。
- [谷歌 Gemini 4 Carbon 發布：專攻網絡安全](/posts/gemini-4-carbon-launch/)：10 月 28 日首發快訊，講 Carbon 的安全基準成績。
- [Claude Fable 5.2 發布：更快、更便宜](/posts/claude-fable-mythos-5-2-launch/)：11 月 9 日發布的對手，綜合榜上剛反超 Carbon。
- [ChatGPT、Claude、Gemini 國內開通總綱](/posts/chatgpt-claude-gemini-china-access-guide/)：國內使用者開通海外 AI 服務的總整理。
