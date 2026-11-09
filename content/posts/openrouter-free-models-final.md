---
title: "OpenRouter免费模型真能随便用吗？"
date: 2026-11-09T12:30:00+08:00
lastmod: 2026-11-09T12:30:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["科普", "API", "订阅省钱", "AI安全"]
description: "X 上有人喊 OpenRouter 免费模型是「Token 永动机」，配 pi agent 零成本跑 Agent。拆解：原理成立，但「用不完」是夸大——免费每天只有 50 次，Agent 一轮烧完；贴 key、装陌生 skill 有安全风险。"
showtoc: true
---

![插画：一个发光的路由中枢向四周分出许多彩色线路，连向漂浮的小方块，其中几条线路泛着绿光](/images/openrouter-free-models/cover.webp)

**结论先说：** OpenRouter 的 `:free` 模型确实能零成本调用，但每天只有 **50 次**请求（核对日期：2026-11-09，见下文出处），一个 Agent 一轮自主任务就要几十上百次调用，50 次几分钟就烧完。「Token 永动机，用不完」这个说法，原理上成立、效果上是夸大。更值得注意的是那篇帖子的方法里，让人把自己的 API key 贴进聊天、再让 AI 自动装一个陌生仓库的 skill——key 和执行代码的权限一起交出去，风险比额度问题更大。

## 「Token 永动机」说的方法到底是什么？

2026 年 11 月 8 日，X 账号 @luooutlook 发帖称「Token 永动机，用不完」，方法只有四步：注册 OpenRouter 拿 key → 在 Muse 里让 AI 安装 GitHub 仓库 limin112/min-skill 里的 FreeToken-Bots skill → 再装 pi agent → 让 AI 把 pi agent 配成用 OpenRouter 免费模型。帖子原文见 [该帖](https://x.com/luooutlook/status/2119402160299315621)。

这套方法的技术链路本身没有编造：把 Agent 的后端指向 OpenRouter 的 `:free` 模型，确实能零成本跑起来。下面拆的是它没说的三件事：额度、模型质量、以及 key 和 skill 的安全问题。

## 免费额度到底有多少？

OpenRouter 免费模型的限额，官方定价页与 FAQ 的口径是：**每分钟 20 次、每天 50 次**；账户累计购买满 10 美元额度后，每天升到 1000 次（来源：[OpenRouter 定价页](https://openrouter.ai/pricing)，由第三方整理站 UplinkSwitch 于 2026-10-22 抄录；另见 [OpenRouter 免费 LLM API 对比](https://openrouter.ai/blog/tutorials/free-llm-apis-compared/)）。也就是说，不花钱的默认档就是每天 50 次——这不是哪个模型的小气，是整个免费池的统一上限。

做个推算（本站推算，非官方数字）：一轮 Agent 自主任务通常要几十上百次模型调用，50 次额度只够跑不到一轮完整任务；即使充过 10 美元升到每天 1000 次，按一轮任务 50–100 次算，也只够跑 10–20 轮，离「用不完」还差得远。想拿免费额度当 Agent 主力，账是算不过来的。

## 免费池里现在有哪些模型能用？

免费名单换得很快，几周一换，老教程里的明星款大多已经下架。第三方追踪站 ayautomate 在 **2026-11-03** 拉取 OpenRouter 模型 API 并逐个实测的结果（[原文](https://www.ayautomate.com/blog/openrouter-free-models)，测试条件：每个免费模型发 3 次小请求，2026-11-03 当天）：当时在架的 `:free` 模型共 14 个，其中只有 6 个三次全部答复；3 个全程返回 429（忙不过来），其余有的报供应商错误、有的只限指定 Agent 应用内使用。

三次全部答复的 6 个（模型 ID 可直接复制使用，核对日期 2026-11-09，名单以 OpenRouter 模型列表为准、随时会变）：

| 模型 ID | 用途倾向 | 上下文 |
| --- | --- | --- |
| `nvidia/nemotron-3-ultra-550b-a55b:free` | 通用主力，免费里个头最大 | 1M |
| `nvidia/nemotron-3.5-super-vl:free` | 能看图、看视频 | 1M |
| `nvidia/nemotron-3.5-lightning:free` | 出活快 | 1M |
| `nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free` | 文、图、音、视频输入 | 256K |
| `cohere/north-mini-code:free` | 写代码、Agent 编程 | 256K |
| `dots-studio/dots-3-note-preview:free` | 笔记整理（该模型标注有效期至 2026-12-31） | 512K |

另外两个提醒，同样来自上述 2026-11-03 的实测：

- **老教程里的免费款大多已 404**：`deepseek-r1:free`、`qwen3-coder:free`、`llama-3.3-70b:free`、`gpt-oss-120b:free` 现在调用直接返回 404，别照老文章找。
- **Thinking Machines 的 Inkling 已过期**：该模型在目录里标注的有效期是 2026-11-04，且只限指定 Agent 应用内使用（403），11 月 9 日再去调用大概率已不可用。

还有一个定位问题：免费池里全是开源权重和厂商推广期的新模型，**没有 Claude、GPT、Gemini 本尊的免费版**。普通聊天、轻量试用凑合；让 Agent 写代码、跑长任务，模型能力不够，翻车和返工的概率都高——而 Agent 恰恰是最不能省模型钱的场景（本站判断）。

懒人选项：把模型名填 `openrouter/free`，它每次请求自动帮你挑一个免费模型；但挑到哪个、稳不稳，同样受上面这些限制。

## 为什么 Agent 最吃不消免费额度？

原因不在单个模型贵不贵，而在 Agent 的工作方式：它不是一问一答，而是一轮任务里反复调用模型——拆步骤、调工具、读结果、纠错、再调工具。每一步都是一次请求。50 次的日限额，摊到这种用法上，几分钟就烧完；1000 次的档也一样，只是从「几分钟」变成「撑不过一天的重度使用」。

所以这套路的正确定位是：**轻度试用和跑批量小任务很香，当生产力「永动机」不行**。想拿它当主力干活，额度、模型能力和稳定性三关都过不去。

## 那个帖子最大的风险不是额度，是 key 和 skill

额度问题最多是让人白忙一场，下面这两步的风险是实打实的：

1. **把自己的 OpenRouter key 直接贴进聊天**：key 一旦进了对话记录，就不再只属于你。正确做法是只在客户端或官网后台的设置页里填 key，不发给任何 AI 对话、不贴进任何群聊和评论区。
2. **让 AI 自动安装陌生仓库的 skill**：skill 是能执行代码的东西，装进自己的 Agent 环境，等于把钥匙和屋子一起交出去。这个结构和此前本站拆过的假 Muse 教程骗 token 套路相同（本站判断：结构相同不等于同一伙人，只说风险结构一致）。

真想玩免费模型，正确姿势不需要任何第三方 skill：自己去 OpenRouter 官网拿 key，直接在客户端里填 `openrouter/free` 或某个 `:free` 模型就行。

## 手里有 Claude 官方 key，怎么用最划算？

如果你已经持有 Claude 官方 API key，OpenRouter 还有一种用法叫 **BYOK（自带 key）**：把官方 key 填进 OpenRouter 的 BYOK 设置，之后调用 Claude 还是走你的 key、按 Anthropic 官方价从你自己账户扣费，不经过 OpenRouter 的充值余额，也就没有那 5.5% 的充值手续费。OpenRouter 对 BYOK 的收费线是每月 25,000 美元（按标价算的用量）以内免费，超出才收 5%——个人使用基本碰不到这条线（来源：OpenRouter 定价页与 FAQ，核对日期 2026-11-09；key 只应填在 OpenRouter 官网 BYOK 后台）。

但有一点要说清：**如果你只用 Claude、别的模型不用，直连官方 API 才是最方便的**——少一跳网络延迟、少一个中间方经手你的请求内容，Anthropic 的新功能也总是官方先有。OpenRouter 的价值只在「多模型混用」时才成立：一个接口同时用 Claude 和其他家的模型，很多只认 OpenAI 格式的工具也能直接调你的 Claude。

## 结论：免费模型适合谁？

- 适合：轻度试用、对比不同模型的效果、跑批量小任务、以及在充值前先验证流程。
- 不适合：当 Agent 主力、当生产力「永动机」、以及照着「贴 key + 装陌生 skill」的教程一步不差地操作。

想系统了解各家免费 API 的额度对比，看这篇 [免费 AI API 指南](/posts/free-ai-api-guide/)；想了解 Agent 本身怎么搭，看 [AI Agent 完全指南](/posts/build-your-own-ai-agent-tutorial/)（站内同名文章，链接以线上为准）；同属「AI工具实测」分类的更多实测见 [AI工具实测中心页](/categories/ai工具实测/)。

## FAQ

**OpenRouter 免费模型真的免费吗？**
按 token 计费是免费的（`:free` 模型输入输出均为 0 美元），但请求次数受限：默认每天 50 次，每分钟 20 次；累计购买满 10 美元后每天 1000 次。免费不等于无限。

**`openrouter/free` 和某个 `:free` 模型有什么区别？**
填某个 `:free` 模型是指定用它；填 `openrouter/free` 是让 OpenRouter 每次请求自动挑一个免费模型。两者都受同样的日限额和单供应商限制。

**免费模型能用来跑 Agent 吗？**
技术上能跑，但不推荐当主力：额度几分钟就烧完、没有 Claude/GPT 本尊、单个模型只有一个供应商、忙时常返回 429。轻量试玩可以，生产任务建议用付费模型。

**BYOK 会不会让我的 Claude key 被 OpenRouter 扣费？**
不会。BYOK 模式下调用 Claude 走你自己的 key、按 Anthropic 官方价从你自己账户扣费，不经过 OpenRouter 的充值余额；每月 25,000 美元标价用量以内，OpenRouter 不另收费。

**看到「Token 永动机」「无限白嫖」这类标题该怎么判断？**
先看它有没有写清三个数：每天几次、每次调用多少钱、模型是哪几个。如果只喊口号、不给限额和模型名单，按本站的经验口径，大概率是标题先行、细节后补——先看额度再决定要不要试。

## 信息核验与更新记录

- 核对日期：2026-11-09
- 官方来源：[OpenRouter 定价页](https://openrouter.ai/pricing)（5.5% 充值手续费、免费模型限额、BYOK 收费线）；[OpenRouter 免费 LLM API 对比](https://openrouter.ai/blog/tutorials/free-llm-apis-compared/)；OpenRouter 模型列表 API（`https://openrouter.ai/api/v1/models`，免费名单以此为准）
- 第三方实测来源：[ayautomate：OpenRouter 免费模型实测（2026-11-03）](https://www.ayautomate.com/blog/openrouter-free-models)（14 个在架、6 个三次全答复、3 个全程 429、Inkling 有效期至 2026-11-04）；[apiany：OpenRouter 免费模型目录（2026-11-03 核对）](https://www.apiany.ai/openrouter-free-models)
- 经验与估算：文中关于「Agent 一轮任务几十上百次调用」「免费模型翻车率和返工率更高」「标题先行、细节后补」的内容为本站判断与经验口径，无官方统计；其余额度、价格、模型名单均为官方或第三方实测口径。
- 利益披露：本站与 OpenRouter、pi agent、Muse 及文中提到的 GitHub 仓库均无合作、返佣或利益关系；本文不含商城推荐，结论独立作出。
- 更新记录：
  - 2026-11-09：首发。起因是 X 上 @luooutlook 2026-11-08 的「Token 永动机」帖子；免费名单与额度按 2026-11-03 第三方实测与 2026-11-09 官方页面口径核对。
