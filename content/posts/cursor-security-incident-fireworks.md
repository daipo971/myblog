---
title: "Cursor 遭供應鏈攻擊：毒擴充套件進市集"
date: 2026-11-14T21:10:00+08:00
lastmod: 2026-11-14T21:10:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "AI安全", "行业动态", "Cursor"]
description: "Cursor 11 月 13 日公布調查：攻擊者用 Fireworks AI 外洩的金鑰，10 月 29 日把帶後門的 Claude Code 2.1.312／2.1.313 放上市集快取，11 小時內最多 5,000 人可能收到。"
showtoc: true
---

先說結論：**Cursor 在 11 月 13 日公布完整調查結果，10 月 29 日出現在官方擴充套件市集的帶後門 Claude Code 擴充套件，是一次供應鏈攻擊**。攻擊者先用 Fireworks AI 外洩的一枚金鑰偷到未塗銷的憑證，再把篡改過的 `Anthropic.claude-code` 2.1.312／2.1.313 放上 Cursor 市集的快取，約 11 小時後下架，最多 5,000 人可能收到。Anthropic 沒有發布這兩個版本，這也不是 Claude Code 本身的漏洞。如果你 10 月 29 日在 Cursor 市集裝過或更新過這兩個版本，照 Cursor 安全公告檢查——只解除安裝可能不夠。

![插畫：程式碼編輯器視窗前，一個帶警告標誌的擴充套件圖示，象徵市集快取被植入篡改版本](/images/cursor-security-incident-fireworks/cover.webp)

## 發生了什麼

| 項目 | 內容 |
| --- | --- |
| 公布方 | Cursor（Anysphere） |
| 公布時間 | 2026 年 11 月 13 日（完整事後報告） |
| 事件時間 | 2026 年 10 月 29 日（毒擴充套件上架） |
| 篡改版本 | `Anthropic.claude-code` 2.1.312／2.1.313（Windows 與 macOS） |
| 暴露窗口 | 約 11 小時（美西時間 10 月 29 日 2:27–13:35） |
| 影響人數 | 最多 5,000 名索取該快取版本的使用者可能收到 |
| 攻擊起點 | Cursor 發給 Fireworks AI 的存取金鑰遭外洩 |

## 攻擊鏈是怎麼走的

Cursor 的調查把整條鏈拼了出來，一共五步：

1. **起點在供應商**。攻擊者拿到一枚 Cursor 發給 Fireworks AI（訓練與推理供應商）的存取金鑰。按 Cursor 的說法，這枚金鑰是「被 Fireworks 外洩的」，攻擊者用它複製了一個唯讀共享儲存桶裡的資料——主要是 2025 年、非 Privacy Mode 會話的編碼 agent 紀錄，Cursor 原本允許用這些紀錄做模型訓練。
2. **紀錄裡有沒塗銷的憑證**。少數紀錄含有未經塗銷的憑證，不到 0.01% 的客戶有 API 憑證外洩；非 Privacy Mode 用戶的 agent 紀錄外洩比例不到 0.05%。攻擊者拿這些憑證進入 Cursor 的部分 SaaS 工具，進一步接觸到非生產環境的舊原始碼庫、客服資料與郵件對話、產品用量數據，以及用戶曾寄給客服團隊的憑證。
3. **毒擴充套件上架**。10 月 29 日，攻擊者用偷來的憑證，把篡改過的 Claude Code 擴充套件直接放到 Cursor VS Code 擴充套件市集的快取上。據安全媒體的技術分析，篡改版本會在擴充套件載入時執行注入的程式碼，不需要先開啟 Claude 對話。
4. **通知與清理**。10 月 30 日，Cursor 在部落格與 X 發布安全公告，附上入侵指標（IOC）、修復步驟與檢查腳本，並開始透過應用內通知與郵件聯繫受影響用戶與團隊管理員；憑證外洩的團隊會收到一份要輪換的金鑰清單。
5. **事件已受控**。Cursor 認為事件已經受控，最後一次觀測到的攻擊者活動是 11 月 1 日，且已被擋下。推理流量已全部移出 Fireworks，發給 Fireworks 的金鑰已停用，相關資料集的存取也已切斷。

## 三件事要先說清

這次事件很容易被寫錯，先把三個關鍵定性寫清楚：

- **Anthropic 沒有發布這兩個版本**。2.1.312／2.1.313 是攻擊者冒用 Anthropic 官方帳號名義放上快取的，Anthropic 自己的系統沒有被入侵。
- **不是 Claude Code 本身的漏洞**。問題出在 Cursor 市集的快取與被偷的憑證，不在 Claude Code 的程式碼。
- **市集源頭是乾淨的**。上游市集 Open VSX 從來沒有託管過惡意軟體，毒版本只出現在 Cursor 的快取裡。Cursor 已下線並重建整個市集，驗證過其他擴充套件都是真的。

沒受影響的部分，Cursor 也列得很細：Privacy Mode 用戶的提示詞與程式碼、正在傳輸的即時流量、生產系統、Cursor 應用程式與官方更新、客戶的程式碼倉庫、發布簽名金鑰，都不在這次事件裡。Cursor 的正式更新是從另一套程式碼託管系統發布的，攻擊者沒有碰到。

## 10 月 29 日裝過這兩個版本，該怎麼辦

如果你是 Cursor 用戶，先對照兩個條件：**10 月 29 日當天、在 Cursor 的 VS Code 擴充套件市集裡安裝或更新到 `Anthropic.claude-code` 2.1.312 或 2.1.313**。兩個都符合，就按 Cursor 10 月 30 日安全公告的步驟檢查與清理。Cursor 官方特別提醒：**只解除安裝擴充套件可能不夠**——公告附了檢查腳本，照著跑一遍再確認。

沒收到 Cursor 通知的用戶，資料不在外洩的紀錄裡，不必額外動作。已經收到通知的，按通知裡列的項目輪換金鑰。

## 同一起外洩，也波及 Notion

值得順帶一提的是，同一波 Fireworks 外洩也影響了 Notion。據報導，Notion 證實部分 Notion AI 對話紀錄外洩，涉及不到 1% 的工作區，多數紀錄未標註作者與工作區、且不含工具呼叫結果。Notion 已直接聯繫受影響客戶，沒收到通知就不必動作；如果收到了，把曾貼進 Notion AI 的密碼與金鑰輪換一遍。這條來自二次整理，未讀到 Notion 公告原文，寫在這裡是提醒同一供應商外洩的波及面不只一家。

## 對普通用戶意味著什麼

- **信任鏈比程式碼更脆弱**：這次沒有任何產品本身被攻破，破的是「供應商金鑰 → 共享儲存桶 → 市集快取」這條信任鏈。一把外洩的金鑰，最終變成 5,000 人可能收到的毒擴充套件。
- **市集快取也是攻擊面**：惡意軟體不一定要混進上游市集，放在快取裡就能發出去。Cursor 事後重建了整個市集並加強檢查，其他用類似架構的編輯器市集也會被拿來對照。
- **大多數人不用慌**：影響範圍很小（不到 0.05% 用戶的紀錄、最多 5,000 次毒版本發送），且事件已受控。關鍵是 10 月 29 日那個窗口期有沒有裝到那兩個版本。

## 國內用戶注意

Cursor 在國內有不少用戶，這次事件不分地區——只要 10 月 29 日在 Cursor 市集裡裝過那兩個版本，就在檢查範圍內。Cursor 的安全公告與檢查腳本在官網公開，照著做即可。本文依據 Cursor 官方公告與公開報導整理（查閱於 2026-11-14），沒有親自測試，國內可用性未變。

## 参考来源

- [Cursor 官方公告：An update on our recent security incident](https://cursor.com/blog/security-incident-update)：攻擊鏈、影響範圍、已採取措施（查閱於 2026-11-14）
- [Cyber Security News：Cursor Reveals How a Leaked Fireworks AI Key Led to a Backdoored Claude Code Extension](https://cybersecuritynews.com/cursor-data-breach/)：事件經過、5,000 人上限、11 小時窗口（查閱於 2026-11-14）
- [PakTechStan：Cursor Traces Its October Breach to a Leaked Fireworks Key](https://paktechstan.com/article/cursor-traces-its-october-breach-to-a-leaked-fireworks-key-closing-a-two-week-investigation)：調查結論整理（查閱於 2026-11-14）
- [AI Cyber Brief：Notion Fireworks AI breach（二次整理）](https://aicyberbrief.com/article/notion-fireworks-ai-breach-exposed-notion-ai-chat-transcripts-from-under-1-of-workspaces)：Notion 受影響情況（查閱於 2026-11-14）

## 核验记录

- 核對日期：2026-11-14。攻擊鏈、版本號、時間窗口與影響人數以 Cursor 官方公告為準；「被 Fireworks 外洩」是 Cursor 的說法，Fireworks 自己的安全公告未提及 Cursor。
- 篡改版本的具體行為（載入時執行注入程式碼）來自安全媒體的技術分析，非 Cursor 官方公告原文。

## 相关阅读

- [Cursor 使用指南：功能、价格、上手配置与常见坑](/posts/cursor-programming-tools/)：Cursor 的功能、訂閱與使用方式總整理。
- [2026年AI安全工具完全指南：从数据保护到模型安全](/posts/ai-security-tools-2026/)：常見 AI 安全工具與防護做法。
- [OpenAI GPT-6 Cyber 发布：专攻网络安全](/posts/gpt-6-cyber-launch/)：OpenAI 11 月初發布的安全向模型。
- 更多安全與研究動態見 [AI前沿动态](/categories/ai前沿动态/)。
