---
title: "Claude 上线 Sheets 和 Whiteboards"
date: 2026-11-12T14:15:00+08:00
lastmod: 2026-11-12T14:15:00+08:00
draft: false
categories: ["AI前沿动态"]
tags: ["快讯", "行业动态", "Claude"]
description: "Anthropic 11 月 10 日发布 Claude Sheets、Whiteboards 与 Claude Data：表格、白板、数据故事都能在 Claude 里直接做，全部付费计划可用。Meetings 还在路上，免费版没有。"
showtoc: true
---

先给结论：**Anthropic 在 11 月 10 日把 Claude 往办公套件的方向推了一大步——Claude Sheets 和 Claude Whiteboards 以 beta 形式上线，原来的 Claude Dashboards 转正为 Claude Data。**三样都在全部付费计划里能用，网页、桌面、手机端都有。注意两个别搞错的点：Claude Meetings 官方只说「即将推出」，还没上线；免费版不在这次范围内。同一周 Anthropic 还发了 [Claude Fable 5.2](/posts/claude-fable-mythos-5-2-launch/)，模型和办公工具两条线一起走。

![插画：白板上的便利贴与电子表格由一道光带连接，象征 Claude 把团队想法整理成文档](/images/claude-sheets-whiteboards-launch/cover.webp)

## Sheets：让 Claude 帮你做表

Sheets 是 Claude 按提示生成、并和你一起编辑的表格。一句「做个活动追踪表」或「做个招聘预算」，Claude 就能生成带多标签、公式、格式和下拉菜单的表格；它可以在单元格里直接改，每次改动都会标出来，方便你追踪变化；表格可以分享给团队，你和 Claude 一起改。

功能目前还比较基础，官方说更完整的功能在加。需要 Excel 的完整能力时，可以导出 .xlsx 或 CSV，也可以用 Claude for Excel；还能继续在 Airtable、Asana、monday.com、Smartsheet 这些合作工具里接着做。

## Whiteboards：和 Claude 一起头脑风暴

Whiteboards 是你和 Claude 共创的共享白板。以前和 Claude 头脑风暴完，得把结果复制粘贴到别处再开始；现在可以直接在白板上聊：你口头说一个乱糟糟的计划，Claude 帮你整理成带时间线、负责人和日期的看板；回顾会上大家各自贴笔记，Claude 按主题分组、给每个人起草行动项；想深挖白板的某一部分，框选它直接问 Claude 就行。

做完之后，白板可以转成文档或幻灯片，也可以导入 Lucid、Miro 或 Vani by Zoho，在团队熟悉的工具里继续。

## Data：原来的 Dashboards 转正了

Claude Data 就是 10 月 beta 的 Claude Dashboards，改名是因为用途已经不止仪表盘。功能包括：数据团队可以认证指标定义（beta），图表会带「已认证」标记；用数据写故事、做成带解说的短视频；实时共享（beta），同事打开共享看板就能看到最新数字；还支持设计系统、缓存、按看板设置刷新频率和修改记录。

前提是接数据连接器，比如数据仓库或 CRM（官方举例 Amazon Redshift、BigQuery、ClickHouse、Snowflake、Salesforce）。合作方包括 Amplitude、Mixpanel、Omni、PostHog、Sigma。

## 谁能用、怎么开

- **计划**：全部付费计划可用（Pro、Max、Ultra、Team、Enterprise），免费版没有。
- **入口**：网页、桌面、手机端都有。
- **开关**：Team 计划三样默认全开；Enterprise 计划里 Whiteboards 和 Sheets 默认关闭，Claude Data 从 11 月 19 日起默认开启；都可以在 Organization settings > Artifacts 里改。
- **连接器同步升级**：交互式连接器现在可以把合作方的应用直接嵌进 Claude 里用（Adobe、Atlassian 等），Marketplace 上已有 9,000 多个连接器和插件；Salesforce、NetSuite、Workday 的插件自带技能。

Claude Meetings 官方只写了「即将推出」，说以后能把 Claude 加进通话里做笔记、更新团队文档——按官方口径写，它现在还没上线，别按已上线去理解。

## 普通用户怎么看

如果你是 Claude Pro，Sheets 和 Whiteboards 现在就能直接试，不用等企业开通；Data 要接企业的数据连接器，对个人用户用处不大。国内能不能直连使用，官方公告没有写地区名单，**本站未核实**；是否要单独收费，官方只写了「在付费计划内」，没有公布额外收费，同样以官方说明为准。

想了解 Anthropic 内部怎么用 Claude 的，可以看本站那篇 [Anthropic 内部怎么用 Claude Code](/posts/how-anthropic-teams-use-claude-code/)，里面有他们法务和市场团队的真实用法。更多 Anthropic 的新动向，见本站 [AI前沿动态](/categories/ai前沿动态/) 栏目。

## 参考来源

- Anthropic 官方公告：[Introducing Claude Whiteboards, Claude Sheets, and Claude Data](https://claude.com/resources/articles/sheets-whiteboards-data)（2026-11-10）
- Anthropic 官方公告：[More ways to work with Claude: Sheets, Whiteboards, and Interactive Connectors](https://claude.com/resources/articles/more-ways-to-work-with-claude-sheets-whiteboards-and-interactive-connectors)（2026-11-10）

## 信息核验与更新记录

- 2026-11-12 核对：功能、适用计划与开关状态均以两篇 Anthropic 官方公告原文为准；Meetings 按官方「即将推出」表述，未写成已上线；国内可用性与单独收费未核实，已在正文标明。
