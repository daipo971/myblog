---
title: "Cloudflare Pages 完全教程：从部署到优化的全套指南"
date: 2026-07-25T06:00:00+08:00
description: "Cloudflare Pages 完整教程，涵盖部署Hugo/Next.js/React项目、自定义域名、CDN加速、Workers集成、数据分析等全部功能。"
summary: "Cloudflare Pages 从入门到精通，包含部署、优化、域名、Workers、数据分析等全流程指南。"
tags: ["Cloudflare", "部署", "建站", "CDN", "Hugo", "免费托管"]
showtoc: true
---

# Cloudflare Pages 完全教程：从部署到优化的全套指南

我用 Cloudflare Pages 跑这个博客已经大半年了，可以说这是我用过**最省心的托管平台**。

免费、全球CDN加速、自动部署、还能跑Serverless函数。这篇教程把我半年来的经验全部写出来，从入门到进阶一条龙。

## 为什么选择 Cloudflare Pages？

对比主流托管平台：

| 功能 | Cloudflare Pages | Vercel | Netlify | GitHub Pages |
|------|-----------------|--------|---------|-------------|
| 免费额度 | ∞带宽 | 100GB | 100GB | 100GB |
| 全球节点 | 330+城市 | 全球 | 全球 | 少量 |
| DDoS防护 | ✅ 内置 | ❌ | ❌ | ❌ |
| Serverless | Workers 10万次/天 | 函数限制 | 函数限制 | ❌ |
| 自定义域名 | ✅ 免费 | ✅ 免费 | ✅ 免费 | ❌ |
| 构建次数 | 500次/月 | 6000分钟 | 300分钟 | 不限 |

结论很明确：**免费额度最慷慨、全局CDN最快、安全防护最强。**

## 一、快速部署你的第一个项目

### 准备工作
- 一个 [GitHub](https://github.com/) 账号
- 一个 [Cloudflare](https://cloudflare.com/) 账号
- 你要部署的项目代码

### 部署Hugo博客

我这个博客就是用Hugo搭建的。部署流程很简单：

**1. 登录 Cloudflare Dashboard → Workers 和 Pages → Pages → 连接到 Git**

**2. 选择你的GitHub仓库**

**3. 配置构建设置：**
- 框架预设：Hugo
- 构建命令：`hugo`
- 构建输出目录：`public`
- 环境变量（如果要用）：无需额外配置

**4. 点击"开始构建"**

等2分钟左右，你的网站就上线了，得到一个 `xxx.pages.dev` 的域名。

### 部署其他框架

| 框架 | 构建命令 | 输出目录 |
|------|---------|---------|
| Hugo | `hugo` | `public` |
| Next.js | `npm run build` | `out`（静态导出） |
| React (Vite) | `npm run build` | `dist` |
| Vue (Vite) | `npm run build` | `dist` |
| Jekyll | `jekyll build` | `_site` |
| Hexo | `hexo generate` | `public` |

### 自动部署机制

每次你把代码推送到GitHub仓库，Cloudflare Pages会自动：
1. 拉取最新代码
2. 执行构建命令
3. 部署到全球节点

整个过程1-3分钟，每次推送都是无缝更新。

## 二、绑定自定义域名

Cloudflare Pages 支持绑定自定义域名，而且是**免费**的。

我用的是免费域名 `xinqiai.dpdns.org`，在之前的文章里有注册教程 👉 [免费域名申请指南](/posts/free-domain-guide/)

**绑定步骤：**

1. 进入Pages项目 → 自定义域 → 设置自定义域
2. 输入你的域名（不需要加https://）
3. Cloudflare会自动检测DNS配置
4. 如果域名不在Cloudflare，需要修改NS记录

**注意事项：**
- 域名解析建议用Cloudflare DNS（自带CDN和防护）
- SSL证书自动签发，不需要手动配置
- CNAME扁平化支持顶级域名（如 example.com）

## 三、高级功能配置

### 3.1 自定义404页面

在项目的 `static/` 目录下创建 `404.html`，Pages会自动使用它。

```
static/
  └── 404.html
```

### 3.2 重定向规则

在项目根目录创建 `_redirects` 文件：

```
# 永久重定向
/old-page /new-page 301

# 带通配符的重定向
/blog/* /posts/:splat 301

# 域名重定向
https://old-domain.com/* https://new-domain.com/:splat 301
```

### 3.3 请求头配置

在项目根目录创建 `_headers` 文件：

```
# 安全头
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin

# 缓存配置
/assets/*
  Cache-Control: public, max-age=31536000, immutable
```

### 3.4 预渲染和Sitemap

在 `_routes.json` 中配置预渲染规则：

```json
{
  "version": 1,
  "include": ["/*"],
  "exclude": []
}
```

Hugo自动生成Sitemap，无需额外配置。

### 3.5 Cloudflare Workers集成

Pages支持绑定Workers，在 `functions/` 目录下写Serverless函数：

```
functions/
  └── api/
      └── hello.js
```

```javascript
export async function onRequest(context) {
  return new Response("Hello from Pages Functions!", {
    headers: { "content-type": "text/plain" },
  });
}
```

## 四、性能优化技巧

### 4.1 开启自动压缩

在Cloudflare Dashboard中开启：
- Brotli压缩 → 大小减少约30%
- Auto Minify → 自动压缩HTML/CSS/JS
- Rocket Loader → 异步加载JS（谨慎使用）

### 4.2 配置缓存

通过Cloudflare规则配置缓存策略：
- 静态资源（图片、CSS、JS）：缓存30天
- HTML页面：缓存1小时（配合部署后自动清除）

### 4.3 使用Workers做A/B测试

用Workers Route做简单的A/B测试：

```javascript
export default {
  async fetch(request) {
    const url = new URL(request.url);
    const cookie = request.headers.get("Cookie");
    
    if (cookie && cookie.includes("variant=b")) {
      url.pathname = url.pathname.replace("/", "/variant-b/");
    }
    
    return fetch(url);
  }
}
```

## 五、数据分析

Cloudflare Pages 内置了Web Analytics（隐私友好的统计）：

**开启方式：**
1. Cloudflare Dashboard → Analytics & Logs → Web Analytics
2. 添加你的网站
3. 复制JS片段或使用Cloudflare自动注入

**可以看的数据：**
- 页面UV/PV
- 访问来源
- 设备分布
- 性能指标 (LCP, FID, CLS)
- **完全免费，没有数据采样**

## 六、常见问题

### Q：部署失败怎么办？
A：查看构建日志，大部分问题是构建命令或输出目录配置错误。

### Q：如何回滚？
A：Cloudflare Pages保留了每次部署的历史记录，可以一键回滚到任何历史版本。

### Q：带宽有限制吗？
A：没有带宽限制。Cloudflare Pages 不限制带宽，这是它比Vercel和Netlify最大的优势。

### Q：支持自定义构建命令吗？
A：支持。可以在项目设置的"构建配置"中自由设置。

## 总结

Cloudflare Pages 是目前最适合个人站长的托管平台——**免费、快速、功能全面**。

如果你还没用上，今天就迁移过来。整个迁移过程不到10分钟，效果立竿见影。

我现在所有的网站都放在Cloudflare Pages上，运营了大半年零故障。唯一的建议是：搭配Cloudflare DNS一起用，体验最佳。

---

**相关阅读：**
- 👉 [从零搭建个人博客完整教程](/posts/free-blog-tutorial/)
- 👉 [免费域名申请指南](/posts/free-domain-guide/)
- 👉 [SEO优化指南：让文章被搜索引擎收录](/posts/seo-optimization-guide/)
- 👉 [网站推广策略：从0到日UV1000](/posts/website-promotion-strategy-2026/)
