# 09 AI 执行手册

这一章写给接手这个仓库的 AI（Claude 或其他）。目标：任何一个 AI 拿到任务，不用再问站长，就能按同一个标准做完。

## 铁律

1. **不编造**：不编数据、不编网址、不编经历。来源链接必须是真实打开过或搜索结果里原样出现的；查不到就写「暂无官方信息」，不写这条。
2. **不冒充实测**：没有真实操作过的，不写「我实测」「用了 X 个月」。需要实测和截图的，列给站长（见下方「必须交给站长的事」）。
3. **先查重再写**：`grep -ril "关键词" content/posts`。同一意图已有文章 → 更新旧文。
4. **不改已发布网址**：合并、删除必须加 301。
5. **硬规则以 CLAUDE.md 为准**，本框架解释怎么做。站长在对话里的最新指示优先于两者。
6. **每次改动走 PR**，构建通过、自检通过再合并（站长已授权常规内容 PR 在预览构建通过后由 AI 自行合并）。

## 标准作业流程（SOP）

### SOP-1 写一篇新文章

```
1. 领题      从 docs/framework/backlog.md 选状态为「待写」的最高优先级题目，改成「进行中」。
2. 查重      grep -ril "<关键词>" content/posts；有同意图文章就转 SOP-3。
3. 定类型    按 04-content-system.md 选类型；按 02-topic-map.md 的归类规则选分类。
4. 建文件    hugo new content --kind <news|profile|tutorial|review|guide|explainer> posts/<slug>.md
             把 date / lastmod 改成北京时间 +08:00，且不晚于实际推送时间。
5. 调研      找一手来源（06-operations.md 信息源表），记下每个数据的出处。
6. 写作      按骨架写；开头 100 字给结论；数据标来源；厂商数据写「官方说法」。
7. 链接      ≥ 3 个站内链接；快讯第一条相关阅读是档案页；回到 2–3 篇旧文加指向新文的链接。
8. 挂载      把新文加进对应支柱中心页（content/categories/<支柱>/_index.md）；有档案页的加进档案页。
9. 自检      python3 scripts/lint_posts.py   （ERROR 必须为 0）
10. 构建     hugo -d /tmp/pub && python3 scripts/check_links.py /tmp/pub
11. 提交     分支 claude/<任务名>，提 PR，预览构建通过后合并。
12. 收尾     backlog 状态改「已发布」并写网址；content-plan.md 有对应项就打勾。
```

### SOP-2 写快讯并更新档案页

1. 判断是否值得写（06-operations.md「快讯筛选标准」）。
2. 找至少 2 个一手来源；只有爆料没有官方确认 → 不写。
3. 用 `--kind news` 建文件，48 小时内发布。
4. 同一个 PR 里更新档案页：版本时间线加一行、价格 / 许可证有变就改、「相关快讯」加链接、改 `lastmod`、「更新记录」加一行。
5. 没有档案页且这是该模型 / 产品第 2 条新闻 → 同时新建档案页。

### SOP-3 更新旧文章

1. 改内容，`lastmod` 改为当前时间（+08:00）。
2. 正文末尾「更新记录」加一行：`- YYYY-MM-DD：改了什么。`
3. 标题里的年份过时就更新（网址不动）。
4. 顺手修掉自检脚本报的 ERROR。

### SOP-4 合并 / 删除文章

1. 确认要保留的目标文章；把被合并文章里有价值的内容并进去。
2. 删除旧文件；检查同名 `.en.md`，有就一起处理。
3. `static/_redirects` 加：`/posts/旧slug/ /posts/新slug/ 301`（有英文版再加 `/en/posts/旧slug/ /en/posts/新slug/ 301`）。
4. 全站搜索指向旧网址的链接并改成新网址：`grep -rl "/posts/旧slug/" content`。
5. 删除文章、改分类体系属于需要站长拍板的事；按已批准的计划执行时可直接做。

### SOP-5 补来源

1. 对每篇文章的关键数据（发布日期、参数、价格、跑分）找出处。
2. 在「相关阅读」之前加 `## 参考来源`，2–3 条，每条写「来源名：内容（语言）」。
3. 厂商自报数据在来源后加一句「文中跑分、价格等数据多为厂商官方说法」。
4. 找不到可靠来源的文章，在 backlog 记一笔，不硬加。

### SOP-6 月度复盘

1. 请站长提供 Search Console / Bing 的导出（查询词、页面、点击、展现、排名）。
2. 跑仓库统计和 `python3 scripts/lint_posts.py --all --summary`。
3. 按 08-metrics.md 的模板写 `docs/reviews/YYYY-MM.md`。
4. 把「下月动作」写进 backlog 和 content-plan.md。

### SOP-7 标签清理（存量）

1. 读 `data/taxonomy.yaml` 的 `synonyms`，把旧标签替换成新标签或删除。
2. 每篇补 1 个类型标签和至少 1 个主题标签，总数 3–5。
3. 分批做，每批一个 PR，跑自检确认标签类 ERROR 清零。

## 命令速查

```bash
# 查重
grep -ril "关键词" content/posts

# 新建文章（kind: news / profile / tutorial / review / guide / explainer）
hugo new content --kind tutorial posts/<slug>.md

# 自检（默认检查相对 origin/main 改动过的文章）
python3 scripts/lint_posts.py
python3 scripts/lint_posts.py content/posts/<slug>.md
python3 scripts/lint_posts.py --all --summary

# 构建 + 死链检查（Hugo 需 ≥ 0.146，线上为 0.167.0）
hugo -d /tmp/pub && python3 scripts/check_links.py /tmp/pub

# 某支柱的全部文章
grep -l 'categories: \["AI工具实测"\]' content/posts/*.md
```

## 提交与 PR 规范

- 分支：`claude/<简短任务名>`，每个任务一个分支，不直接推 main。
- 提交信息：中文，第一行概括改动（例：「快讯：DeepSeek V5 发布，并更新 DeepSeek 档案页」）。
- PR 描述：改了什么、为什么、检查结果（自检、构建、死链）。
- 合并方式：squash。合并后 Cloudflare Pages 自动部署，`tg-push.yml` 自动推送新文章到 Telegram，`indexnow.yml` 通知搜索引擎。
- 不提交 `public/`、`resources/` 等构建产物。

## 必须交给站长的事

| 事项 | 原因 | AI 怎么做 |
| --- | --- | --- |
| 截图、真机操作、付款 | AI 无法真实操作 | 在 content-plan.md「待补截图」登记文章和步骤 |
| 「我用了 X 个月」类经验 | 不能编造 | 改成客观描述，或请站长补充 |
| 删除文章、改分类体系、改定位 | 不可逆或改变方向 | 写方案，等站长确认 |
| 联盟申请、商务合作、收款 | 涉及账户和合同 | 列出建议 |
| Search Console 数据 | AI 无权限 | 请站长导出 |
| 敏感选题（政策、争议事件） | 风险判断 | 先问 |

## 质量自查清单（提交前逐条过）

- [ ] 开头 100 字有结论
- [ ] 分类六选一，标签 3–5 个且都在词表里
- [ ] description 70–120 字
- [ ] 字数达到该类型标准
- [ ] 每 400–600 字一个小标题
- [ ] 站内链接 ≥ 3，已挂到中心页 / 档案页，旧文已回链
- [ ] 数据都有来源，厂商数据标「官方说法」
- [ ] 没有编造的经历和链接
- [ ] 联盟链接已披露
- [ ] `lint_posts.py` 0 ERROR，构建通过，0 死链
