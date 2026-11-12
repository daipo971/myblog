---
title: "Qwen4-Max 預覽上線：百萬上下文、只開 15 天"
date: 2026-11-12T09:30:00+08:00
lastmod: 2026-11-12T09:30:00+08:00
draft: false
categories: ["中国与开源模型"]
tags: ["快讯", "国产大模型", "AI编程", "通义千问"]
description: "阿里巴巴 11 月 11 日開放 Qwen4-Max 預覽：Qwen 旗艦，100 萬 token 上下文、圖文影片都能吃，僅限 Token Plan 訂閱與自家 App 體驗，11 月 25 日到期下線。跑分、參數與正式版日期都還沒公布。"
showtoc: true
---

先給結論：**阿里巴巴在 11 月 11 日開放了 Qwen4-Max 的預覽**。這是新一代 Qwen4 家族第一個能實際用到的模型，定位是旗艦：100 萬 token 上下文、圖文影片三種輸入、思考模式預設開啟。但要注意三個限制：第一，這只是**為期 15 天的預覽**，11 月 25 日到期後模型直接下線；第二，API 只能走 Token Plan 訂閱，沒有按量付費；第三，跑分、參數量、正式版日期一概還沒公布，現在只能試手感，不能當生產工具。

![插畫：一群發光的鳥飛越深夜的海面，隊形化作一條躍起的巨魚，象徵 Qwen4 的到來](/images/qwen4-max-preview-launch/cover.webp)

## 這次上線了什麼

Qwen4 這個名字早在 9 月 22 日的雲棲大會上就出現過，當時 Qwen 團隊負責人只說新一代架構正在訓練，沒給任何規格與日期。11 月 6 日官方帳號又發了一張預熱海報：一群鳥飛越暗海、隊形化作一條魚，配文「The becoming begins」，同樣沒點名、沒給日期。

11 月 11 日上午 10 點，謎底揭開。Qwen 官方帳號發文「Qwen4 is coming」，宣布 Qwen4-Max 即日起開放預覽，同時上線的還有阿里雲 Model Studio 的官方模型文件。根據[阿里雲 Model Studio 官方文件](https://help.aliyun.com/en/model-studio/qwen4-max-preview)，Qwen4-Max-Preview 是「Qwen 家族新一代旗艦多模態模型」，主攻複雜寫碼、專業知識工作、前端開發與多步驟 Agent 任務。官方列出的四項提升是：知識更深、對世界的理解更豐富、寫碼更強、Agent 能力更強——但這些都是廠商自己的說法，**目前沒有任何跑分或第三方評測可以佐證**。

要分清的是：上線的是 Qwen4-Max 這一個型號的預覽版，不是整個 Qwen4 家族。官方已命名的四個檔位是 Max、Plus、Flash 與 27B 開放權重版，後三者連日期都還沒有。正式版什麼時候來，官方也沒說。

## 規格：只公布了這幾項

官方文件寫得很短，能確認的規格只有這些：

| 項目 | 官方公布的內容 |
| --- | --- |
| 模型 ID | `qwen4-max-preview`，別名 `qwen4.0-max-preview` |
| 上下文 | 100 萬 tokens |
| 最大輸出 | 393,216 tokens，思考過程與最終答案共用這個額度 |
| 輸入 | 文字、圖片、影片 |
| 思考模式 | 預設開啟，可用 `reasoning_effort` 調整強度 |
| 工具調用 | 支援 Function Calling、聯網搜尋、內建工具、JSON Schema 結構化輸出 |
| API 相容 | OpenAI Chat Completions、OpenAI Responses、Anthropic Messages 三種格式 |

100 萬上下文是這次最實在的數字：整個大型程式碼庫或幾百頁技術文件可以一次餵進去。393,216 的輸出上限也很大，但要留意它是思考與答案共用的——思考花得多，留給答案的就少。影片輸入最長可達 2 小時、單檔 2GB，但這只是「能收」的上限，不代表長影片的理解一定準。

## 從哪裡用、多少錢

入口分兩條線，規則差很多：

- **一般使用者：Qwen App / Qwen Chat**。在 Qwen Chat（chat.qwen.ai）的模型選單裡已經能選到 Qwen4-Max-Preview，直接打字就能試，不用訂閱 Token Plan。QwenWork、Qoder、QwenStudio 也同步開放早期體驗。
- **開發者 API：只走 Token Plan**。官方文件寫明「僅限 Token Plan，不支援按量付費」，普通 Model Studio 的 API Key 打不開這個模型，要用 Token Plan 的專用 Base URL 與專用 Key。Token Plan 是包月訂閱制、按 Credits 扣費：個人版每月 6 美元（Lite）、10 美元（Essential）、18 美元（Standard）、43 美元（Pro），新用戶限時優惠 Lite 3 美元、Essential 5 美元起；團隊版每席每月 20、75、180 美元三檔。

Token Plan 的使用限制也要先講清：官方文件規定它只供在 IDE、寫碼輔助工具、Agent 等互動式場景使用，**禁止用自動化腳本批量處理、禁止當作自家應用的固定後端**。也就是說，這 15 天是讓你拿真實工作試手感、比對它和現用模型的差距，不是讓你把生產系統遷過去。預覽期內模型不會有任何改動，11 月 25 日 24 點一到就下線，之後能不能續用、按量付費怎麼定價，都要等正式版消息。

## 還沒公布的東西

這次發布「沒說的」比「說了的」更值得留意：

- **沒有跑分**：官方與第三方都還沒有任何基準成績，寫碼準不準、長上下文會不會「中間遺忘」，只能自己試。
- **沒有參數量與架構**：8 月底開源的 Qwen3.8-Flash-Next 被描述為下一代架構的早期預覽，但官方沒有確認 Qwen4-Max 是否用同一架構。
- **沒有權重與許可證**：Hugging Face 上的 Qwen 官方組織目前還沒有任何 Qwen4 倉庫。
- **沒有按量價格與正式版日期**：Token Plan 的 Credits 消耗也因模型、思考量與工具調用次數而異，實際能跑多少任務要試了才知道。

## 對一般使用者意味著什麼

- **不用急著付費**：想試手感先走 Qwen App / Qwen Chat，免費入口就能摸到模型本身。Token Plan 是給開發者接寫碼工具用的，一般使用者暫時不需要。
- **開發者可以拿這 15 天做對比**：重點試四件事——讀懂並改動大型程式碼庫、Agent 調用工具的順序對不對、長文件與多圖的抽取準不準、JSON Schema 格式守不守得住。拿同一批任務和現用模型對比，記下失敗率與 Credits 消耗。
- **別把正式工作押上去**：預覽模型 11 月 25 日就下線，設定與流程到時都要重接。等正式版的規格、定價與商用條款公布後，再決定要不要換。
- **同週旗艦扎堆**：就在前一天，Google 剛把 [Gemini 4 Carbon 全面開放](/posts/gemini-4-carbon-public-release/)，Anthropic 的 [Claude Fable 5.2 也才發布兩天](/posts/claude-fable-mythos-5-2-launch/)。Qwen4-Max 選在同一週開預覽，頂級模型的正面對決已經從海外燒到國產。

## 國內使用者注意

Qwen 是阿里巴巴的模型，Qwen App 與 Qwen Chat 在國內可以直接用，體驗 Qwen4-Max-Preview 不需要海外帳號。API 這條線則不同：Token Plan 是美元計價的訂閱制，僅限 Token Plan 訂閱才能調用，實際到手成本還要看付款方式與匯率；各入口的額度與可用性以官方頁面與 App 內實際顯示為準，本文不作超出官方說法的推斷。預覽 11 月 25 日到期後若想繼續用，只能等正式版。

## 参考来源

- [阿里雲 Model Studio 官方文件：qwen4-max-preview](https://help.aliyun.com/en/model-studio/qwen4-max-preview)：模型定位、規格、預覽期限與 Token Plan 限制（查閱於 2026-11-12）
- [Qwen 官方 X 貼文：Qwen4 is coming](https://x.com/Alibaba_Qwen/status/2120335993643684315)：11 月 11 日發布公告，預覽入口為 Token Plan、QwenWork、Qoder、Qwen App 與 QwenStudio（查閱於 2026-11-12）
- [QwenCloud 官方 Token Plan 頁面](https://qwencloud.com/pricing/token-plan)：訂閱方案與價格（查閱於 2026-11-12）

## 核验记录

- 核對日期：2026-11-12。發布時間、規格、預覽期限與使用限制以阿里雲官方文件與 Qwen 官方貼文為準。
- 官方宣稱的四項能力提升（知識、世界理解、寫碼、Agent）目前沒有跑分或第三方評測佐證，本文只轉述官方說法。
- 預覽 11 月 25 日到期下線、期間不做任何改動，為官方文件原話；正式版日期、按量價格、參數量與許可證均未公布，本文不作推測。

## 相关阅读

- 更多中国与开源模型：[/categories/中国与开源模型/](/categories/中国与开源模型/)
- [通義千問 Qwen 模型檔案](/posts/qwen-guide/)：Qwen3.8 版本、價格、許可證與國內用法，Qwen4 進展會同步更新到這頁。
- [中國大模型 API 價格表](/posts/china-llm-api-pricing/)：國產旗艦模型輸入輸出價對照。
- [Gemini 4 Carbon 全面開放：價格與入口](/posts/gemini-4-carbon-public-release/)：Google 最強模型前一天全面開放，入門價只到 11 月 30 日。
- [Claude Fable 5.2 發布：更快、更便宜](/posts/claude-fable-mythos-5-2-launch/)：Anthropic 新旗艦，同週發布的另一位對手。
