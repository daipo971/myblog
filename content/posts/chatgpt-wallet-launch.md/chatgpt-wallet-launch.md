---
title: "ChatGPT Wallet 上線：AI 幫你結帳"
date: 2026-11-14T09:40:00+08:00
lastmod: 2026-11-14T09:40:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "ChatGPT", "OpenAI"]
description: "OpenAI 11 月 13 日推出 ChatGPT Wallet：dots 智能體可在用戶逐筆授權後代為結帳，卡號以代碼化憑證取代、不交給商家與智能體。初期只限美國 Pro 訂戶，國內用戶暫時用不上。"
showtoc: true
---

先給結論：**OpenAI 在 11 月 13 日推出 ChatGPT Wallet**，讓 ChatGPT 的常駐智能體 dots 可以替用戶完成購物結帳。關鍵設計是「卡不離手」：用戶綁卡一次，之後每筆消費都要自己看過商品、金額再用 Face ID 或指紋確認，真正扣款時商家與智能體拿到的只是一次性代碼化憑證，看不到真實卡號。初期只開放給**美國 18 歲以上的 ChatGPT Pro 訂戶**，且須持有美國發行的合格卡片，國內用戶目前用不上。

![插畫：機械手托著發光的數位錢包，一張帶護盾光暈的付款憑證卡懸浮其上，象徵智能體代為結帳](/images/chatgpt-wallet-launch/cover.webp)

## 發生了什麼

| 項目 | 內容 |
| --- | --- |
| 發布方 | OpenAI |
| 發布時間 | 2026 年 11 月 13 日（美國時間） |
| 產品 | ChatGPT Wallet，ChatGPT 的智能體付款錢包 |
| 入口 | dots（OpenAI 9 月 29 日推出的常駐智能體） |
| 開放範圍 | 美國 ChatGPT Pro 訂戶，18 歲以上，持有美國發行的合格卡片 |
| 合作方 | American Express、Mastercard、Visa |
| 交易抽成 | 上線初期 OpenAI 不抽成（路透社報導） |

這是 ChatGPT 從「幫你找商品、比價格」跨到「幫你付錢」的關鍵一步。OpenAI 官方說法是：每週有 12 億人使用 ChatGPT，很多人用它研究商品、比較選項、決定買什麼，Wallet 補上的是最後一段路——在對話裡直接完成購買。同一天 OpenAI 還發布了給商家的《Commerce Partner Playbook》，教網站如何接待用智能體來購物的顧客。

## 一筆消費怎麼完成

官方公告把流程寫得很具體，分四步：

1. **綁卡一次**：用戶在 Wallet 裡加一張卡，之後不用每次重輸卡號。
2. **逐筆確認**：每次購買前，用戶先看商品、總金額和選用的卡，再以 Face ID 或指紋等安全檢查批准。沒有這一步，智能體付不了錢。
3. **發一代碼化憑證**：批准後，支付網絡發出一個付款憑證——一組替代真實卡號的卡號、安全碼與有效期。商家與智能體都看不到用戶的真實卡號。
4. **照常扣款**：款項記在用戶選定的卡上，原有的卡片回饋與爭議保障（例如商品有瑕疵時申訴）仍然保留，用戶與商家直接交易，商家繼續掌握定價、出貨、退貨與客服。

OpenAI 強調，Wallet 不是銀行帳戶、不持有用戶資金、也不提供信用額度。它只是把「授權」與「卡號」拆開：智能體拿得到授權結果，拿不到卡本身。

## 未來會更放手，但現在還不行

官方公告明確寫了路線圖：未來用戶可以預先設定參數——消費上限、允許的商品類別、授權時段——再把購買完全交給智能體，配合更強的保障措施。但**上線初期每一筆都要用戶親自批准**，沒有「先授權、事後再看」的模式。換句話說，現在的 Wallet 是「你點頭它才付」，不是「它自己決定花你的錢」。

## 商家端是真正的考驗

OpenAI 坦承，智能體商務還在早期。很多網站與支付風控系統還沒適應「來買東西的是 AI 智能體」這種模式，可能無意中攔截 Wallet 的付款，或把合法的智能體訂單判定為可疑交易。為此 OpenAI 同步做了三件事：發布商家 playbook、推動網站用 Web Bot Auth 識別已簽名的智能體請求、與 Forter、Riskified、Sardine、Signifyd 等反欺詐夥伴，以及 Adyen、Checkout.com、Stripe 等支付服務商合作，讓風控系統認得出合法的智能體購買。

這意味著 Wallet 能不能真的好用，不只看 OpenAI，還要看商家與銀行接不接受。官方說法是先以有限範圍上線，從真實使用中學習，再與商家、銀行與支付網絡一起擴大覆蓋。

## 對普通用戶意味著什麼

- **智能體正式碰錢了**：從查資料、比價到結帳，ChatGPT 的工作鏈路第一次完整閉環。這是整個行業都在試的方向，OpenAI 是第一個由卡組織背書、大規模推出的。
- **安全設計比便利更重要**：逐筆授權加代碼化憑證，意味著即使智能體被騙、被注入惡意指令，也拿不到你的卡號、也繞不過你那一下確認。這是這次發布最值得肯定的部分。
- **短期內與大多數人無關**：美國 Pro 訂戶、美國卡、dots 入口，三重門檻。免費版與 Plus 用戶、美國以外的用戶都還在排隊，官方沒有給出擴大範圍的時間表。
- **留意「商家不認」的摩擦**：初期可能出現智能體下單被網站攔截、或被風控拒絕的情況，這是 OpenAI 自己承認的風險，不是個別故障。

## 國內用戶注意

這部分要講清楚、不要誤導：ChatGPT Wallet **目前只在美國向 Pro 訂戶開放**，要求美國居住地址與美國發行的卡片，**國內用戶目前用不上，官方也沒有公布向其他國家擴展的時間表**。本文依據 OpenAI 官方公告與路透社報導整理（查閱於 2026-11-14），沒有親自測試，國內可用性未證實。

## 参考来源

- [OpenAI 官方公告：Introducing ChatGPT Wallet](https://openai.com/index/introducing-chatgpt-wallet)：發布內容、運作流程、開放範圍、商家 playbook（查閱於 2026-11-14）
- [路透社：OpenAI launches ChatGPT Wallet, letting AI agents pay for purchases](https://www.reuters.com/technology/openai-launches-chatgpt-wallet-letting-ai-agents-pay-purchases-2026-11-13/)：上線時間、Pro 訂戶限定、合作卡組織、上線初期零抽成（查閱於 2026-11-14）
- [CNBC：OpenAI launches ChatGPT Wallet, allowing its 'dots' AI agents to make purchases for users](https://www.cnbc.com/2026/11/13/openai-chatgpt-wallet-dot-purchases.html)：發布時間（美東 11 月 13 日上午 10 點）與 dots 入口（查閱於 2026-11-14）

## 核驗記錄

- 核對日期：2026-11-14。發布時間、開放範圍、運作流程與合作方以 OpenAI 官方公告為準；零抽成與發布時間見路透社與 CNBC 報導。
- 「12 億人每週使用 ChatGPT」為 OpenAI 官方說法，未經獨立驗證。
- 國內可用性未證實：官方只說初期限美國 Pro 訂戶，本文不作「國內能用」的推斷。

## 相關閱讀

- [AI前沿動態](/categories/ai前沿動態/)：本分類全部文章。
- [ChatGPT 完全指南](/posts/chatgpt-guide/)：ChatGPT 各版本功能、訂閱方案與使用技巧總整理。
- [ChatGPT、Claude、Gemini 國內開通總綱](/posts/chatgpt-claude-gemini-china-access-guide/)：國內用戶開通海外 AI 服務的總整理。
- [OpenAI GPT-6 Cyber 發布：專攻網絡安全](/posts/gpt-6-cyber-launch/)：OpenAI 11 月初發布的安全向模型，只開放給獲批客戶。
