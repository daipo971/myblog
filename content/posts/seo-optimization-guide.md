---
title: "博客 SEO 优化教程：收录、关键词、内链和 301 怎么做"
date: 2026-07-09T10:00:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
description: "个人博客 SEO 完整教程：Search Console 和 Bing 验证、sitemap、robots.txt、IndexNow、关键词和标题、内链、301 重定向、结构化数据，以本站 Hugo 配置为例，附常见问题和自查清单。"
summary: "以欣淇AI网的 Hugo 配置为例，讲清个人博客 SEO 的收录、关键词、内链、301 和结构化数据怎么做。"
categories: ["建站与副业"]
tags: ["教程", "SEO", "建站", "Hugo"]
showtoc: true
---

**结论先说：** 个人博客做 SEO，先把三件事做对，比研究任何技巧都重要：**一是让搜索引擎能发现和收录**（提交 sitemap、验证 Search Console 和 Bing、不误屏蔽页面）；**二是一个搜索问题只对应一篇最好的文章**（标题含读者会搜的词、开头直接给答案、同题文章合并）；**三是改网址必须 301**，否则积累的排名会丢掉。本文用本站（Hugo + PaperMod，托管在 Cloudflare Pages）的实际配置做例子，其他静态博客做法相同。

**说明：** 本文的配置来自本站仓库的真实设置；搜索引擎规则依据 [Google 搜索中心文档](https://developers.google.com/search/docs) 和 [Bing 网站管理员指南](https://www.bing.com/webmasters/help/webmaster-guidelines-30fba23a) 整理（2026 年 10 月查阅）。本文不提供流量数据和排名承诺。

## 前置条件

| 项目 | 说明 |
| --- | --- |
| 已上线的网站 | 有自己的域名，开启 HTTPS；搭建方法见 [从零搭建个人博客](/posts/free-blog-tutorial/) |
| Google 账号 | 用于 Google Search Console |
| Microsoft 账号 | 用于 Bing Webmaster Tools |
| 能修改网站代码 | 需要放验证文件、修改配置 |

## 第一步：让搜索引擎找到你

### 验证 Google Search Console 和 Bing Webmaster Tools

这两个后台是免费的，能看到网站在搜索结果里的展现次数、点击、收录状态和问题提示，做 SEO 必须有。

1. 打开 [Google Search Console](https://search.google.com/search-console)，添加网站。推荐「网域」方式，在 DNS 里加一条 TXT 记录；也可以用「网址前缀」方式上传验证文件或加 meta 标签。
2. 打开 [Bing Webmaster Tools](https://www.bing.com/webmasters)，可以直接从 Search Console 导入网站，省去重复验证。

本站用的是 meta 标签方式，在 `hugo.toml` 里填写验证码，PaperMod 主题会自动输出到页面头部：

```toml
[params.analytics.google]
  SiteVerificationTag = "你的 Google 验证码"
[params.analytics.bing]
  SiteVerificationTag = "你的 Bing 验证码"
```

### 提交 sitemap

sitemap 是网站所有页面的清单。Hugo 会自动生成 `/sitemap.xml`，不用手写。验证完成后，在两个后台的「站点地图」里提交 `https://你的域名/sitemap.xml`。

### 检查 robots.txt

robots.txt 告诉爬虫哪些页面不要抓。常见的错误是把分类页、标签页也屏蔽了，导致爬虫顺着链接找不到文章。本站在 `hugo.toml` 里开启 `enableRobotsTXT = true`，用 `layouts/robots.txt` 模板生成，只屏蔽站内搜索页：

```
User-agent: *
Allow: /
Disallow: /search/

Sitemap: https://xinqai.com/sitemap.xml
```

不想被收录的页面（比如标签页），用页面里的 `noindex` 控制，而不是在 robots.txt 里屏蔽。被 robots.txt 屏蔽的页面，爬虫读不到里面的 `noindex`。

### 用 IndexNow 加快 Bing 收录

[IndexNow](https://www.indexnow.org/) 是 Bing、Yandex 等搜索引擎支持的协议：网页新增或修改后，主动通知搜索引擎来抓取。做法是在网站根目录放一个密钥文件，然后把网址提交到 IndexNow 接口。本站用 GitHub Actions 实现：每次推送文章到 `main`，等 Cloudflare 部署完成后，自动提交变动的网址。

注意：**Google 不支持 IndexNow**，Google 靠 sitemap 和链接发现新页面；重要的新页面可以在 Search Console 里用「网址检查」手动请求编入索引。

## 第二步：选关键词，写对标题

### 从读者的问题出发

关键词不是越热门越好。个人博客竞争不过大网站的「ChatGPT」这类大词，更现实的是**具体问题**：「Claude 国内怎么用」「Cloudflare Pages 部署 Hugo 报错」。找词的来源：

- Search Console 的「效果」报告：已经有展现、但排名在第二页的词，最值得优化；
- 搜索框的下拉联想和「相关搜索」；
- 读者在评论区、社群里反复问的问题；
- Bing Webmaster Tools 的关键词研究功能。

详细方法见 [关键词研究教程](/posts/keyword-research-2026/)。

### 一个问题只写一篇

搜索引擎对同一个查询通常只给一个网站展示一两个结果。如果你写了两篇主题几乎一样的文章，它们会互相抢排名（俗称「关键词蚕食」）。写之前先在自己的文章里搜一下，已有同题文章就更新旧文，不另开新文。

### 标题、描述和开头

| 要素 | 写法 |
| --- | --- |
| 标题 | 30 字以内，包含读者会搜的词，说清这篇解决什么问题；不用夸张词 |
| 描述（description） | 70 到 120 字，说明解决什么问题和结论，会显示在搜索结果里 |
| 开头 | 100 字内给出答案，不写空洞的引子 |
| 小标题 | 每 400 到 600 字一个，覆盖相关的长尾问题（「多少钱」「国内能用吗」） |
| 网址 | 用简短的英文关键词，不带日期，发布后不再改 |

**一个常见误区：** 「关键词密度要保持在 2% 到 3%」。现在的搜索引擎理解语义，不按密度打分，刻意堆砌关键词反而会被认为是垃圾内容。把问题回答清楚、自然提到相关说法就够了。

## 第三步：写搜索引擎和读者都认可的内容

Google 的公开指南反复强调「以人为本的有用内容」，以及经验、专业、权威、可信（E-E-A-T）。对个人博客来说，落到实处是这几条：

1. **真实。** 没测过就不写「实测」，写成「依据官网和文档整理」并标查阅时间；不编使用经历和数据。
2. **有来源。** 价格、发布日期、跑分附官方链接。
3. **及时更新。** 产品改版、价格变化后更新文章和 `lastmod`，在文末更新记录里写一行。
4. **结构清楚。** 表格做对比、步骤编号、FAQ 用读者的原话。这样的页面也更容易被 AI 搜索引用，见 [AI 搜索引擎对比](/posts/ai-search-engines-comparison-2026/)。

本站的完整内容标准写在仓库的 `CLAUDE.md` 和运营框架文档里，每篇文章发布前都按清单自检。

## 第四步：建好内链

内链是你自己网站内部的链接。它帮助爬虫发现新文章，也告诉搜索引擎哪些页面更重要。

- **每篇至少 3 个站内链接**：2 篇同主题文章，加 1 个分类中心页或系列入口页；
- **发新文章后回链**：回到 2 到 3 篇相关旧文，加一个指向新文的链接；
- **锚文本写清楚**：用「Cloudflare Pages 教程」这样描述性的文字，不用「点这里」；
- **层级不要太深**：任何文章从首页出发不超过 3 次点击能到达。

更多做法见 [内链策略](/posts/internal-linking-strategy/)。

## 第五步：改网址一定要做 301

合并文章、删除文章、修改网址时，旧网址已经积累的收录和排名，需要用 **301 永久重定向**转移到新网址。不做的话，旧链接变成 404，排名从零开始。

Cloudflare Pages 和 Netlify 都支持 `_redirects` 文件。Hugo 放在 `static/_redirects`，一行一条规则：

```
/posts/old-slug/ /posts/new-slug/ 301
```

几个注意点：

- 删除文章前，先在全站搜索旧网址，把站内链接都改成新网址；
- 中文网址写成百分号编码形式，避免匹配失败；
- 双语网站的英文版旧网址也要一起重定向；
- 不要把所有删除的文章都重定向到首页，搜索引擎会把这种跳转当作 404 处理。尽量指向内容最接近的页面。

## 第六步：结构化数据和多语言

### 结构化数据

结构化数据（Schema.org）用代码告诉搜索引擎页面是什么：文章、作者、发布时间、面包屑路径。PaperMod 主题自带 `BlogPosting` 和 `BreadcrumbList`，一般不需要额外配置，可以用 Google 的[富媒体搜索结果测试](https://search.google.com/test/rich-results)检查。

需要知道的是：Google 自 2023 年 8 月起，**FAQ 富媒体结果只对知名的政府和健康类权威网站显示**，HowTo 富媒体结果也已停止显示。给普通博客加 FAQ 结构化数据，基本不会在搜索结果里出现折叠问答，不用为此花太多时间。

### 多语言网站加 hreflang

如果有中英双语，要用 hreflang 标签告诉搜索引擎两个页面互为翻译，避免被当成重复内容。Hugo 的多语言功能会自动为互译的页面生成 hreflang：本站英文文章用 `同名.en.md` 放在中文文章旁边，构建时自动关联。

## 第七步：看数据，持续调整

| 指标 | 在哪里看 | 怎么用 |
| --- | --- | --- |
| 收录情况 | Search Console「网页索引」 | 查看未编入索引的原因，逐个处理 |
| 展现和点击 | Search Console「效果」 | 展现多、点击少的页面，改标题和描述 |
| 排名第 8 到 20 的词 | Search Console 按查询筛选 | 补充内容、加内链，最容易提升 |
| 页面速度 | Search Console「核心网页指标」、Cloudflare Web Analytics | 压缩图片，减少脚本 |
| 死链 | 构建后用脚本扫描 | 保持为 0 |

监控方法的细节见 [SEO 数据监控指南](/posts/seo-monitoring-guide/)。SEO 见效慢，新站通常要几个月才有稳定的搜索流量，不要频繁大改标题和网址。

## 常见问题

**新网站多久能被 Google 收录？**
没有固定时间，从几天到几周都有。提交 sitemap、在 Search Console 请求编入索引、让已收录的页面链接到新页面，都能加快速度。

**百度能收录托管在海外的网站吗？**
可以抓取，但海外服务器在国内访问慢、不稳定，收录和排名通常不理想。主要面向百度流量的网站，一般需要国内服务器和备案。

**要不要花钱买外链？**
不建议。购买用于操纵排名的链接违反 Google 和 Bing 的规则，被识别后可能被降权。更可靠的方法是写出值得被引用的内容，在相关社区正常分享。

**标签页要不要被收录？**
标签页内容大多重复，建议加 `noindex, follow`：不收录标签页本身，但允许爬虫顺着它的链接找到文章。

**用 AI 写的文章会被搜索引擎惩罚吗？**
Google 的公开说法是看内容是否有用，而不是看是不是 AI 写的；但批量生成、没有核实的低质量内容属于违规的「规模化内容滥用」。AI 可以辅助写作，事实和数据必须人工核对。

**修改旧文章的标题会影响排名吗？**
可能会有短期波动。如果原标题的点击率低，改成更准确的标题通常是值得的；网址不要跟着改。

## 自查清单

**每篇文章发布前：**

- 标题含读者会搜的词，30 字以内；描述 70 到 120 字；
- 开头 100 字内给出答案；
- 至少 3 个站内链接；图片有 alt 文字；
- 数据有来源链接；
- 没有和已有文章重复的主题。

**每月一次：**

- Search Console 里未编入索引的原因有没有新增；
- 站内死链为 0；
- 删除或合并过的文章都有 301；
- 展现多、点击少的页面改标题和描述。

## 更新记录

- 2026-10-28：重写为完整教程：以本站 Hugo 配置为例补充 Search Console 与 Bing 验证、sitemap、robots.txt、IndexNow、关键词和标题写法、内链、301、结构化数据、hreflang、数据监控、常见问题和自查清单；更正「关键词密度 2–3%」和「FAQ 结构化数据可获富媒体结果」的过时说法；类型标签由「复盘」改为「教程」（文中没有真实运营数据）

## 相关阅读

- [关键词研究教程](/posts/keyword-research-2026/)
- [内链策略](/posts/internal-linking-strategy/)
- [SEO 数据监控指南](/posts/seo-monitoring-guide/)
- [Cloudflare Pages 教程：免费部署 Hugo 博客和静态网站](/posts/cloudflare-pages-tutorial-2026/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
