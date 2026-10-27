# 03 分类、标签与网址体系

机器可读版本在 [`data/taxonomy.yaml`](../../data/taxonomy.yaml)，自检脚本按它检查。本文解释规则。

## 三层结构

```
支柱（分类，6 个）
 └─ 领域 / 系列（由中心页的小节、档案页、标签组织）
     └─ 文章
```

- **分类 = 支柱**：每篇文章 `categories` 恰好一个，从 6 个里选，名称一字不差。归类规则见 [02-topic-map.md](02-topic-map.md#归类判断规则有歧义时按顺序判断)。
- **标签**：帮助读者和搜索引擎在支柱内部横向找内容。受控词表，不随手造。
- **档案页 / 系列**：同一个模型或产品的所有内容都挂在它的档案页下面，档案页本身就是这个系列的入口。

## 六个分类

| 分类名 | 网址 | 中心页文件 |
| --- | --- | --- |
| 中国与开源模型 | /categories/中国与开源模型/ | content/categories/中国与开源模型/_index.md |
| AI工具实测 | /categories/ai工具实测/ | content/categories/ai工具实测/_index.md |
| AI应用场景 | /categories/ai应用场景/ | content/categories/ai应用场景/_index.md |
| AI前沿动态 | /categories/ai前沿动态/ | content/categories/ai前沿动态/_index.md |
| 海外服务通关 | /categories/海外服务通关/ | content/categories/海外服务通关/_index.md |
| 建站与副业 | /categories/建站与副业/ | content/categories/建站与副业/_index.md |

注意：Hugo 会把分类网址里的英文字母转成小写，所以中心页的目录名要用小写（`ai工具实测`），站内链接也写小写。

## 标签规则

每篇 3–5 个标签，按这个配方组合：

| 组 | 数量 | 作用 | 例子 |
| --- | --- | --- | --- |
| 类型标签 | 恰好 1 个 | 这是哪种文章 | 快讯、档案、教程、评测、对比、指南、科普、合集、复盘 |
| 主题标签 | 1–2 个 | 讲的是 AI 的哪个方面 | AI编程、AI视频、注册开通、订阅省钱 |
| 实体标签 | 0–2 个 | 主角是哪个产品 / 模型 / 公司 | Claude Code、DeepSeek、Muse |

例：「Claude Code 与 Codex CLI 对比」→ `["对比", "AI编程", "Claude Code", "Codex"]`。

规则：

- 只用 `data/taxonomy.yaml` 里的写法。英文产品名保留官方大小写，中文不加空格（`AI编程` 不写 `AI 编程`）。
- 不用年份标签（`2026年`）和太泛的标签（`AI`、`AI工具`、`大模型`）。
- 新实体第 2 次出现时才加进词表；第 1 次可以先不打这个实体标签。
- `synonyms` 里左边的旧写法不再使用。存量文章会在标签清理任务里统一替换（见 [10-roadmap.md](10-roadmap.md)）。

## 档案页（系列入口）

| 对象 | 档案页 slug | 状态 |
| --- | --- | --- |
| DeepSeek | deepseek-complete-guide-2026（旧网址保留） | 已有 |
| Kimi | kimi-guide | 已有 |
| MiniMax | minimax-guide | 已有 |
| 阶跃 Step | stepfun-step-guide | 已有 |
| Reflection Beam | reflection-beam-guide | 已有 |
| 通义千问 Qwen | qwen-guide | 待写 |
| 智谱 GLM | glm-guide | 待写 |
| 豆包 / Seed | doubao-guide | 待写 |
| 腾讯混元 | hunyuan-guide | 待写 |
| 可灵 | kling-guide | 待写 |
| 即梦 / Seedance | jimeng-seedance-guide | 待写 |
| Llama | llama-guide | 待写 |
| ChatGPT（产品） | chatgpt-guide | 待写（AI工具实测） |
| Claude（产品） | claude-guide | 已有 |
| Gemini（产品） | gemini-guide | 待写 |
| Claude Code | claude-code-guide | 待写 |
| Cursor | cursor-programming-tools（旧网址保留） | 已有 |
| Muse | 2026-10-21-muse-china-user-guide | 已有（海外服务通关总纲） |

档案页规则：

- slug 用 `<名字>-guide`，不带年份。
- 每条相关快讯在「相关阅读」第一条链接档案页；档案页的「相关快讯」小节反向链接每条快讯。
- 有新闻时更新档案页，改 `lastmod`，在「更新记录」加一行。

## 特殊页面

| 页面 | 网址 | 作用 |
| --- | --- | --- |
| 新手从这里开始 | /start/ | 跨支柱的入门路线：AI 是什么 → 选哪个助手 → 国内怎么用 → 提示词 → 按场景用 → 进阶。待建。 |
| AI 术语表 | /posts/ai-glossary/ | 常见术语一句话解释，每条链接到科普文章。待建。 |
| 中国模型 API 价格表 | /posts/china-llm-api-pricing/ | 每月更新的数据页，中英双语。待建。 |
| 关于 | /about/ | 作者、测试方法、佣金披露 |

## 网址规则

- 文章网址 = 文件名：`content/posts/<英文短横线-slug>.md` → `/posts/<slug>/`。
- slug 全小写英文 + 数字 + 短横线，3–6 个词，用读者会搜的英文关键词。不放年份和日期。
- 已发布文章的网址不改。必须合并、改名或删除时，在 `static/_redirects` 加 301，并处理同名 `.en.md`。
- 英文版放在中文文章旁边：`<同一slug>.en.md` → `/en/posts/<slug>/`。
- 图片放 `static/images/<slug>/`，文件名用英文描述步骤（`step-3-payment.webp`）。
