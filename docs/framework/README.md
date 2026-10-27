# 欣淇AI网 运营框架

制定于 2026-10-28。这套文档是网站的「总设计图」：定位、选题、结构、写作、SEO、运营、变现、数据、AI 执行方法都在这里。
以后不管是站长本人、Claude 还是其他 AI 接手，都先读这里，再动手。

## 文档之间的关系

| 层级 | 文件 | 作用 | 多久改一次 |
| --- | --- | --- | --- |
| 规则 | [CLAUDE.md](../../CLAUDE.md) | 必须遵守的硬规则：分类、文件名、front matter、完整度标准、禁止事项 | 很少改，改动要站长同意 |
| 框架 | `docs/framework/`（本目录） | 为什么这样做、怎么做、做到什么程度 | 每季度复盘时调整 |
| 计划 | [docs/content-plan.md](../content-plan.md) | 当前阶段的任务和进度 | 每次完成任务就更新 |
| 选题库 | [backlog.md](backlog.md) | 待写选题，按优先级排好，AI 直接从这里领任务 | 随时增删 |

冲突时的优先级：站长在对话里的最新指示 > CLAUDE.md > 本框架 > content-plan.md > WORKFLOW.md（旧文件，已过时）。

## 目录

| 编号 | 文件 | 回答的问题 |
| --- | --- | --- |
| 01 | [定位与目标](01-positioning.md) | 网站为谁服务、和别人有什么不同、三年后要成为什么 |
| 02 | [AI 全领域选题地图](02-topic-map.md) | AI 有哪些方面、每个方面写什么、归哪个支柱、先写哪个 |
| 03 | [分类、标签与网址体系](03-taxonomy.md) | 分类怎么分、标签用哪些、系列和档案页怎么组织 |
| 04 | [内容类型与模板](04-content-system.md) | 有哪几种文章、每种长什么样、怎么从快讯沉淀成常青内容 |
| 05 | [SEO 与站点架构](05-seo.md) | 关键词怎么找、内链怎么织、怎么避免自己抢自己的排名 |
| 06 | [运营流程](06-operations.md) | 每天、每周、每月做什么；信息源从哪来；怎么分发 |
| 07 | [变现体系](07-monetization.md) | 靠什么赚钱、链接怎么放、每个支柱对应哪种收入 |
| 08 | [数据与复盘](08-metrics.md) | 看哪些指标、每月怎么复盘、什么情况下更新/合并/删除文章 |
| 09 | [AI 执行手册](09-ai-playbook.md) | AI 接到任务后一步一步怎么做、哪些必须交给站长 |
| 10 | [路线图](10-roadmap.md) | 2026 Q4 到 2027 年底分几个阶段、每阶段的目标 |
| 11 | [风险与合规](11-risk-compliance.md) | 哪些内容不能写、版权、披露、平台条款、账号安全 |
| — | [选题库](backlog.md) | 具体要写的文章清单 |

## 配套工具

| 工具 | 位置 | 用法 |
| --- | --- | --- |
| 文章模板 | `archetypes/` | `hugo new content --kind news posts/<slug>.md`，kind 可选 news / tutorial / review / profile / guide / explainer |
| 发文自检脚本 | `scripts/lint_posts.py` | `python3 scripts/lint_posts.py content/posts/<slug>.md`，不传参数则检查相对 main 改动过的文章 |

## 给 AI 的最短上手路径

1. 读 CLAUDE.md（硬规则）。
2. 读 [09-ai-playbook.md](09-ai-playbook.md)（执行步骤）。
3. 按任务类型查对应章节：写文章看 04 + 05，选题看 02 + backlog，复盘看 08。
4. 动手前查重，写完跑 `scripts/lint_posts.py` 和 Hugo 构建，再提 PR。
