---
title: "免费 VPS 对比：Oracle Cloud 免费层完全指南（2026更新）"
date: 2026-07-04T00:00:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
draft: false
description: "Oracle Cloud、Google Cloud、AWS、Azure 免费层对比：哪家能长期免费拿到一台服务器、具体配置和限制是什么，附 Oracle Always Free 注册和开机步骤、常见报错与安全设置。"
categories: ["建站与副业"]
tags: ["教程", "VPS", "Oracle Cloud"]
---
**结论先说：** 想长期免费拿到一台能跑服务的云服务器，目前最实在的是 **Oracle Cloud Always Free**：Arm 架构的 Ampere A1 实例合计 4 核 24GB 内存，外加 200GB 块存储和每月 10TB 出站流量。Google Cloud 只送一台很小的 e2-micro；AWS 从 2025 年 7 月起改成了抵扣金加 6 个月免费计划，不再是长期免费。只放静态博客的话，连服务器都不需要，直接用 [Cloudflare Pages](/posts/cloudflare-pages-tutorial-2026/)。

> 免费层的额度和规则会调整，本文按 2026 年 10 月能查到的官方说明整理，动手前以各家官网为准。

## 四家免费层对比

| 提供商 | 免费方式 | 能拿到的服务器 | 期限 | 适合 |
| --- | --- | --- | --- | --- |
| **Oracle Cloud** | Always Free | Ampere A1（Arm）合计 4 OCPU + 24GB 内存，另有 2 台 AMD 微型实例（每台 1GB 内存） | 长期 | 建站、常驻服务、学习 |
| **Google Cloud** | Always Free | 1 台 e2-micro（共享 vCPU，1GB 内存），仅限部分美国区域，含 30GB 标准硬盘 | 长期 | 轻量脚本、练手 |
| **AWS** | 新账户抵扣金 + 免费计划 | 用抵扣金开 EC2 等服务 | 免费计划 6 个月 | 短期体验 AWS |
| **Azure** | 新账户试用 | 试用期内的抵扣金和部分 12 个月免费服务 | 有期限 | 短期体验 Azure |

来源：[Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)、[Google Cloud 免费计划](https://cloud.google.com/free/docs/compute-getting-started)、[AWS 2025 年 7 月免费层更新公告](https://aws.amazon.com/about-aws/whats-new/2025/07/aws-free-tier-credits-month-free-plan/)。

## Oracle Always Free 到底送什么

| 资源 | 免费额度 | 说明 |
| --- | --- | --- |
| Ampere A1 计算 | 每月 3000 OCPU 小时 + 18000 GB 小时 | 折合常开 4 OCPU + 24GB 内存，可以开 1 台，也可以拆成最多 4 台 |
| AMD 微型实例 | 2 台 VM.Standard.E2.1.Micro | 每台 1/8 OCPU、1GB 内存，只适合很轻的服务 |
| 块存储 | 合计 200GB | 包括每台实例的启动盘 |
| 对象存储 | 20GB（标准 + 低频 + 归档合计） | 适合放备份 |
| 出站流量 | 每月 10TB | 个人建站基本用不完 |

几个容易误解的地方：

- **Arm 不等于性能差。** Ampere A1 跑 Linux、Docker、Nginx、Node.js、Python 都没问题，只有少数只提供 x86 版本的老软件需要用 AMD 实例。
- **AMD 微型实例很弱。** 1GB 内存装个面板或数据库就吃紧，建议主力用 A1。
- **免费额度按租户算。** 拆成几台还是开一台，总量都不能超过上表。

## 注册前准备

- 一个常用邮箱。
- 一张能付外币的信用卡或借记卡。注册时会做小额预授权验证，验证后撤销，Always Free 资源本身不扣费。
- 能收验证短信的手机号。
- 选好**主区域（Home Region）**。注册后不能修改，Always Free 的 A1 实例只能开在主区域。离国内较近的东京、首尔、新加坡等区域热门，容易出现容量不足；冷门区域更容易开出机器。

## 注册与开机步骤

### 第 1 步：注册账号

打开 [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) 点击开始免费使用，按页面填写邮箱、国家或地区、姓名和地址，选择主区域，然后验证手机号和银行卡。信息要和卡片一致，乱填地址是注册失败最常见的原因之一。

### 第 2 步：生成 SSH 密钥

在自己电脑的终端运行：

```bash
ssh-keygen -t ed25519 -C "oracle-free"
cat ~/.ssh/id_ed25519.pub
```

复制输出的公钥，下一步要用。私钥（不带 .pub 的文件）留在本机，不要发给任何人。

### 第 3 步：创建 A1 实例

1. 控制台进入 **Compute → Instances → Create instance**。
2. Image 选 **Ubuntu 24.04**（或 Oracle Linux）。
3. Shape 点 **Change shape**，选 **Ampere → VM.Standard.A1.Flex**，OCPU 和内存在免费额度内自定，比如 2 OCPU + 12GB，或者一次给满 4 OCPU + 24GB。
4. Networking 保持默认新建虚拟云网络，确认勾选分配公网 IPv4。
5. SSH keys 选择粘贴公钥，粘贴第 2 步的内容。
6. Boot volume 默认约 47GB，可以调大，但所有实例的磁盘合计不能超过 200GB。
7. 点击 **Create**，等实例状态变成 Running。

### 第 4 步：登录

```bash
ssh ubuntu@你的公网IP
```

Ubuntu 镜像的默认用户名是 `ubuntu`，Oracle Linux 是 `opc`。

### 第 5 步：放行端口

要对外提供网页服务，需要放行两层防火墙：

1. **云端安全列表**：进入实例所在子网的 Security List，添加入站规则，放行 TCP 80 和 443。
2. **系统防火墙**：Oracle 的 Ubuntu 镜像默认用 iptables 拦截了大部分入站端口，需要在系统里另外放行 80 和 443 并保存规则。

只做了第一层是新手打不开网页最常见的原因。

## 常见报错与解决

| 报错或现象 | 原因 | 解决 |
| --- | --- | --- |
| Out of capacity for shape VM.Standard.A1.Flex | 所在区域的免费 A1 资源暂时用完 | 换一个可用域（AD）重试、降低 OCPU 数，或隔几个小时再试 |
| 注册时银行卡验证失败 | 卡不支持外币、预授权被拒，或信息不一致 | 换一张支持外币的卡，地址和姓名与卡片保持一致 |
| SSH 连接超时 | 实例没有公网 IP，或安全列表没放行 22 端口 | 检查实例详情里的公网 IP 和子网安全列表 |
| 网页打不开但服务在跑 | 只放行了安全列表，系统 iptables 仍在拦截 | 在系统内放行 80、443 端口 |
| 实例被停止 | 长期闲置的免费实例可能被回收 | 让实例承担真实的服务负载，并把数据定期备份到别处 |

## 拿来做什么合适

| 适合 | 不适合 |
| --- | --- |
| 跑 Telegram 机器人、定时脚本、个人 API 服务 | 重要业务的唯一生产环境 |
| 自建 Git 服务、笔记服务、RSS 阅读器 | 违反服务条款的用途，比如挖矿、批量注册 |
| 学 Linux、Docker、Nginx | 存放唯一一份重要数据 |
| 博客的动态部分（评论、统计） | 纯静态博客（用 Cloudflare Pages 更省事） |

静态博客的搭建方式见 [从零搭建个人博客](/posts/free-blog-tutorial/)；想先打好命令行基础，可以看 [Linux 服务器入门](/posts/linux-server-beginners-2026/)。

## 安全设置清单

1. **只用密钥登录**，在 `/etc/ssh/sshd_config` 里关闭密码登录。
2. **只开放需要的端口**，不用的服务不要监听公网。
3. **定期更新系统**：`sudo apt update && sudo apt upgrade`。
4. **备份**：重要数据定期同步到对象存储或本地，免费资源随时可能因规则调整被回收。
5. **开启账户的多因素认证**，控制台密码不要和其他网站相同。

## 常见问题

**Always Free 真的永久免费吗？**
官方称 Always Free 资源没有时间限制，但条款可以调整，闲置实例也可能被回收。当作免费的学习和个人项目服务器很合适，不要把它当成唯一的生产环境。

**升级成付费账户（PAYG）还免费吗？**
升级后 Always Free 额度仍然保留，超出额度的部分才会计费，开 A1 实例时容量也通常更容易拿到。但要自己盯紧用量，避免误开付费资源。

**可以注册多个账号吗？**
不要这样做。多账号违反 Oracle 的服务条款，一旦被识别可能全部封停。

**国内访问速度怎么样？**
取决于所选区域和线路，海外机房国内晚高峰普遍不稳定。对外的网站可以套 Cloudflare 改善访问；需要稳定国内线路的，考虑付费 VPS，见 [便宜 VPS 推荐](/posts/cheap-vps-recommendations-2026/)。

**Google Cloud 的免费机器值得开吗？**
e2-micro 只有 1GB 内存，而且只在指定的美国区域免费，超出 1GB 的出站流量要计费。跑一个小脚本可以，建站和常驻服务首选 Oracle。

## 付费 VPS 推荐

免费服务器适合学习和个人项目，需要稳定性时再考虑付费 VPS：

| 推荐 | 适合人群 |
| --- | --- |
| [**RackNerd**](https://my.racknerd.com/aff.php?aff=20566) | 新手入门、预算有限，常有年付促销 |
| 搬瓦工 BandwagonHost | 需要稳定国内线路的老手，详见 [便宜 VPS 推荐](/posts/cheap-vps-recommendations-2026/) |

> 披露：RackNerd 链接为本站联盟链接，通过链接购买本站可能获得佣金，价格不变。

## 更新记录

- 2026-10-28：重写。更正 Oracle、Google Cloud 免费层配置和流量限制的错误数据，补充 AWS 2025 年 7 月新规、详细开机步骤、常见报错和安全清单，删除无法实现的 Gitea 推送 Pages 方案。

## 参考来源

- [Oracle Cloud Free Tier 官方页面](https://www.oracle.com/cloud/free/)
- [Google Cloud：免费层 Compute Engine 说明](https://cloud.google.com/free/docs/compute-getting-started)
- [AWS：免费层新增 200 美元抵扣金和 6 个月免费计划（2025-07）](https://aws.amazon.com/about-aws/whats-new/2025/07/aws-free-tier-credits-month-free-plan/)

## 相关阅读

- [从零搭建个人博客：免费VPS + 免费域名 + Cloudflare托管](/posts/free-blog-tutorial/)
- [Cloudflare Pages 完全教程：从部署到优化的全套指南](/posts/cloudflare-pages-tutorial-2026/)
- [2026 年便宜 VPS 推荐](/posts/cheap-vps-recommendations-2026/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
