# Agent Reach — 互联网能力路由器

你的 Agent Reach（版本 1.5.0）已安装完成。

## 安装位置

- **Skill 文件**：`~/.agents/skills/agent-reach/SKILL.md`
- **配置目录**：`~/.agent-reach/`
- **工具目录**：`~/.agent-reach/tools/`

## 可用渠道（10/15）

| 渠道 | 状态 | 用法 |
|------|------|------|
| 🌐 任意网页 (Jina Reader) | ✅ 即用 | `curl -s "https://r.jina.ai/URL"` |
| 🔍 全网语义搜索 (Exa) | ✅ 即用 | `mcporter call 'exa.web_search_exa(...)'` |
| 📡 RSS/Atom | ✅ 即用 | `python3 -c "import feedparser; ..."` |
| 💻 V2EX | ✅ 即用 | 公开 API |
| 🐦 Twitter/X | ✅ 已装 | `opencli twitter search ... -f yaml` |
| 📘 Facebook | ✅ 已装 | `opencli facebook search ... -f yaml` |
| 📷 Instagram | ✅ 已装 | `opencli instagram search ... -f yaml` |
| 📺 B站 | ✅ 已装 | `opencli bilibili search ... -f yaml` |
| 📕 小红书 | ✅ 已装 | `opencli xiaohongshu search ... -f yaml` |
| 📖 Reddit | ✅ 已装 | `opencli reddit search ... -f yaml` |
| 🐙 GitHub | ⚠️ 需认证 | `gh auth login` |
| ▶️ YouTube | ❌ 未装 | `pip install yt-dlp` |

## 触发规则

当用户需要以下操作时，**必须引用 agent-reach skill**（`~/.agents/skills/agent-reach/SKILL.md`）：

- **调研/搜索**：全网调研、查资料、搜信息
- **社交媒体**：小红书、Twitter/X、B站、Reddit、Facebook、Instagram、V2EX
- **招聘/职位**：LinkedIn
- **GitHub**：代码搜索、仓库、Issue、PR
- **网页/文章**：RSS、链接阅读
- **视频**：YouTube、B站视频、播客、字幕

## 快速命令

```bash
# 健康检查
agent-reach doctor
agent-reach doctor --json    # JSON 格式（含 active_backend）

# 安装更多渠道
agent-reach install --channels=all
agent-reach install --channels=twitter,xiaohongshu,...

# 检查更新
agent-reach check-update

# 升级（复制这句话给 Agent）
帮我更新 Agent Reach：https://raw.githubusercontent.com/Panniantong/agent-reach/main/docs/update.md
```
