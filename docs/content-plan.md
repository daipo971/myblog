# 欣淇AI网 内容长期规划

制定于 2026-10-27。规则部分见根目录 [CLAUDE.md](../CLAUDE.md)，本文件记录现状、方向和路线图进度。
完成一项就把 `[ ]` 改成 `[x]` 并写上日期。

## 2026-10-27 现状

| 指标 | 数值 |
| --- | --- |
| 已发布文章 | 144（另 3 篇草稿） |
| 英文文章 | 2（best-free-ai-tools-2026、chatgpt-4o-free-guide-2026） |
| 发文节奏 | 7 月 96 篇，8–9 月 0 篇，10 月 51 篇 |
| 无分类 | 84 篇；已有分类 17 个，多数只有 1 篇 |
| 无站内链接 | 81 篇 |
| 有图片 | 2 篇 |
| 无外部来源链接 | 78 篇（10 月快讯 51 篇里 46 篇没有来源） |
| 有 FAQ | 17 篇 |
| 正文不足 1000 字 | 42 篇 |

## 核心问题

1. **同题重复**：8 组文章抢同一批关键词（下表）。
2. **结构松散**：分类混乱，没有主题中心页，robots.txt 屏蔽了 /categories/ 与 /tags/。
3. **时效内容过多**：快讯一两周后就没有搜索量；大量网址带「-2026」。
4. **完整度不足**：几乎没有截图，快讯没有一手来源，教程缺少 FAQ 和报错处理。
5. **信任信号弱**：关于页没有作者信息；部分标题的「用了半年」与发布时间不符。
6. **英文空白**。

## 重复文章合并表

| 主题 | 重复文章 | 处理 |
| --- | --- | --- |
| ChatGPT / Claude / Cursor 对比 | ai-tools-comparison-2026、chatgpt-vs-claude-vs-cursor-guide、claude-vs-chatgpt-2026 | 保留 chatgpt-vs-claude-vs-cursor-guide |
| 免费 AI 工具 | free-ai-tools-2026、7-free-ai-tools-2026 | 保留 free-ai-tools-2026 |
| 免费 AI API | free-ai-api-guide、2026-10-08-free-ai-api-guide | 保留 free-ai-api-guide |
| Cursor 教程 | cursor-ai-tutorial-2026、cursor-programming-tools | 保留 cursor-programming-tools |
| Muse 注册 | 2026-10-14-muse-register-guide、2026-10-14-muse-register-oct14、2026-10-16-muse-facebook-register、2026-10-21-muse-china-user-guide | 保留 2026-10-21-muse-china-user-guide 作总纲 |
| AI Agent / 工作流 | ai-agent-complete-guide-2026、ai-agent-workflow-guide-2026、ai-workflow-guide-2026 | 概念一篇 + n8n 实操一篇 |
| 模型优化泛论 | ai-model-optimization-2026、ai-inference-optimization-guide、ai-training-optimization-2026、ai-deployment-optimization-guide、ai-model-quantization-guide | 合并为一篇 |
| 同一模型多篇快讯 | Reflection Beam、MiniMax M3.1、Kimi K3.1、Step 5、国行 Apple Intelligence | 合并成模型档案页 |

## 四个支柱

| 分类 | 变现 | 要补的选题 |
| --- | --- | --- |
| 中国与开源模型 | 广告、API 联盟、品牌 | 每个模型一个档案页；月度中国模型 API 价格表；开源模型本地部署实测 |
| AI工具实测 | 联盟链接 | 按场景的工具组合；每季度更新的对比表；编程工具长期追踪 |
| 海外服务通关（仅中文） | shop.xinqai.com | ChatGPT / Claude / Gemini 国内开通总纲；封号与申诉汇总；支付方式对比 |
| 建站与副业 | VPS 佣金 | 本站真实数据复盘；用 Claude Code 搭站实录 |

## 路线图

### 第 1 阶段：整理存量（2026 年 11 月上半月）

- [x] 合并重复文章 5 组（11 篇），旧网址 301（PR #3，2026-10-28）；Agent/工作流组和同一模型快讯组移到第 2 阶段
- [x] 17 个分类收敛为 4 个，给所有文章补分类（PR #3）
- [x] 给无 description 的文章补描述（PR #3）
- [x] 给 71 篇无内链文章加「相关阅读」（PR #3）
- [x] 敏感内容：两篇草稿不发，「白嫖」「无限」类标题改写（PR #3）
- [x] 重写关于页（PR #3）

### 第 2 阶段：主题结构 + 英文首批（2026 年 11 月下半月至 12 月）

- [ ] 4 个支柱中心页
- [ ] 合并 AI Agent / 工作流三篇（概念一篇 + n8n 实操一篇）
- [ ] 模型档案页：Kimi、MiniMax、Step、Reflection Beam、DeepSeek
- [ ] 英文第一批 10 篇（模型档案页）——英文分支负责
- [ ] 「ChatGPT / Claude / Gemini 国内开通总纲」
- [ ] 给 10 月快讯补一手来源链接
- [ ] 给流量最高的 10 篇教程补截图

### 第 3 阶段：扩张与复盘（2027 年 1–3 月）

- [ ] 英文第二、三批
- [ ] 标题写「2026」的常青文章更新为 2027（网址不动）
- [ ] 每月用 Search Console / Bing Webmaster 数据找「有展现无点击」的页面优化
- [ ] 按数据决定英文端投入和支柱调整

## 衡量指标（每月看一次）

收录页数（中 / 英）、自然搜索点击与展现（按支柱、语言拆分）、英文流量占比、商城与联盟点击。
