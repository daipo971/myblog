# 赚钱计划操作手册

## 核心理念

> **只做一件事：写文章 → 推送 → Cloudflare自动部署**
>
> 砍掉所有推广脚本、小红书、Twitter、知乎。那些是0，文章是1。

---

## 每日流程（15分钟）

```bash
# 1. 写文章（内容在 content/posts/）
#    用你习惯的方式写 Markdown 文件就行

# 2. 预览（可选）
hugo server -D

# 3. 推送更新（一键）
hugo                        # 构建静态文件
git add -A                  # 暂存所有更改
git commit -m "Add: 文章标题"  # 提交
git push                    # 推送到 GitHub → Cloudflare 自动部署

# 搞定。等1-2分钟网站就更新了。
```

---

## 文章写作规范

### 文件头模板
```yaml
---
title: "你的文章标题"
date: 2026-07-15
description: "搜索结果显示的简短描述，包含关键词"
summary: "文章摘要"
tags: ["标签1", "标签2", "标签3"]
showtoc: true
---
```

### 写作要点
- **标题包含关键词**（别人会搜什么词）
- **前100字抓住人**（搜索结果的片段）
- **每500字加一个小标题**（方便扫读）
- **结尾加相关文章链接**（留住读者）

### 内链策略（重要）
每篇新文章至少链接到2篇旧文章：
```markdown
👉 相关阅读：[ChatGPT 4o免费版评测](/posts/chatgpt-4o-free-guide-2026/)
👉 更多：[VPS推荐清单](/posts/cheap-vps-recommendations-2026/)
```

### 联盟链接自然插入
推荐工具时顺手加链接，不要硬塞：
```markdown
如果你需要一台便宜的服务器试试，[RackNerd 年付 $10.88 起](https://my.racknerd.com/aff.php?aff=20566)
写代码的话，[Cursor](https://cursor.sh/) 免费版就够用
```

---

## 当前文章清单（46篇）

### 赚钱潜力最高（优先更新和引流）
| 文章 | 主题 | 变现方式 |
|------|------|----------|
| `make-money-with-ai-2026` | AI赚钱方法 | 联盟链接 + 社群 |
| `cheap-vps-recommendations-2026` | 低价VPS | RackNerd佣金 |
| `free-vps-guide` | 免费VPS | →引流到低价VPS |
| `claude-guide` | Claude教程 | Claude Pro链接 |
| `cursor-ai-tutorial-2026` | Cursor教程 | Cursor链接 |
| `free-ai-tools-2026` | 免费AI工具 | 多工具链接 |
| `save-money-with-ai` | AI省钱 | 多工具链接 |

### 长尾SEO潜力高
- `ai-prompt-engineering-guide-2026` — 提示词工程
- `ai-image-generation-comparison-2026` — AI绘画对比
- `free-ai-api-guide` — 免费API
- `free-domain-guide` — 免费域名
- `free-blog-tutorial` — 零成本建站

### 待写的方向（高流量）
- "2026年最值得订阅的AI工具"（付费推荐合集）
- "AI工具月度省钱攻略"（持续引流）
- "学生党AI工具组合"（学生群体精准）

---

## 关键命令快捷方式

```bash
# 构建 + 推送（一条命令）
hugo && git add -A && git commit -m "Update: $(date +'%Y-%m-%d')" && git push

# 仅构建预览
hugo server -D

# 查看未推送的更改
git status
```

---

## 避坑提醒

- ❌ 不要花时间在推广脚本上 → 文章本身就是最好的推广
- ❌ 不要纠结排版 → 内容比样式重要
- ✅ 每天写一篇比一周憋一篇强10倍
- ✅ 联盟链接放自然一点，不要像广告
- ✅ 旧文章也可以更新日期重新推送（SEO友好）

---

## 当前进度

- [x] 46篇文章已上线
- [x] 联盟链接已布局（RackNerd, BandwagonHost, Cursor, Claude, ChatGPT）
- [x] 推送机制已打通（GitHub → Cloudflare Pages）
- [ ] 下一篇：__________（手写填入）

---

## 推特自动化运营 (2026-07-15新增)

### 运营方式
使用 `opencli` 浏览器控制工具，直接操作推特网页版发布推文，无需 API Key。

### 文件说明
- `auto-twitter-manager.sh` - 自动运营管理脚本（获取热点、发布推文、关注用户）
- `auto-twitter-daemon.sh` - 定时守护进程（每天 08:00 / 12:00 / 20:00 自动执行）
- `auto-tweets.txt` - 预设推文库（27条，持续新增中）
- `promotion-schedule.txt` - 推广时间表

### 命令手册
```bash
# 查看运营统计
./auto-twitter-manager.sh stats

# 手动运行一次运营任务
./auto-twitter-manager.sh run

# 查看守护进程状态
./auto-twitter-daemon.sh status

# 启动守护进程（后台）
nohup ./auto-twitter-daemon.sh start &>/dev/null &

# 停止守护进程
./auto-twitter-daemon.sh stop
```

### 运营计划
每天 08:00、12:00、20:00 自动发布推文
- 每条推文链接到博客文章引流
- 基于推特实时热门趋势生成内容
- 每2天关注相关领域用户增加粉丝
