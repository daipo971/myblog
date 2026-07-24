---
title: "Linux服务器入门教程：零基础搭建网站和部署项目"
date: 2026-07-25
description: "Linux服务器从零到一的入门教程，教你服务器选购、SSH连接、LNMP环境搭建、网站部署、安全配置和日常管理。"
summary: "Linux服务器入门完整教程，包含VPS购买、SSH连接、LNMP、Docker、站点部署和安全配置。"
tags: ["Linux", "服务器", "VPS", "建站", "运维", "入门教程"]
showtoc: true
---

# Linux服务器入门教程：零基础搭建网站和部署项目

买了VPS不知道干嘛？SSH连上去一片黑屏？这篇教程就是给你写的。

我从零开始学Linux服务器到现在，踩过的坑全写在这里。看完这篇，你就能有自己的服务器，跑网站、搭服务、部署项目。

## 第一步：选购你的第一台服务器

如果你还没有VPS，推荐从这些开始：

| 推荐 | 配置 | 价格 | 适合 |
|-----|------|------|-----|
| RackNerd | 1核1G 20G SSD | $10.88/年 | 入门首选 |
| 甲骨文免费 | 2核1G 200G | 免费 | 白嫖党 |
| 搬瓦工 | 1核1G 20G SSD | $49.99/年 | 稳定为主 |

> 💡 **入门推荐**：RackNerd $10.88/年套餐，白菜价，练习用完全够了。
> 👉 [RackNerd优惠链接](https://my.racknerd.com/aff.php?aff=20566)

## 第二步：SSH连接服务器

### Windows用户

推荐使用 **Termius** 或 **Windows Terminal + WSL**：

1. 打开终端
2. 输入命令：
```bash
ssh root@你的服务器IP
```
3. 输入密码（Linux终端输入密码不会显示，正常现象）

### Mac用户

Mac自带终端，直接：
```bash
ssh root@你的服务器IP
```

### 配置SSH密钥登录（提高安全性）

```bash
# 在本地电脑生成密钥
ssh-keygen -t ed25519 -C "你的邮箱"

# 复制公钥到服务器
ssh-copy-id root@你的服务器IP

# 以后登录不需要密码了
```

## 第三步：服务器基本配置

### 3.1 更新系统

连上服务器后，第一件事是更新：

```bash
# Ubuntu/Debian
apt update && apt upgrade -y

# CentOS
yum update -y
```

### 3.2 设置主机名

```bash
hostnamectl set-hostname your-server-name
```

### 3.3 创建普通用户

不要一直用root操作，创建一个普通用户：

```bash
# 创建用户
adduser yourname

# 添加到sudo组
usermod -aG sudo yourname

# 切换到新用户
su - yourname
```

### 3.4 配置防火墙

```bash
# 安装UFW
apt install ufw -y

# 配置规则
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# 启用防火墙
ufw enable

# 查看状态
ufw status
```

> ⚠️ 配置防火墙前确保SSH端口已放行，否则你会把自己锁在外面。

## 第四步：安装Web环境（LNMP）

### 安装Nginx

```bash
apt install nginx -y

# 启动并设置开机自启
systemctl start nginx
systemctl enable nginx

# 检查状态
systemctl status nginx
```

访问 http://你的服务器IP，看到Nginx欢迎页面就成功了。

### 安装MySQL

```bash
apt install mysql-server -y

# 安全配置
mysql_secure_installation
```

### 安装PHP

```bash
# Ubuntu 22.04 安装 PHP 8.2
apt install php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml -y
```

### 验证LNMP环境

```bash
# 在网站根目录创建测试文件
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
```

访问 http://你的服务器IP/info.php

## 第五步：部署你的第一个网站

### 5.1 创建网站目录

```bash
mkdir -p /var/www/你的域名
chown -R www-data:www-data /var/www/你的域名
```

### 5.2 配置Nginx站点

```bash
# 创建配置文件
nano /etc/nginx/sites-available/你的域名
```

配置文件内容：
```nginx
server {
    listen 80;
    server_name 你的域名;
    root /var/www/你的域名;
    index index.html index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
    }
}
```

### 5.3 启用站点

```bash
ln -s /etc/nginx/sites-available/你的域名 /etc/nginx/sites-enabled/
nginx -t        # 测试配置是否正确
systemctl reload nginx  # 重新加载Nginx
```

## 第六步：Docker基础（推荐）

Docker让部署变得超简单，强烈建议装一个。

### 安装Docker

一键安装：
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

### 用Docker部署应用

**例子：部署一个WordPress博客**
```bash
docker run -d \
  --name wordpress \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=db \
  -e WORDPRESS_DB_USER=wordpress \
  -e WORDPRESS_DB_PASSWORD=yourpassword \
  wordpress
```

**例子：部署一个个人网盘**
```bash
docker run -d \
  --name nextcloud \
  -p 8081:80 \
  -v /your/data:/var/www/html/data \
  nextcloud
```

**Docker Compose（管理多个容器）：**
```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
```

更多Docker教程：👉 [Cloudflare Pages 对接Docker](/posts/cloudflare-pages-tutorial-2026/)

## 第七步：日常维护命令

### 系统监控

```bash
# 查看CPU和内存
htop                         # 交互式进程查看
free -h                      # 内存使用
df -h                        # 磁盘使用

# 查看网络
iftop                        # 实时流量
netstat -tlnp                # 查看端口监听

# 查看日志
tail -f /var/log/nginx/access.log  # Nginx访问日志
journalctl -u nginx -f             # 系统日志
```

### 备份和恢复

```bash
# 备份网站文件
tar -czf backup-$(date +%Y%m%d).tar.gz /var/www/

# 备份数据库
mysqldump -u root -p 数据库名 > backup.sql
```

### 自动更新

```bash
# 配置无人值守更新
apt install unattended-upgrades -y
dpkg-reconfigure --priority=low unattended-upgrades
```

## 第八步：安全配置清单

基本的安全配置，新手必做：

- [x] 更换SSH默认端口（22改为其他端口）
- [x] 禁止root登录（用普通用户+sudo）
- [x] 配置防火墙（只开放必要端口）
- [x] 开启Fail2Ban防暴力破解
- [x] 定期更新系统
- [x] 配置自动备份

### 配置Fail2Ban

```bash
apt install fail2ban -y

# 配置SSH保护
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl restart fail2ban
```

## 九、实用小技巧

### 终端美化

```bash
# 安装zsh（比bash更好用）
apt install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 文件传输

```bash
# 上传文件到服务器
scp localfile.txt root@你的IP:/root/

# 从服务器下载文件
scp root@你的IP:/root/remotefile.txt ./

# 使用rsync同步目录
rsync -avz ./localdir root@你的IP:/remote/dir/
```

### 快速查找文件

```bash
find / -name "文件名"
grep -r "关键词" /var/www/  # 在网站文件中搜索关键词
```

## 总结

学会Linux服务器不需要三个月。按照这篇教程操作一遍：

1. 买一台便宜的VPS（$10年付）
2. SSH连上去
3. 跟着步骤配置环境
4. 部署你的第一个网站

**一晚上就够了。**

以后你需要什么服务，都能自己搭。不用依赖任何第三方平台，真正拥有自己的"领地"。

---

**相关阅读：**
- 👉 [低价VPS推荐：年付$10起的性价比之王](/posts/cheap-vps-recommendations-2026/)
- 👉 [免费VPS指南：Oracle Cloud永久免费](/posts/free-vps-guide/)
- 👉 [从零搭建个人博客](/posts/free-blog-tutorial/)
- 👉 [Cloudflare Pages完全教程](/posts/cloudflare-pages-tutorial-2026/)
