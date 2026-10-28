---
title: "Linux 服务器入门教程：零基础搭建网站和部署项目"
date: 2026-07-25T06:00:00+08:00
lastmod: 2026-10-28T09:00:00+08:00
description: "Linux 服务器零基础入门：选购 VPS、SSH 密钥登录、创建普通用户、防火墙、安装 Nginx 和 PHP、部署网站并配置 HTTPS、用 Docker Compose 跑应用、备份和安全加固，附常见报错和常见问题。"
summary: "Linux 服务器入门完整教程：VPS 选购、SSH、Nginx、HTTPS、Docker、备份和安全配置。"
categories: ["建站与副业"]
tags: ["教程", "VPS", "建站"]
showtoc: true
---

**结论先说：** 新手管理一台 Linux 服务器，按这个顺序做就不会乱：**SSH 密钥登录 → 创建普通用户 → 开防火墙 → 装 Nginx 部署网站 → 配 HTTPS → 用 Docker 跑其他应用 → 设置备份**。本文以 Ubuntu 24.04 为例，每一步给出可以直接复制的命令，最后列出新手最常遇到的报错和解决办法。照着做一遍，大约一个晚上就能让自己的服务器跑起网站。

## 前置条件

| 项目 | 要求 |
| --- | --- |
| 服务器 | 一台 VPS，1 核 1GB 内存起步，系统选 Ubuntu 24.04 或 Debian 12 |
| 本地电脑 | Windows 10/11、macOS 或 Linux，能打开终端 |
| 域名（可选） | 部署网站和配置 HTTPS 时需要，免费域名见 [免费域名注册教程](/posts/free-domain-guide/) |
| 基础 | 会复制粘贴命令即可，不需要编程经验 |

## 第一步：选购服务器

| 类型 | 例子 | 特点 | 适合 |
| --- | --- | --- | --- |
| 低价年付 VPS | RackNerd 等 | 年付价格低，配置够练手和跑小网站 | 入门首选 |
| 免费云服务器 | Oracle Cloud 免费层 | 免费但注册门槛高、资源可能被回收 | 想零成本练手，见 [免费 VPS 指南](/posts/free-vps-guide/) |
| 线路优化 VPS | 搬瓦工等 | 价格较高，到国内线路更稳定 | 访问速度要求高 |
| 国内云服务器 | 阿里云、腾讯云 | 访问快，但网站需要备案 | 面向国内用户的正式网站 |

具体套餐和价格对比见 [低价 VPS 推荐](/posts/cheap-vps-recommendations-2026/)。

> 披露：下面的 RackNerd 链接为本站联盟链接，通过链接购买本站可能获得佣金，不影响你的价格。
> 👉 [RackNerd 优惠套餐](https://my.racknerd.com/aff.php?aff=20566)

购买时注意：系统选 **Ubuntu 24.04 LTS**（教程最多、支持期长）；记下服务商邮件里的 **IP 地址和 root 密码**。

## 第二步：SSH 连接服务器

SSH 是远程登录服务器的方式。Windows 10/11、macOS、Linux 都自带 `ssh` 命令：

```bash
ssh root@你的服务器IP
```

第一次连接会询问是否信任该主机，输入 `yes`。输入密码时屏幕不会显示任何字符，这是正常的，输完按回车即可。

图形界面工具可以用 Termius、Windows Terminal 等，原理相同。

### 配置 SSH 密钥登录

密码登录容易被暴力破解，建议尽快改成密钥登录。在**本地电脑**执行：

```bash
# 生成密钥，一路回车即可
ssh-keygen -t ed25519 -C "my-laptop"

# 把公钥上传到服务器（Windows 没有 ssh-copy-id 时，见下方说明）
ssh-copy-id root@你的服务器IP
```

Windows 用户可以手动复制：用记事本打开 `C:\Users\你的用户名\.ssh\id_ed25519.pub`，把内容追加到服务器的 `~/.ssh/authorized_keys` 文件里。之后再 `ssh root@IP`，就不需要输入密码了。

## 第三步：基础配置

### 更新系统

```bash
apt update && apt upgrade -y
```

### 创建普通用户

日常不要一直用 root 操作，误删文件的代价太大：

```bash
adduser yourname            # 按提示设置密码
usermod -aG sudo yourname   # 允许使用 sudo
rsync --archive --chown=yourname:yourname ~/.ssh /home/yourname   # 复制密钥，让新用户也能用密钥登录
```

**新开一个终端窗口**测试 `ssh yourname@你的服务器IP` 能否登录、`sudo ls` 能否执行，确认没问题再进行下一步。

### 配置防火墙

```bash
sudo ufw allow OpenSSH      # 一定先放行 SSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

> ⚠️ 先放行 SSH 再启用防火墙，否则会把自己锁在外面。很多服务商的控制台还有一层「安全组」，端口要在两边都放行。

## 第四步：安装 Nginx 并部署网站

### 安装 Nginx

```bash
sudo apt install nginx -y
sudo systemctl enable --now nginx
```

浏览器访问 `http://你的服务器IP`，看到 Nginx 欢迎页就成功了。

### 部署一个静态网站

```bash
sudo mkdir -p /var/www/example.com
echo '<h1>Hello</h1>' | sudo tee /var/www/example.com/index.html
sudo chown -R www-data:www-data /var/www/example.com
```

创建站点配置 `sudo nano /etc/nginx/sites-available/example.com`：

```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    root /var/www/example.com;
    index index.html index.php;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

启用站点并检查配置：

```bash
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

在域名服务商（或 Cloudflare）添加一条 A 记录，把域名指向服务器 IP，等几分钟生效后用域名访问。

### 需要 PHP 时

运行 WordPress 等 PHP 程序，再安装 PHP 和数据库：

```bash
sudo apt install php-fpm php-mysql php-curl php-gd php-mbstring php-xml mariadb-server -y
sudo mysql_secure_installation
ls /run/php/            # 查看 php-fpm 的 sock 文件名，例如 php8.3-fpm.sock
```

在 Nginx 配置的 `server` 块里加入（sock 文件名按上一步的实际结果填写）：

```nginx
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php8.3-fpm.sock;
}
```

Ubuntu 24.04 默认的 PHP 版本是 8.3，不同系统版本不同，不要照抄网上写死的版本号。

## 第五步：配置 HTTPS

用免费的 Let's Encrypt 证书，Certbot 会自动修改 Nginx 配置并定期续期：

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d example.com -d www.example.com
```

完成后访问 `https://example.com` 检查。如果域名接入了 Cloudflare 并开启了代理（橙色云朵），也可以用 Cloudflare 的证书，SSL 模式选「完全（严格）」。

## 第六步：用 Docker 跑其他应用

Docker 让部署应用变成「写一个配置文件 + 一条命令」，不会把系统环境弄乱。

### 安装 Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER    # 重新登录后生效，之后不用每次加 sudo
```

### 用 Docker Compose 部署 WordPress

新建目录和 `compose.yaml`：

```yaml
services:
  db:
    image: mariadb:11
    restart: always
    environment:
      MARIADB_DATABASE: wordpress
      MARIADB_USER: wordpress
      MARIADB_PASSWORD: 换成你的强密码
      MARIADB_RANDOM_ROOT_PASSWORD: "1"
    volumes:
      - db_data:/var/lib/mysql
  wordpress:
    image: wordpress
    restart: always
    ports:
      - "127.0.0.1:8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: 换成你的强密码
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp_data:/var/www/html
volumes:
  db_data:
  wp_data:
```

```bash
docker compose up -d
docker compose ps
```

端口只绑定在 `127.0.0.1`，再用 Nginx 反向代理到域名并配置 HTTPS，比直接把 8080 端口暴露到公网更安全。反向代理的 `location` 写法：

```nginx
location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

## 第七步：日常维护

```bash
free -h                 # 内存
df -h                   # 磁盘
sudo ss -tlnp           # 哪些端口在监听
sudo apt install htop -y && htop    # 交互式查看进程
sudo tail -f /var/log/nginx/error.log   # Nginx 错误日志
sudo journalctl -u nginx -n 50          # 服务日志
```

### 备份

```bash
# 网站文件
sudo tar -czf ~/site-$(date +%F).tar.gz /var/www/example.com
# 数据库
sudo mysqldump --all-databases > ~/db-$(date +%F).sql
```

备份文件要下载到本地或上传到对象存储，**只放在同一台服务器上不算备份**。可以用 `crontab -e` 设置每天自动执行。很多服务商也提供快照功能，大改动前先拍一个快照。

### 自动安全更新

```bash
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

## 第八步：安全加固清单

| 项目 | 做法 |
| --- | --- |
| 禁止密码登录 | 确认密钥登录可用后，编辑 `/etc/ssh/sshd_config`，设置 `PasswordAuthentication no`，然后 `sudo systemctl restart ssh` |
| 禁止 root 直接登录 | 同一文件设置 `PermitRootLogin no` |
| 防暴力破解 | `sudo apt install fail2ban -y`，默认就会保护 SSH |
| 只开必要端口 | `ufw status` 定期检查 |
| 及时更新 | 开启自动安全更新 |
| 定期备份 | 异地备份 + 服务商快照 |

修改 SSH 配置后，**保持当前窗口不关**，另开一个窗口测试能否登录，确认没问题再退出，避免把自己锁在外面。

## 常见报错与解决

| 报错 | 原因 | 解决 |
| --- | --- | --- |
| `Connection timed out` | IP 写错、服务器没开机、防火墙或安全组没放行 22 端口 | 在服务商控制台检查状态和安全组，用控制台的网页终端登录排查 |
| `Permission denied (publickey)` | 已禁用密码登录但本地没有对应私钥，或用户名写错 | 用控制台网页终端登录，检查 `~/.ssh/authorized_keys` |
| `REMOTE HOST IDENTIFICATION HAS CHANGED` | 服务器重装系统后指纹变了 | 本地执行 `ssh-keygen -R 你的服务器IP` |
| 浏览器打不开网站 | 80/443 端口没放行，或 Nginx 没启动 | `sudo ufw status`、`systemctl status nginx`，检查安全组 |
| `502 Bad Gateway` | PHP-FPM 或后端容器没运行，sock/端口写错 | `systemctl status php8.3-fpm`、`docker compose ps`，核对配置 |
| `nginx -t` 报错 | 配置语法错误（多半是少了分号或括号） | 按报错提示的行号检查 |
| Certbot 申请证书失败 | 域名没解析到服务器，或 80 端口不通 | 用 `ping 域名` 检查解析，确认 80 端口开放 |
| 磁盘满了 | 日志或 Docker 镜像占满空间 | `sudo du -sh /var/log/*`、`docker system prune` |

## 常见问题

**服务器选 Ubuntu 还是 CentOS？**
新手选 Ubuntu 或 Debian。CentOS 8 及之后的传统版本已经停止维护，新教程和软件包支持也以 Ubuntu、Debian 为主。

**1 核 1GB 的服务器够用吗？**
跑个人博客、静态网站和几个轻量 Docker 应用够用。WordPress 加数据库会比较吃紧，建议加 1–2GB 的 swap，或选 2GB 内存的套餐。

**用宝塔这类面板可以吗？**
可以，面板对新手更直观。但建议至少手动走一遍本文流程，理解 Nginx、端口、防火墙的关系，遇到问题时才知道去哪里排查。

**国内访问网站很慢怎么办？**
海外服务器到国内的线路质量差别很大。可以给网站接入 Cloudflare，或选择线路优化的服务商；面向国内用户的正式网站，用国内服务器并完成备案是最稳的方案。

**静态博客一定要用服务器吗？**
不一定。Hugo、Hexo 这类静态博客可以免费托管在 Cloudflare Pages，不用维护服务器，见 [Cloudflare Pages 教程](/posts/cloudflare-pages-tutorial-2026/)。服务器适合需要后端程序、数据库或自托管应用的场景。

## 更新记录

- 2026-10-28：删除无法核实的个人经历表述
- 2026-10-28：按 Ubuntu 24.04 重写并补充前置条件、HTTPS、Docker Compose 完整示例、反向代理、常见报错和常见问题；修正 Ubuntu 22.04 安装 php8.2 的错误命令、缺少数据库的 WordPress 示例；联盟链接补充披露；删除已停止维护的 CentOS 命令

## 相关阅读

- [低价 VPS 推荐](/posts/cheap-vps-recommendations-2026/)
- [免费 VPS 指南：Oracle Cloud 免费层](/posts/free-vps-guide/)
- [从零搭建个人博客](/posts/free-blog-tutorial/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
