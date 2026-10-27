# 08 数据与复盘

## 指标体系

| 层级 | 指标 | 数据来源 | 频率 |
| --- | --- | --- | --- |
| 北极星 | 月自然搜索点击（中 + 英） | Google Search Console + Bing Webmaster | 月 |
| 增长 | 展现量、平均排名、点击率（按支柱、按语言拆分） | Search Console | 月 |
| 收录 | 已编入索引页数 / 总页数 | Search Console「网页索引」 | 月 |
| 内容 | 新发篇数、更新篇数、档案页数、各支柱篇数 | 仓库统计（见下方命令） | 月 |
| 质量 | 自检脚本不通过的文章数；无站内链接、无来源、无图片的文章数 | `scripts/lint_posts.py --all` | 月 |
| 分发 | Telegram 订阅数、单条点击 | Telegram 频道统计 | 月 |
| 收入 | 商城订单、联盟点击与佣金 | 商城后台、联盟后台 | 月 |

站长需要给 AI 提供 Search Console / Bing 的导出数据（CSV），AI 才能做数据复盘。

## 仓库统计命令

```bash
# 各支柱文章数（中文）
for c in 中国与开源模型 AI工具实测 AI应用场景 AI前沿动态 海外服务通关 建站与副业; do
  printf "%s\t" "$c"; grep -l "categories: \[\"$c\"\]" content/posts/*.md | grep -vc '\.en\.md'
done
# 本月新增与更新
git log --since="1 month ago" --diff-filter=A --name-only --format= -- content/posts | sort -u | wc -l
git log --since="1 month ago" --diff-filter=M --name-only --format= -- content/posts | sort -u | wc -l
# 全站质量检查
python3 scripts/lint_posts.py --all --summary
```

## 每月复盘模板

复盘结果写进 `docs/reviews/YYYY-MM.md`，结构：

```
# YYYY-MM 月度复盘
## 数字           （北极星、增长、收录、内容、收入，对比上月）
## 表现最好的 10 篇  （点击最多；看能不能再补强、加内链、加变现）
## 机会页面        （展现高、点击率低 → 改标题和描述；排名 8–20 → 补内容）
## 问题页面        （0 展现超过 3 个月、被蚕食、数据过时）
## 下月动作        （具体到文章和负责人，同步进 backlog 和 content-plan）
```

## 动作阈值

| 情况 | 判定 | 动作 |
| --- | --- | --- |
| 展现多、点击率低 | 展现 > 500 且 CTR < 1% | 改标题和 description，让结论更明确 |
| 排名 8–20 位 | 平均排名 8–20 | 补内容（FAQ、表格、截图），加 2–3 条内链指向它 |
| 长期无展现 | 发布 > 6 个月，近 3 个月展现 < 10 | 合并进相关文章（301）或重写；快讯直接并入档案页 |
| 关键词蚕食 | 同一查询词 ≥ 2 个本站网址有展现 | 合并或区分意图 |
| 数据过时 | 价格、版本落后于官方 | 立即更新，写更新记录 |
| 支柱失衡 | 某支柱连续 2 个月零新文 | 下月优先排该支柱 |

## 季度复盘

- 对照 [01-positioning.md](01-positioning.md) 的阶段目标，校准下季度目标。
- 更新 [02-topic-map.md](02-topic-map.md) 的覆盖列和优先级。
- 决定英文端投入：英文流量占比和增速。
- 重排 [backlog.md](backlog.md)。
