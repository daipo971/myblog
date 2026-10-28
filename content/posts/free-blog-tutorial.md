---
title: "从零搭建个人博客：免费VPS + 免费域名 + Cloudflare托管"
date: 2026-07-11
lastmod: 2026-10-28T09:00:00+08:00
description: "手把手教你从零搭建一个完全免费的Hugo博客，包含免费VPS、免费域名和Cloudflare Pages部署。"
summary: "零成本搭建个人博客完整教程，从VPS到域名到部署全流程。"
categories: ["建站与副业"]
tags: ["教程", "建站", "VPS", "Hugo"]
showtoc: true
---

**结论先说：** 用 Hugo 生成静态页面，代码放 GitHub，Cloudflare Pages 免费托管和自动部署，这三样就能零成本跑起一个博客；域名练手可以用免费的，正式做站建议买一个便宜的 .com。下面按顺序讲清每一步，最后附常见报错。

**开始前你需要：** 一个 GitHub 账号、一个 Cloudflare 账号、一台装了 Git 的电脑，以及会在终端里复制粘贴命令。

2026 年，搭建一个个人博客的成本可以做到几乎为零：Hugo 生成静态页面，Cloudflare Pages 免费托管，GitHub 管理代码，练手阶段再配一个免费域名。本站 xinqai.com 用的就是 Hugo + Cloudflare Pages 这套方案（域名是付费的 .com）。这篇教程带你走完整个流程。

## 技术栈

推荐的这套方案：
- **静态博客框架**：Hugo（Go语言编写，速度极快）
- **托管平台**：Cloudflare Pages（全球CDN加速，完全免费）
- **域名**：DigitalPlat FreeDomain（永久免费）
- **代码管理**：GitHub（免费私有仓库）
- **写作**：VS Code + Markdown

全套成本：**0元**

## 第一步：申请免费域名

免费域名的注册方法在另一篇文章里有详细步骤，这里简单说明。

### DigitalPlat FreeDomain

DigitalPlat 提供永久免费的 `.dpdns.org` 等后缀域名，一年后续约也是免费的。

注册流程：
1. 访问 DigitalPlat 官网
2. 注册账号
3. 申请免费域名

详细的步骤看这篇：[搞了个免费域名，真香。手把手注册教程](/posts/free-domain-guide)

### 备用方案：NameSilo

如果免费域名不够用，NameSilo 是最良心的付费域名注册商：
- `.com` 域名 $8.99/年起
- 免费 WHOIS 隐私保护
- 续费不涨价
- 支持支付宝

## 第二步：选择托管方案

### 方案一：Cloudflare Pages（推荐）

Cloudflare Pages 是免费的静态网站托管服务，全球CDN加速。

**优点：**
- 完全免费，无隐藏费用
- 全球 CDN 加速
- 自动 HTTPS
- 支持自定义域名
- 自动部署

**配置步骤：**

#### 1. 连接 GitHub 仓库
登录 Cloudflare Dashboard，进入 Workers 和 Pages 页面，点击"创建应用程序"，选择"Pages"标签，连接你的 GitHub 账号，选择博客仓库。

#### 2. 配置构建
```
框架预设：Hugo
构建命令：hugo
构建输出目录：public
```

#### 3. 自定义域名
在 Pages 项目的"自定义域"中，添加你的免费域名。

#### 4. 自动 HTTPS
Cloudflare 会自动为你的域名配置 HTTPS 证书。

### 方案二：免费VPS + 手动部署

如果你想自己控制服务器，可以用 Oracle Cloud 的免费 VPS。

Oracle Cloud Always Free 的主要额度（以 [官方页面](https://www.oracle.com/cloud/free/) 为准）：
- Ampere A1（Arm）实例合计 4 OCPU + 24GB 内存
- 2 台 AMD 微型实例（每台 1GB 内存）
- 合计 200GB 块存储
- 每月 10TB 出站流量

详细教程看这篇：[免费 VPS 对比：Oracle Cloud 免费层完全指南](/posts/free-vps-guide/)

## 第三步：安装 Hugo

### Mac 安装
```bash
brew install hugo
```

### Windows 安装
```powershell
winget install Hugo.Hugo.Extended
```

### Linux 安装
到 [Hugo 的 GitHub 发布页](https://github.com/gohugoio/hugo/releases) 下载对应系统的 extended 版本安装包。Ubuntu 软件源里的 Hugo 版本通常比较旧，可能和主题不兼容，不建议直接 `apt install`。

装好后运行 `hugo version` 确认，PaperMod 等主题一般要求较新的 Hugo 版本，记下这个版本号，后面配置 Cloudflare 时要用。

### 创建新站点
```bash
hugo new site myblog
cd myblog
git init
```

### 安装主题
我用的 PaperMod 主题，简洁专注：
```bash
git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
echo "theme = 'PaperMod'" >> hugo.toml
```

### 创建第一篇文章
```bash
hugo new posts/my-first-post.md
```

## 第四步：配置 Cloudflare Pages

### 1. 推送代码到 GitHub
```bash
git remote add origin https://github.com/yourname/myblog.git
git branch -M main
git push -u origin main
```

### 2. Cloudflare Pages 连接

登录 [Cloudflare Dashboard](https://dash.cloudflare.com/)：
1. 进入 Workers 和 Pages
2. 点击"创建" → "Pages"
3. 连接 GitHub
4. 选择仓库
5. 配置构建设置

### 3. 自定义域名
在 Pages 项目设置中，添加你的免费域名。

## 第五步：写作和工作流

### 本地写作
```bash
# 新建文章
hugo new posts/article-name.md

# 本地预览
hugo server -D

# 构建
hugo

# 推送部署
./publish.sh
```

### 发布脚本
创建一个 `publish.sh`：
```bash
#!/bin/bash
git add .
git commit -m "Auto update: $(date)"
git push
echo "Cloudflare 正在自动部署..."
```

## 第六步：SEO优化

### 基础配置
在 `hugo.toml` 中配置：
```toml
title = "你的博客名"
baseURL = "https://你的域名"
theme = "PaperMod"
```

### Google Search Console
1. 访问 [Google Search Console](https://search.google.com/search-console)
2. 添加你的域名
3. 按照提示验证所有权
4. 提交 sitemap.xml

### 文章SEO最佳实践
每篇文章都应该包含：
- **标题**：包含核心关键词
- **描述**：吸引点击的描述
- **标签**：相关关键词标签
- **URL**：简洁的URL结构

示例：
```markdown
---
title: "Hugo 博客怎么绑定自定义域名"
description: "Hugo 博客部署到 Cloudflare Pages 后绑定自定义域名的完整步骤，包括 DNS 记录怎么加、HTTPS 多久生效和常见报错。"
tags: ["ChatGPT", "AI工具"]
---
```

## 进阶技巧

### 1. 添加评论系统
用评论区可以增加用户互动和停留时间。

### 2. 添加搜索功能
PaperMod 主题自带搜索功能，配置很简单。

### 3. 自动部署
每次推送到 GitHub，Cloudflare Pages 会自动部署。

### 4. 多语言支持
Hugo 支持多语言博客，可以配置英文和中文版本。

### 5. 性能优化
- 使用 WebP 格式图片
- 启用 Gzip 压缩
- 使用 CDN 加速

## 实际花费

**这套方案的运营成本：**
- 域名：0元（DigitalPlat FreeDomain）
- 托管：0元（Cloudflare Pages）
- VPS：0元（Oracle Cloud）
- CDN：0元（Cloudflare免费CDN）
- HTTPS：自动配置
- 总计：**0元**

如果正式做站换成付费 .com 域名，每年多出一笔域名费（各注册商价格不同，首年和续费价也可能不一样，下单前看清续费价），其余部分仍然是免费的。没有 VPS 也完全可以，纯静态博客只用 Cloudflare Pages 就够了，VPS 只在需要跑后台程序时才用得上。

## 常见问题

### Q: 免费域名稳定吗？
A: 免费域名可以用来练手和做个人站，但稳定性和续期规则取决于提供方，可能变化。正式做站建议买一个便宜的 .com，详见 [免费域名教程](/posts/free-domain-guide/) 里的注意事项。

### Q: Cloudflare Pages 有流量限制吗？
A: 按 Cloudflare 官方说明，Pages 免费版不限带宽和请求数，限制主要是每月构建次数（免费版 500 次），个人博客完全够用。以官方最新说明为准。

### Q: 需要会编程吗？
A: 基本的命令行操作就行。如果不会，用 VS Code 的图形界面也能搞定。

### Q: 发布脚本里的 `git add .` 安全吗？
A: 要先确认 `.gitignore` 里排除了 `public/`、`.env` 这类构建产物和密钥文件，否则可能把不该公开的内容推到 GitHub。不确定的话，每次推送前先运行 `git status` 看一眼。

### Q: 可以用其他静态博客框架吗？
A: 可以。Hugo、Next.js、Gatsby、Jekyll 都支持。

## 总结

搭建一个个人博客的成本几乎为零：静态站点托管在 Cloudflare Pages，稳定、访问速度快。

如果你是：
- **技术博主**：写技术文章的最佳平台
- **内容创作者**：独立博客比平台更自由
- **学生**：零成本搭建个人网站
- **创业者**：快速搭建产品官网

那就开始吧！有任何问题欢迎留言交流。

---

**相关资源：**
- [免费VPS教程：Oracle Cloud](/posts/free-vps-guide)
- [免费域名注册教程](/posts/free-domain-guide)
- [Cloudflare 注册](https://dash.cloudflare.com/)
- [Hugo 官网](https://gohugo.io/)

---

*部分链接是联盟链接，通过这些链接购买，我可能会获得少量佣金。价格对你来说是一样的。*

## 常见报错与解决

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| Cloudflare 构建失败，日志提示主题模板报错 | Pages 默认的 Hugo 版本太旧，和主题要求不符 | 在 Pages 项目的环境变量里添加 `HUGO_VERSION`，填本地 `hugo version` 显示的版本号 |
| 构建成功但页面一片空白 | 主题是 git submodule，仓库里没有带上 | 确认 `.gitmodules` 已提交；本地克隆后运行 `git submodule update --init` |
| 页面没有样式、链接跳到 localhost | `baseURL` 没改成正式域名 | 把 `hugo.toml` 里的 `baseURL` 改成 `https://你的域名/` |
| 新文章本地能看到，上线后没有 | 文章还是 `draft: true`，或者 `date` 写成了未来时间 | 改成 `draft: false`，日期带上时区，例如 `+08:00` |
| 自定义域名一直显示验证中 | 域名的 DNS 不在 Cloudflare，或者 CNAME 记录没加对 | 按 Pages 提示添加记录，等待 DNS 生效，通常几分钟到几小时 |

## 上线后的检查清单

1. 用手机打开网站，确认排版、图片和菜单正常。
2. 在 Google Search Console 和 Bing Webmaster Tools 提交 `sitemap.xml`。
3. 每篇文章写好 `title` 和 `description`，图片加 alt 文字，方法见 [SEO 优化指南](/posts/seo-optimization-guide/)。
4. 文章之间互相加链接，方法见 [内链建设策略](/posts/internal-linking-strategy/)。

## 更新记录

- 2026-10-28：更正与本站实际情况不符的描述（本站使用付费域名），更正 Oracle 免费层配置，补充前置条件、常见报错和上线检查清单
