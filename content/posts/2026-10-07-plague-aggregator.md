---
title: "实战：我用 AI + GitHub Actions 做了个全球疫情信息聚合站，开源、零成本"
date: 2026-10-07T22:30:00+08:00
lastmod: 2026-10-07T22:30:00+08:00
description: "11 个官方/专业/媒体信源、每 30 分钟自动更新、智谱 GLM 生成中文摘要，纯静态页面托管零成本。项目已开源，一键 fork 即用。"
tags: ["AI实战", "GitHub Actions", "开源项目"]
categories: ["AI实战"]
draft: false
showTableOfContents: true
---


这次不测别人的工具，自己动手做了一个：**[全球鼠疫 / 疫情信息聚合](https://daipo971.github.io/plague-aggregator/)**——自动抓取 11 个信源的疫情动态，每 30 分钟更新一次，还用 AI 生成中文摘要。项目全开源，部署零成本。


## 为什么做这个


疫情信息散落在 WHO、CDC、各国媒体官网里，语言不通、更新不同步，想追踪一个病种的全球动态，得开十几个页面。有没有办法让机器替我盯着？有，思路很简单：定时抓取 + AI 摘要 + 静态页面。


## 信源：只收三类


信息源的质量决定一切。这个站只收录三类来源，写死在配置文件里：


- **官方机构**：WHO 新闻
- **专业机构**：CIDRAP 鼠疫专题、CDC《新发传染病》期刊
- **正规媒体**：Google 新闻（英/中/俄/西/法五种语言关键词）、Bing 新闻（英/中文）


共 11 个源。增删信源不用改代码，改一个 `sources.yaml` 就行。


## 技术架构：全免费


- **定时**：GitHub Actions cron，每 30 分钟跑一次
- **抓取**：Python + feedparser，并发抓 RSS，按链接去重、只保留 30 天内的内容
- **AI 摘要**：智谱 GLM（`glm-4-flash`，免费模型）把外文标题摘要翻成中文，失败自动降级原文展示，不阻塞流程
- **发布**：生成纯静态 HTML，GitHub Pages 托管


API Key 存在仓库 Secrets 里，代码里见不到。从抓取到上线，全程不用自己的服务器，一分钱不花。


## 自己部署一套


1. Fork 仓库：[daipo971/plague-aggregator](https://github.com/daipo971/plague-aggregator)
2. 在 Settings → Secrets → Actions 加一个 `AI_API_KEY`（智谱、DeepSeek、OpenAI 等兼容接口都行，`config.yaml` 里对应改 `base_url` 和 `model`）
3. 在仓库 Settings → Pages 里选 main 分支 `/docs` 目录


改信源、改更新频率、换 AI 模型，全在 `config.yaml` 和 `sources.yaml` 两个文件里，README 写了完整说明。


## 一点说明


本站内容来自公开信源的自动聚合与 AI 摘要，仅供信息参考，不构成医疗建议。身体不适请及时就医，以当地卫生部门发布为准。
