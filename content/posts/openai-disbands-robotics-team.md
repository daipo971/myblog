---
title: "OpenAI 解散機器人團隊：通用模型接手"
date: 2026-11-14T21:10:00+08:00
lastmod: 2026-11-14T21:10:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "OpenAI"]
description: "Fortune 11 月 13 日獨家、OpenAI 發言人證實：獨立機器人團隊解散，研究併入主研究團隊、硬體併入 Applied 部門。理由是 GPT-6 Astra 等通用模型已能直接開機器人，人形演示仍以 2027 年為目標。"
showtoc: true
---

先說結論：**OpenAI 解散了獨立的機器人團隊**。Fortune 11 月 13 日獨家報導、OpenAI 發言人證實：研究人員併入首席研究官 Mark Chen 的主研究團隊，應用機器人與硬體團隊併入總裁 Greg Brockman 的 Applied 部門。理由很直接——GPT-6 Astra 這類通用模型已經能直接開機器人，不必再養一個專門做「機器人大腦」的團隊。這是 OpenAI 第二次解散機器人團隊，但發言人強調機器人仍是長期願景，人形機器人演示仍以 2027 年為目標，不是放棄。

![插畫：人形機器人身影逐漸化作神經網路節點與數據流，象徵通用模型接手機器人控制](/images/openai-disbands-robotics-team/cover.webp)

## 發生了什麼

| 項目 | 內容 |
| --- | --- |
| 報導方 | Fortune（11 月 13 日獨家），OpenAI 發言人證實 |
| 變動 | 獨立機器人團隊解散 |
| 人員去向 | 研究團隊 → 首席研究官 Mark Chen 的主研究團隊；應用機器人與硬體團隊 → 總裁 Greg Brockman 的 Applied 部門 |
| 官方理由 | GPT-6 Astra 等通用模型已能直接用於機器人控制 |
| 後續目標 | 人形機器人演示仍以 2027 年為目標 |

## 為什麼是現在：一個模擬基準改寫了路線

觸發這次改組的數字，來自 NVIDIA 研究團隊 10 月 14 日的一項研究。研究人員把 GPT-6 Astra 當作機器人控制器，放到模擬操作基準 RoboLab-120 上測試——沒有做任何針對機器人的專門訓練，成功率 74.8%，對照組裡表現最好的專用機器人模型只有 51.0%。

這個對比要寫準：**74.8% 是模擬成績，不是實體機器人的實測**。RoboLab-120 是模擬的抓取放置基準，測的是模型在模擬環境裡完成操作任務的能力，不能直接等同於真機表現。Fortune 報導裡引用的成本也不低：每次嘗試約 36.4 美元 token 費用、每次模型呼叫約 18.56 秒——離即時控制還有距離。

但方向已經很清楚：OpenAI 內部原先假設要靠影片模型打底再做機器人，後來發現通用前沿模型直接就能用，專門團隊的邊際價值就沒了。

## 不是第一次：OpenAI 的機器人團隊來來去去

這是 OpenAI 第二次關掉機器人團隊，時間線值得寫下來：

- **2020 年**：OpenAI 關掉第一代機器人團隊，當時共同創辦人 Wojciech Zaremba 給出的理由是機器人數據太少，換條路更划算。
- **2024 年**：重建獨立機器人團隊，並宣布與 Figure 合作開發人形機器人模型。
- **2026 年 11 月 13 日**：再度解散，團隊併入主研究團隊與 Applied 部門。

兩次解散的理由正好相反：第一次是「數據不夠、做不動」，這次是「通用模型已經夠用、不必單獨做」。同一批人沒有離開公司，只是換了匯報線——這也是發言人強調「加速、不是收縮」的原因。

## 邊界要說清

- **沒有官方部落格**：OpenAI 自己沒有為這次改組發公告，也沒有公布受影響人數，所有細節都來自 Fortune 的報導與發言人回應。
- **不是放棄機器人**：發言人向 Fortune 表示，機器人仍是公司長期願景的一部分，人形機器人演示仍以 2027 年為目標。
- **財務數字是 Fortune 口徑**：同篇報導稱 OpenAI 上季營運虧損 109 億美元、可能 2027 年初 IPO——這是 Fortune 的說法，OpenAI 未在本次回應中確認。

## 對普通用戶意味著什麼

- **短期沒有產品變化**：這是組織調整，沒有新產品、也沒有產品下線。普通用戶今天打開 ChatGPT 不會看到任何不同。
- **長期看，機器人可能來得更快、也更「通用」**：如果通用模型真的能直接開機器人，人形機器人的門檻就從「專門訓練」變成「模型夠不夠強」。2027 年的人形演示是下一個驗證點。
- **別把模擬成績當實機成績**：74.8% 對 51.0% 聽起來差距很大，但那是模擬環境、且成本與延遲都還很高。寫給讀者時要留這個保留。

## 國內用戶注意

這次改組對國內用戶沒有直接影響：沒有產品上下線、沒有服務範圍變化，ChatGPT 與相關服務的國內使用方式不變。本文依據 Fortune 獨家報導的二次整理（查閱於 2026-11-14），Fortune 原文為付費獨家，細節來自授權引述的整理報導；OpenAI 未發布自己的公告，國內可用性未變。

## 参考来源

- [ExplainX：OpenAI Disbands Robotics Team: GPT-6 Astra Bet](https://explainx.ai/blog/openai-disbands-robotics-team-gpt-6-astra-robots-fortune-2026)：Fortune 獨家內容整理、人員去向、RoboLab-120 數據（查閱於 2026-11-14）
- [Dev.to：OpenAI Disbanded Its Robotics Team. GPT-6 Astra Is the Robot Now](https://dev.to/paullovelace/openai-disbanded-its-robotics-team-gpt-6-astra-is-the-robot-now-3678)：改組細節、模擬基準說明（查閱於 2026-11-14）
- [PakTechStan：OpenAI Disbands Its Standalone Robotics Team](https://paktechstan.com/openai-disbands-its-standalone-robotics-team-betting-gpt-6-astra-can-run-robots-on-its-own)：時間線、2027 年演示目標（查閱於 2026-11-14）

## 核验记录

- 核對日期：2026-11-14。改組事實與人員去向以 Fortune 報導（經二次整理交叉確認）為準；OpenAI 未發布官方公告、未公布受影響人數。
- 74.8% 對 51.0% 是 NVIDIA 研究的模擬基準 RoboLab-120 成績，不是實體機器人實測；每次嘗試成本與延遲為研究報導數據。

## 相关阅读

- [OpenAI GPT-6 Cyber 发布：专攻网络安全](/posts/gpt-6-cyber-launch/)：OpenAI 11 月初發布的安全向模型。
- [智元 GO-3 Preview：具身基座模型年底开源](/posts/agibot-go-3-preview-launch/)：國內具身智能的最新進展。
- [OpenAI 又发新模型 GPT-6.1 Terra：不拼最强，拼每干一件事花多少钱](/posts/2026-10-27-gpt-6-1-terra-launch/)：OpenAI 上一款模型發布。
- 更多前沿動態見 [AI前沿动态](/categories/ai前沿动态/)。
