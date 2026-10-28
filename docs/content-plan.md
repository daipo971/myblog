# 欣淇AI网 内容长期规划

制定于 2026-10-27。规则部分见根目录 [CLAUDE.md](../CLAUDE.md)，完整运营框架见 [docs/framework/](framework/README.md)，本文件记录现状、方向和当前阶段进度。
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

## 支柱（2026-10-28 起为六个，详见 [选题地图](framework/02-topic-map.md)）

| 分类 | 变现 | 要补的选题 |
| --- | --- | --- |
| 中国与开源模型 | 广告、API 联盟、品牌 | 每个模型一个档案页；月度中国模型 API 价格表；开源模型本地部署实测 |
| AI工具实测 | 联盟链接 | 按场景的工具组合；每季度更新的对比表；编程工具长期追踪 |
| 海外服务通关（仅中文） | shop.xinqai.com | ChatGPT / Claude / Gemini 国内开通总纲；封号与申诉汇总；支付方式对比 |
| 建站与副业 | VPS 佣金 | 本站真实数据复盘；用 Claude Code 搭站实录 |
| AI应用场景（新） | 工具联盟、广告 | 新手入门路线、科普系列、办公场景系列、按人群的工具组合 |
| AI前沿动态（新，仅中文） | 广告、Telegram | 海外大厂模型时间线、重大事件快讯、AI 硬件与政策 |

## 路线图

### 第 1 阶段：整理存量（2026 年 11 月上半月）

- [x] 合并重复文章 5 组（11 篇），旧网址 301（PR #3，2026-10-28）；Agent/工作流组和同一模型快讯组移到第 2 阶段
- [x] 17 个分类收敛为 4 个，给所有文章补分类（PR #3）
- [x] 给无 description 的文章补描述（PR #3）
- [x] 给 71 篇无内链文章加「相关阅读」（PR #3）
- [x] 敏感内容：两篇草稿不发，「白嫖」「无限」类标题改写（PR #3）
- [x] 重写关于页（PR #3）
- [x] 全站合规审计与清理（2026-10-28）：约 60 篇 7 月文章删除编造的经历、数据和评分，改为客观写法；修正已停服产品（Sora、Tome）和过时模型名；删除 22 篇不实的联盟声明；下线内容虚假的「7 月 AI 工具更新」并 301；问题和改写流程写入 [踩坑清单](framework/12-pitfalls.md)，lint 增加对应检查
- [x] 补厚仍未达标的文章（2026-10-28，PR #17）：iPhone Duo eSIM、Muse 风控申诉、AI 自动化工具、AI 无代码、Cloudflare Pages、Codex 指南、免费域名、Linux 入门、SEO 指南全部达标；Muse 邀请码文章注明站长邀请码。剩余 lint ERROR 只在待站长决定的 10 篇偏离定位文章
- [ ] 10 篇偏离定位的技术文（Rust、高并发、量化等）：等站长决定下线 301 还是保留补全

### 第 2 阶段：主题结构 + 英文首批（2026 年 11 月下半月至 12 月）

- [x] 4 个支柱中心页（PR #5，2026-10-28）
- [x] AI Agent / 工作流三篇：检查后不合并（概念与框架、n8n 实操、现成工具组合是三种不同搜索意图），改为互相链接
- [x] 模型档案页：kimi-guide、minimax-guide、stepfun-step-guide、reflection-beam-guide，DeepSeek 在完全指南里加版本档案（PR #6）
- [ ] 英文第一批 10 篇（模型档案页）——英文分支负责
- [x] 「ChatGPT / Claude / Gemini 国内开通总纲」：chatgpt-claude-gemini-china-access-guide（PR #7）
- [~] 给 10 月快讯补一手来源链接（2026-10-28 第一批：Kimi K3.1 Pro、MiniMax M3.1 Flash、Step-5、Reflection Beam、DeepSeek V4.1 Flash 共 9 篇 + Google Play 改区教程，加「参考来源」小节；其余快讯待补，GPT-6.1 Terra 暂无可靠来源不加）
- [ ] 给教程补截图（需要站长实际操作截图，清单见下文「待补截图」）
- [x] 运营框架 docs/framework/（12 份文档）+ 文章模板 archetypes/ + 自检脚本 scripts/lint_posts.py、scripts/check_links.py（2026-10-28）
- [x] 分类由四个扩为六个（新增 AI应用场景、AI前沿动态），30 篇文章迁移，新建两个中心页（2026-10-28，站长确认）
- [ ] 标签清理：按 data/taxonomy.yaml 归并旧标签、补类型与主题标签（框架 SOP-7，分批）
- [ ] 新手从这里开始（/start/）、AI 术语表、中国模型 API 价格表（见 framework/backlog.md S01、S02、C05）
- [ ] 档案页 Qwen、GLM、豆包、可灵（backlog C01–C04）

### 第 3 阶段：扩张与复盘（2027 年 1–3 月）

- [ ] 英文第二、三批
- [ ] 标题写「2026」的常青文章更新为 2027（网址不动）
- [ ] 每月用 Search Console / Bing Webmaster 数据找「有展现无点击」的页面优化
- [ ] 按数据决定英文端投入和支柱调整

## 待补截图

截图需要真实操作界面，由站长提供。放在 `static/images/<slug>/`，用 webp，每个关键步骤一张，并写 alt 文字。按优先级：

| 优先级 | 文章 | 需要截图的步骤 |
| --- | --- | --- |
| 1 | 2026-10-15-us-apple-id | App Store 入口、地区选择、付款方式选「无」、验证完成 |
| 1 | 2026-10-15-google-play-region | 手机端与电脑端改地区的入口和确认页 |
| 1 | 2026-10-15-us-apple-giftcard | 兑换入口、输入卡号、余额显示 |
| 1 | 2026-10-21-muse-china-user-guide | Airtap 主推路线每一步、兑码页、申诉页 |
| 2 | 2026-10-21-airtap-cloud-phone-tutorial | 注册、领取云手机、节点设置 |
| 2 | 2026-10-20-wise-guide | 开户流程、身份验证、开卡 |
| 2 | 2026-10-17-google-workspace-turkey-domain | 地区选择、域名购买、付款 |
| 2 | 2026-10-16-gate-card-tutorial | 开卡、充值、绑定 |
| 3 | free-blog-tutorial | VPS 控制台、域名解析、Cloudflare 设置 |
| 3 | cloudflare-pages-tutorial-2026 | 连接 GitHub、构建设置、自定义域名 |
| 3 | free-domain-guide | 注册、接入 Cloudflare |
| 3 | free-vps-guide | Oracle Cloud 注册与创建实例 |

## 衡量指标（每月看一次）

收录页数（中 / 英）、自然搜索点击与展现（按支柱、语言拆分）、英文流量占比、商城与联盟点击。
