---
title: "免费 VPS 对比：Oracle Cloud 免费层完全指南（2026更新）"
date: 2026-07-04T00:00:00+08:00
draft: false
description: "Oracle Cloud Free Tier 永久免费，Google Cloud Always Free 服务丰富。写一篇专业对比，适合建站、学习使用。"
tags: ["Oracle Cloud", "Free VPS", "云计算", "建站教程"]
---

这几年折腾技术博客、自建服务，最大的门槛就是服务器成本。一个 VPS 一年下来几十刀，搞多了也是笔开销。

于是我去研究了下各大云厂商的免费层，发现 Oracle Cloud 的免费层真的很香——**永久免费**，不用到期续费。

写篇指南，给想白嫖一台服务器建站或学习的兄弟们。

## 免费层现状（2026 更新）

先说结论：目前主流云厂商的免费层，**Oracle Cloud 的最实在**。

| 提供商 | 免费层级 | 有效期 | 核心配置 | 适用场景 |
|--------|----------|--------|----------|----------|
| **Oracle Cloud** | Always Free | 永久 | 2x AMD + 8x ARM | 建站、托管代码 |
| **Google Cloud** | Always Free | 永久 | Compute Engine 3vCPU | 测试环境、开发 |
| **AWS** | Free Tier | 12个月 | t2.micro/t3.micro | 短期测试 |
| **Azure** | Free Trial | 30天 | B1s | 新手体验 |

Oracle 2026年的免费层配置基本没变，仍然非常划算。

## Oracle Cloud Free Tier 详细说明

### 免费资源清单

```
┌─────────────────────────────────────────────────────────────┐
│                    Oracle Cloud Always Free                   │
├─────────────────────────────────────────────────────────────┤
│  🖥️  AMD Compute Instances   (x86)      2 x 4 OCPU + 24 GB  │
│  🖥️  ARM Compute Instances   (Ampere)   8 x 4 OCPU + 24 GB  │
│  💾  Block Volume Storage     200 GB                       │
│  🌐  General Purpose VNICs    2                       │
│  📦  Object Storage           3 TB                       │
│  📊  Data Transfer (Outbound)  10 Mbps                    │
│  🔍  Backup (Branding)        10 GB                       │
└─────────────────────────────────────────────────────────────┘
```

### AMD vs ARM 实例

| 特性 | AMD 实例 | ARM 实例 |
|------|----------|----------|
| 架构 | x86_64 | ARM64 |
| 处理器 | x86 芯片 | Ampere A1 |
| 免费额度 | 2个 | 8个 |
| 适用 | 兼容性要求高 | 现代 Linux/容器 |
| 性能 | 略强 | 能效比高 |

**选择建议：**
- 默认选 **ARM 实例**，Ubuntu/Debian 原生支持更好，容器化部署更省资源
- 如果跑的是老软件或特殊依赖，选 AMD

### 关键注意事项

**⚠️ 第一年激活时间限制**

注册后需要在 **12 个月内** 激活 2 个 AMD 实例，否则会取消免费额度。

**⚠️ 限制 Egress 流量**

每月 10Mbps 出站带宽，足够建站 + 拉取 GitHub 代码，但不要开什么 BT 下载。

**⚠️ 2 个 ARM 实例同时运行**

官方限制是"最多 2 个"同时运行，其他会自动停止。批量跑任务的话要注意。

**⚠️ 项目关联规则**

Oracle 要求你关联 2 个项目才能保留免费额度，用来管理不同环境很方便。

## Google Cloud Always Free

Google Cloud 的免费层更偏「服务型」，不是直接给你一台 VPS，而是免费额度可以用来跑各种云服务。

### 可用服务（2026）

| 服务 | 免费额度 | 说明 |
|------|----------|------|
| Compute Engine | 1个实例/月 | 3 vCPU + 13GB RAM |
| Cloud Run | 250,000请求/月 | 无服务器容器 |
| Cloud SQL | 0.75 ECU-月/月 | MySQL/PostgreSQL |
| Cloud Storage | 10GB/月 | 对象存储 |
| BigQuery | 1 TB 基础配额 | 数据分析 |
| Cloud Vision API | 1,000请求/月 | 图像识别 |
| Translation API | 2M字符/月 | 翻译 |

### 适用场景对比

```
┌─────────────────────────┬─────────────────────────────┐
│   Oracle Cloud          │    Google Cloud             │
├─────────────────────────┼─────────────────────────────┤
│ 拿到一台完整服务器        │ 服务调用额度                 │
│ 托管博客、自建服务        │ 无服务器应用、API 调用      │
│ 适合长期运行             │ 适合测试、开发               │
└─────────────────────────┴─────────────────────────────┘
```

## 如何注册 Oracle Cloud Free Tier

### 第一步：准备账号

你需要：
- 有效邮箱
- 国际信用卡（不用扣款，只验证）
- 手机号（可接收短信）

⚠️ **注意**：Oracle 支持部分中国号码，如果收不到短信就换个临时手机号。

### 第二步：创建账号

1. 访问 https://www.oracle.com/cloud/free/
2. 点击 "Get Started Free"
3. 填写注册信息，绑定 Oracle Account

### 第三步：完成 KYC

提交个人信息后，等待审批（通常几分钟到几小时）。邮件通知即可。

### 第四步：创建 OCID 和密钥

注册完成后：
1. 登录控制台
2. 点击右上角头像 → Account → Account Settings
3. 复制 "OCID" 和 "Region"
4. 生成 SSH 密钥（Linux 生成命令：`ssh-keygen -t ed25519 -C "your_email@example.com"`）

### 第五步：创建实例

1. 进入 Compute → Create Instance
2. 基础配置：
   - Name: `hugo-blog`
   - Shape: Arm Shape A1.Flex (1/2 OCPU + 12GB RAM)
   - Image: Ubuntu 24.04 LTS
   - SSH Keys: 粘贴公钥
3. Network: 选择默认虚拟云网络
4. 硬盘：不用改，200GB 自动分配
5. 点击 Create

等待 1-3 分钟实例启动完成。

## 部署到 Cloudflare Pages（推荐）

既然有公网 IP，最佳方案是：VPS 作为 Git 仓库，推送到 Cloudflare Pages 自动部署。

### 方案架构

```
┌─────────────────────────────────────────────────────────────┐
│  本地电脑                                                     │
│         ↓                                                    │
│  Git Push → VPS (Gitea/Gogs) → Cloudflare Pages 构建部署    │
└─────────────────────────────────────────────────────────────┘
```

### 步骤

**1. 在 VPS 上安装 Gitea**

```bash
docker run -d \
  --name=gitea \
  -p 2222:22 \
  -p 3000:3000 \
  -v /var/lib/gitea:/data \
  -v ~/.ssh:/etc/ssh \
  -e USER_UID=1000 \
  -e USER_GID=1000 \
  gitea/gitea:latest
```

**2. 配置 SSH 访问**

```bash
# 在本地添加 VPS 的 SSH 密钥
cat ~/.ssh/id_ed25519.pub | ssh root@YOUR_VPS_IP "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

**3. 部署 Cloudflare Pages**

```bash
# 安装 Wrangler
npm install -g wrangler

# 创建项目
wrangler pages project create myblog \
  --production-branch=main \
  --git-deployment

# 将 VPS 上的 Gitea 仓库推送到 Pages
cd /var/lib/gitea/git/myblog.git
git push -u origin main --mirror
```

完成后，每次你推送到 VPS 的 Gitea 仓库，Cloudflare Pages 就会自动触发构建和部署。

## 免费 VPS 使用建议

### 适合做的事情

| 类型 | 说明 | 示例 |
|------|------|------|
| 技术博客 | Hugo/VuePress + Cloudflare Pages | 你现在的博客 |
| 开发环境 | Git 仓库、CI/CD 服务器 | Gitea + Actions |
| 学习实验 | 搭建各种服务 | 5MChatGPT、各种开源项目 |
| 内网穿透 | 部署到 Cloudflare Tunnel | 随时随地访问内网服务 |

### 不建议做的事情

| 类型 | 原因 |
|------|------|
| BT 下载 | 带宽限制 + 会影响邻居 |
| 大文件托管 | 10Mbps 出站会爆表 |
| 高并发服务 | 免费层性能有限 |
| 长期存储 | 数据安全靠不住 |

### 安全建议

1. **防火墙**：只开放必要端口（22 SSH, 80 8080 HTTP, 443 HTTPS）
2. **SSH 密钥**：禁用密码登录，只用密钥
3. **系统更新**：定期 `apt update && apt upgrade`
4. **备份**：Object Storage 定期备份重要数据
5. **监控**：设置简单的日志监控

## 常见问题

**Q: 免费层真的永久吗？**

A: 目前是永久的，但条款可能随时变化。用着放心，用完再删也不可惜。

**Q: 可以申请多个账号吗？**

A: 理论上可以，但 Oracle 会限制同一身份证号能申请的数量。多账号风险自己承担。

**Q: 速度怎么样？**

A: Oracle 的线路质量因地区而异，国内访问有时会慢。部署到 Cloudflare Pages 可以解决访问问题。

**Q: 硬盘空间够用吗？**

A: 200GB 很充裕，放代码库、Docker 镜像都够用。但别当网盘用。

**Q: 遇到问题去哪问？**

A:
- Oracle 官方文档：https://docs.oracle.com/en-us/iaas/
- GitHub Issues：https://github.com/oracle/oci-cli/issues
- V2EX: [免费 VPS 組](https://www.v2ex.com/go/freedom)

## 💡 付费 VPS 推荐

免费 VPS 适合学习和测试，生产环境建议用付费 VPS，稳定性更有保障。

| 推荐 | 价格 | 适合人群 |
|------|------|----------|
| [**RackNerd**](https://my.racknerd.com/aff.php?aff=20566) 🏆 | 年付 $10.88 起 | 新手首选，性价比最高 |
| [**搬瓦工 BandwagonHost**](https://bandwagonhost.com/aff.php?aff=20566) | 年付 $49.99 起 | 需要稳定线路的老手 |

## 写在最后

免费 VPS 真的香，特别是 Oracle Cloud 这种「拿来就能用」的。

这篇文章的主要内容来自我的亲测经验 + 官方文档 + 2026年的最新更新。如果发现过时的信息，欢迎在评论区指出。

**推荐行动路线：**
1. 立刻去注册一个 Oracle 账号
2. 花 10 分钟完成 KYC
3. 创建第一个免费实例
4. 开始你的建站之旅

**我的分享链接**：https://www.oracle.com/cloud/free/

有问题欢迎留言，或者直接发邮件到 `daipo971@gmail.com`。

---

**参考资料：**
- [Oracle Cloud Free Tier 官方页面](https://www.oracle.com/cloud/free/)
- [Google Cloud Always Free 2026 更新](https://cloud.google.com/free)
- [V2EX 免费 VPS 組](https://www.v2ex.com/go/freedom)
