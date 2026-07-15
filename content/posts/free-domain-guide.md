---
title: "搞了个免费域名，真香。手把手注册教程"
date: 2026-07-03T22:00:00+08:00
draft: false
description: "最近白嫖了一个永久免费的域名，配合 Cloudflare 用起来贼爽。写篇教程分享给需要的朋友。"
tags: ["域名", "教程", "免费资源", "Cloudflare"]
---

前几天折腾个人项目的时候，发现域名又要续费了。.com 一年十几刀倒也不算贵，但折腾项目多的时候，一个项目配一个域名，累积下来也是一笔开销。

然后群里老哥丢了个链接过来：**DigitalPlat FreeDomain**，一个免费域名项目。

试了一下，确实能注册到正经的域名，不是那种二级域名或者跳转子域名，是可以在 Cloudflare 上自己管 NS 记录的真·域名。香。

写篇完整的教程，省得你们再踩坑。

## 能薅到什么

目前 DigitalPlat 提供的免费后缀有这几个：

| 后缀 | 推荐度 | 说明 |
|------|--------|------|
| `.dpdns.org` | ⭐⭐⭐⭐⭐ | 最稳，推荐 |
| `.qzz.io` | ⭐⭐⭐⭐ | 也可以，短 |
| `.us.kg` | ❌ | 要付 $2，不建议 |
| `.xx.kg` | ❌ | 同样要付 $2 |

我这个教程里就用 `.dpdns.org`，完全免费，一年后续期也是免费的，只剩 180 天的时候可以续。

配合 Cloudflare 的免费 DNS 解析 + 免费 CDN，零成本跑一个个人站完全没问题——比如我这个博客就是 Hugo + Cloudflare Pages 搭的，域名再白嫖一个，成本为零。

## 注册步骤

### 第一步：打开注册页面

点这个链接：https://dash.domain.digitalplat.org/signup?ref=2di59PPMUK

填表。字段看着多，其实都是常规信息。

我填的示例：

| 字段 | 示例值 |
|------|--------|
| Username | 你想要的用户名 |
| Full Name | San Zhang（空格隔开，姓和名都要） |
| Email | 你的邮箱 |
| Phone | +1-1234567890（格式要对） |
| Full Address | 13 Sweet William Way, West Tisbury, ma, 2575 United States |
| Password | 至少12位，大小写+数字+符号混搭 |

> 地址不用写真实的，格式搞对就行。

### 第二步：验证邮箱

提交后去邮箱收验证链接，点一下。**如果收件箱没有，看看垃圾箱**。

### 第三步：KYC 验证

登录进去之后，会让你做 KYC。这里需要用 GitHub 账号来验证——没错，没 GitHub 号的话先去注册一个。

验证方式很简单：在 Dashboard 里点 GitHub 授权，跳转到 GitHub 点一下 Authorize，完事。

### 第四步：Star 仓库提额度

默认注册完只能搞一个域名。想要第二个？去 GitHub 上 Star 一下 [FreeDomain 仓库](https://github.com/DigitalPlatDev/FreeDomain)，回到 Dashboard 点 "Verify" 刷新一下，额度就变成 2 个了。

### 第五步：注册域名

左边菜单点 **Domain Registration**，输入你想要的前缀（比如你的博客名、项目名），选 `.dpdns.org`。

Nameservers 这里有两种玩法：

- **方案一**：填 Cloudflare 的 NS（如果你打算用 Cloudflare 管理）
- **方案二**：填 DigitalPlat 自带的 `ns1.digitalplat.net` / `ns2.digitalplat.net`

如果你要用 Cloudflare，操作顺序是：
1. 先在 Cloudflare 添加域名（它会扫描现有记录）
2. 把 Cloudflare 给的 NS 地址填进 DigitalPlat
3. 等 Cloudflare 那边激活（通常几分钟）

## 遇到的一些坑

### 注册时 "Network Error"

刷新一下页面重新提交就行，偶尔会有网络波动。

### Phone 格式不对

严格按 `+1-XXXXXXXXXX` 的格式，区号不能少。

### KYC 验证不通过

确保你的 GitHub 账号是正常注册的，不要是刚注册的新号。建议注册完过几天再做 KYC。

### 域名注册后不生效

NS 记录可能有缓存，等 5-10 分钟。如果超过半小时还没生效，检查 NS 地址有没有填错。

## 还能怎么用

拿到域名之后，玩法很多：

- **Cloudflare Pages / Vercel / Netlify** 绑定自定义域名，免费部署个人站
- **Github Pages** 绑定自定义域名，装逼指数飙升
- **反向代理自建服务**，配合 Cloudflare Tunnel 不用暴露家里 IP
- **临时邮箱 / 短链接 / 图床** 等自建小工具

我自己是绑了 Cloudflare Pages，Hugo 构建完推送 GitHub 自动部署，域名也是白嫖的——整条链路花销为零。

## 写在最后

免费域名这种资源说多不多，说少不少。DigitalPlat 这个项目目前还算良心，一年后续约也是免费的，至于能撑多久不好说——这类项目大多靠捐助和爱发电运营，且用且珍惜。

有需要的趁早注册，链接再放一次：https://dash.domain.digitalplat.org/signup?ref=2di59PPMUK

有什么问题可以给我发邮件：**daipo971@gmail.com**，或者直接在下面评论区留言。

---

### 💡 付费域名推荐

免费域名适合练手，生产环境建议用付费域名更靠谱：

- [**NameSilo**](https://www.namesilo.com/) — .com 域名 $8.99/年，续费同价不涨价，送 WHOIS 隐私保护
- [**Porkbun**](https://porkbun.com/) — 最近很火的良心注册商，.com $9.03/年，界面清爽

两个都不套路，续费不涨价。

---

*有些外部工具链接是联盟链接，如果你通过这些链接购买，我会获得少量佣金（不影响你的价格）。所有推荐都是我亲自用过并觉得不错的产品。*
