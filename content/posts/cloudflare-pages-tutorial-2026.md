---
title: "Cloudflare Pages 教程：免费部署 Hugo 博客和静态网站"
date: 2026-07-25T06:00:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
description: "Cloudflare Pages 完整教程：连接 GitHub 自动部署 Hugo、Vite、Next.js 等项目，指定 Hugo 版本，绑定自定义域名，配置 _redirects 和 _headers、Pages Functions、Web Analytics，附构建失败等常见报错和常见问题。"
summary: "Cloudflare Pages 从部署到优化：自动构建、自定义域名、重定向、请求头、Functions、统计和常见报错。"
categories: ["建站与副业"]
tags: ["教程", "Cloudflare", "建站", "Hugo"]
showtoc: true
---

**结论先说：** 个人博客和静态网站，Cloudflare Pages 是最省心的免费托管方案之一：把代码放在 GitHub，连接到 Pages 后每次推送自动构建发布，静态资源请求不限量，自带 HTTPS 和全球 CDN。部署 Hugo 时最容易踩的坑是**没有指定 Hugo 版本**，一定要设置 `HUGO_VERSION` 环境变量。本站就托管在 Cloudflare Pages 上，下面按实际流程写。

**说明：** 免费额度和功能以 [Cloudflare Pages 官方文档](https://developers.cloudflare.com/pages/) 为准（2026 年 10 月查阅）。Cloudflare 也在推广用 Workers 托管静态资源，新项目可以了解；已有 Pages 项目继续正常使用。

## 前置条件

| 项目 | 说明 |
| --- | --- |
| GitHub 账号 | 存放网站代码（也支持 GitLab） |
| Cloudflare 账号 | 免费注册 |
| 网站项目 | Hugo、Hexo、Vite、Next.js（静态导出）等，本地能构建成功 |
| 域名（可选） | 不绑也能用 `xxx.pages.dev` 访问；免费域名见 [免费域名注册教程](/posts/free-domain-guide/) |

## 为什么选 Cloudflare Pages

| 对比 | Cloudflare Pages | GitHub Pages | Vercel / Netlify |
| --- | --- | --- | --- |
| 静态资源带宽 | 不限 | 有软性限制 | 免费档有额度 |
| 自动构建 | 支持多种框架，免费档每月 500 次构建 | 需要 GitHub Actions 配合 | 支持，免费档有构建时长限制 |
| 自定义域名和 HTTPS | 免费 | 免费 | 免费 |
| 服务端函数 | Pages Functions（基于 Workers） | 不支持 | 支持 |
| 适合 | 静态博客、文档站、前端项目 | 简单的项目主页 | 前端框架项目，尤其是 Next.js |

各平台的免费额度经常调整，以官网为准。选择 Pages 的主要理由是：静态资源不限量、和 Cloudflare 的 DNS、CDN、安全功能在同一个控制台里。

## 第一步：把项目推送到 GitHub

确认项目在本地能构建成功，再推送到 GitHub 仓库。Hugo 项目注意：

- 主题如果用 git submodule 引入，确认 `.gitmodules` 已提交；
- 不要提交构建产物 `public/` 目录，把它加进 `.gitignore`；
- 记下本地 Hugo 版本：`hugo version`。

## 第二步：创建 Pages 项目

1. 登录 Cloudflare 控制台，进入 **Workers 和 Pages**，选择创建 Pages 项目，**连接到 Git**；
2. 授权 GitHub，选择网站仓库；
3. 填写构建设置：

| 框架 | 构建命令 | 输出目录 |
|------|---------|---------|
| Hugo | `hugo --gc --minify` | `public` |
| Hexo | `npx hexo generate` | `public` |
| Vite（React / Vue） | `npm run build` | `dist` |
| Next.js（静态导出） | `npm run build` | `out` |
| Astro | `npm run build` | `dist` |

4. **Hugo 项目添加环境变量**：变量名 `HUGO_VERSION`，值填你本地的版本号（比如 `0.150.0`）。不设置的话，构建环境里的默认 Hugo 版本可能很旧，主题会报错。使用 Hugo 扩展版功能（如 SCSS）的主题，构建镜像一般已支持，报错时按官方文档检查。
5. 点击保存并部署。

构建完成后会得到一个 `项目名.pages.dev` 的网址。

## 第三步：自动部署和预览

之后每次推送到生产分支（通常是 `main`），Pages 会自动拉取代码、构建、发布。推送到其他分支或开 Pull Request 时，会生成单独的**预览网址**，可以先检查效果再合并。

每次部署都保留历史记录，出问题时在项目的「部署」页面可以一键回滚到之前的版本。

## 第四步：绑定自定义域名

1. 进入 Pages 项目 → **自定义域** → 设置自定义域；
2. 输入域名，比如 `example.com` 或 `blog.example.com`；
3. 域名已经托管在 Cloudflare DNS 的，会自动添加记录；域名在其他服务商的，按提示添加 CNAME 记录（根域名需要把 NS 迁移到 Cloudflare）；
4. 等待证书签发，通常几分钟。

建议把域名的 DNS 托管到 Cloudflare，根域名、证书、缓存都更方便管理。

## 第五步：重定向和请求头

### `_redirects`：301 重定向

在最终输出目录的根部放一个 `_redirects` 文件（Hugo 放在 `static/_redirects`，构建时会复制过去）：

```
/old-page/ /new-page/ 301
/blog/* /posts/:splat 301
```

本站合并或删除文章时，就是用这个文件把旧网址 301 到新网址，避免搜索流量损失。中文路径建议写成百分号编码形式。

### `_headers`：安全和缓存头

同样放在输出目录根部（Hugo 放 `static/_headers`）：

```
/*
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin

/images/*
  Cache-Control: public, max-age=31536000, immutable
```

只有带版本号或内容哈希的文件才适合设置 `immutable` 长缓存，否则更新图片后访客可能看到旧版本。

## 第六步：Pages Functions（可选）

需要一点服务端逻辑（表单提交、简单 API）时，在项目根目录建 `functions/` 目录，文件路径就是访问路径：

```javascript
// functions/api/hello.js → 访问 /api/hello
export async function onRequest(context) {
  return new Response("Hello from Pages Functions!", {
    headers: { "content-type": "text/plain; charset=utf-8" },
  });
}
```

Functions 按 Workers 的请求次数计费，免费档有每日请求额度。纯静态网站不需要这一步。

## 第七步：统计和性能

**Web Analytics：** 在 Cloudflare 控制台开启 Web Analytics，可以看到访问量、来源页面、国家地区、设备，以及 LCP、INP、CLS 等核心网页指标。它不使用 Cookie，对隐私友好，免费。

**性能建议：**

- Hugo 构建时加 `--minify` 压缩 HTML、CSS、JS（Cloudflare 原来的 Auto Minify 功能已经下线）；
- 图片用 WebP 格式并控制尺寸，这通常是静态网站最大的性能瓶颈；
- 开启 Brotli 压缩（一般默认开启）；
- 不确定作用的「加速」开关（如 Rocket Loader）不要随便开，可能导致页面脚本出错。

## 常见报错与解决

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| Hugo 构建报主题模板错误 | 没设置 `HUGO_VERSION`，用了旧版 Hugo | 添加环境变量，版本与本地一致 |
| 构建日志提示找不到主题 | 主题子模块没提交，或子模块地址是私有仓库 | 提交 `.gitmodules`，确认子模块仓库公开 |
| 部署成功但页面 404 | 输出目录填错 | Hugo 填 `public`，Vite 填 `dist` |
| 样式丢失、链接跳到 localhost | `baseURL` 配置错误 | 在 `hugo.toml` 里把 `baseURL` 设为正式域名 |
| 自定义域名一直「验证中」 | DNS 记录没加对，或域名不在 Cloudflare | 按控制台提示检查 CNAME，或迁移 NS |
| `_redirects` 不生效 | 文件没有出现在输出目录根部，或规则格式错误 | 构建后检查 `public/_redirects` 是否存在 |
| 构建次数用完 | 免费档每月构建次数有限 | 合并多次提交再推送，或在设置里关闭预览分支构建 |

## 常见问题

**Cloudflare Pages 真的免费吗？**
个人网站基本可以一直免费用：静态资源请求不限量，免费档有每月构建次数和 Functions 请求额度的限制，超出后需要付费或等下个周期。以官方文档为准。

**国内访问速度怎么样？**
Cloudflare 免费版在国内没有节点，访问速度取决于线路，通常能打开但速度一般。面向国内用户、对速度要求高的网站，需要考虑国内 CDN（需要备案）。

**私有仓库可以部署吗？**
可以。授权 Cloudflare 访问对应的私有仓库即可。

**怎么回滚到之前的版本？**
在 Pages 项目的部署列表里找到之前成功的部署，选择回滚。也可以在 Git 里回退提交后重新推送。

**和 Workers 托管静态网站有什么区别？**
两者底层都在 Cloudflare 的边缘网络上。Pages 的 Git 自动部署和预览流程更简单，适合博客和静态网站；Workers 更适合需要较多服务端逻辑的项目。Cloudflare 的推荐方向在变化，新项目可以对照官方文档选择。

## 更新记录

- 2026-10-28：重写为完整教程，补充前置条件、`HUGO_VERSION` 设置、预览部署、常见报错和常见问题；更正平台对比表（GitHub Pages 支持自定义域名等）、`_routes.json` 用途、已下线的 Auto Minify 和已被 INP 取代的 FID；删除有问题的 A/B 测试示例和无法核实的域名经历

## 相关阅读

- [从零搭建个人博客：免费 VPS + 免费域名 + Cloudflare](/posts/free-blog-tutorial/)
- [Linux 服务器入门教程](/posts/linux-server-beginners-2026/)
- [SEO 优化指南](/posts/seo-optimization-guide/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
