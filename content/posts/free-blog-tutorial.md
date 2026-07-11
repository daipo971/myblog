---
title: "从零搭建个人博客：免费VPS + 免费域名 + Cloudflare托管"
date: 2026-07-11
description: "手把手教你从零搭建一个完全免费的Hugo博客，包含免费VPS、免费域名和Cloudflare Pages部署。"
summary: "零成本搭建个人博客完整教程，从VPS到域名到部署全流程。"
tags: ["博客搭建", "Hugo", "免费VPS", "Cloudflare", "免费域名", "建站教程"]
showtoc: true
---

# 从零搭建个人博客：免费VPS + 免费域名 + Cloudflare托管

2026年，搭建一个个人博客的成本几乎为零。我这个博客就是完全免费搭建的，零成本运营。这篇教程手把手带你走完整个流程。

## 技术栈

我用的这套方案：
- **静态博客框架**：Hugo（Go语言编写，速度极快）
- **托管平台**：Cloudflare Pages（全球CDN加速，完全免费）
- **域名**：DigitalPlat FreeDomain（永久免费）
- **代码管理**：GitHub（免费私有仓库）
- **写作**：VS Code + Markdown

全套成本：**0元**

## 第一步：申请免费域名

我在之前的文章里详细写过免费域名的注册方法，这里简单复述。

### DigitalPlat FreeDomain

DigitalPlat 提供永久免费的 `.dpdns.org` 等后缀域名，一年后续约也是免费的。

注册流程：
1. 访问 DigitalPlat 官网
2. 注册账号
3. 申请免费域名

详细的步骤看这篇：[搞了个免费域名，真香。手把手注册教程](https://xinqiai.dpdns.org/posts/free-domain-guide)

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

Oracle Cloud 免费配置：
- 2核 AMD CPU + 24GB 内存
- 8核 ARM CPU + 24GB 内存
- 200GB 硬盘
- 10TB 出站流量

详细教程看这篇：[白嫖一台永久免费服务器？Oracle Cloud 真香！](https://xinqiai.dpdns.org/posts/free-vps-guide)

## 第三步：安装 Hugo

### Mac 安装
```bash
brew install hugo
```

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
title: "ChatGPT 4o免费版使用体验"
description: "三个月深度使用ChatGPT 4o免费版，告诉你真相"
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

**我的博客运营成本：**
- 域名：0元（DigitalPlat FreeDomain）
- 托管：0元（Cloudflare Pages）
- VPS：0元（Oracle Cloud）
- CDN：0元（Cloudflare免费CDN）
- HTTPS：自动配置
- 总计：**0元**

## 常见问题

### Q: 免费域名稳定吗？
A: DigitalPlat 的 `.dpdns.org` 用了大半年，很稳定。一年后续约也是免费的。

### Q: Cloudflare Pages 有流量限制吗？
A: 免费版每月 100GB 带宽，个人博客完全够用。

### Q: 需要会编程吗？
A: 基本的命令行操作就行。如果不会，用 VS Code 的图形界面也能搞定。

### Q: 可以用其他静态博客框架吗？
A: 可以。Hugo、Next.js、Gatsby、Jekyll 都支持。

## 总结

搭建一个个人博客的成本几乎为零。我这套方案用了大半年，运行稳定，访问速度快。

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
