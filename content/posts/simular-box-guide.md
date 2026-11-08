---
title: "Simular Box教程：给AI配一台免费云电脑"
date: 2026-11-08T11:35:00+08:00
lastmod: 2026-11-08T11:35:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["教程", "AI Agent", "自动化", "Claude", "ChatGPT"]
description: "Simular 的 box 给 Claude、ChatGPT、Claude Code 接一台免费云端 Linux 电脑，AI 能自己开浏览器、点鼠标、跑命令。含四种接入方法、每日额度规则、常见报错与安全提醒，依据官网文档整理。"
showtoc: true
---

结论先说：**你的 AI 现在缺的不是脑子，是手。**平时让 Claude、ChatGPT 干活，它们只能在聊天框里说话，真要打开网页、点按钮、下载文件、跑一段命令，还得你自己动手。Simular 新推出的 **box** 就是来补这只手的：一台放在云端的 Linux 电脑，通过 MCP 接到你的 AI 工具里，AI 就能在那台电脑上自己开浏览器、点鼠标、敲命令，你的电脑全程不用被占用。目前 box 处于 Beta 阶段，**电脑本体免费、免绑卡注册**，团队成员公开说过免费账号也能用。本文依据 Simular 官网文档整理（查阅时间：2026 年 11 月 8 日），接入步骤逐步写清，额度、限制和坑也一并说透。

![插画：一台漂浮在云端的电脑桌面，机器人手臂正在操作浏览器窗口](/images/simular-box-guide/cover.webp)

## box 是什么：一台专供 AI 使用的云电脑

把 box 理解成「租给 AI 的电脑」就行，只不过现在租金是 0：

- **一台完整的云端 Linux 桌面**（Ubuntu 系统），自带 Chrome 浏览器和命令行终端，每个账号一台。
- **通过 MCP 连接**：MCP 可以粗略理解为 AI 工具的「外设接口」，box 就是插上去的一台远程电脑。支持 Claude（网页版和桌面版）、ChatGPT、Gemini、Claude Code、Codex、Cursor、VS Code 等主流工具。
- **闲置自动休眠，唤醒约 1 秒**：没人用的时候它就睡着，不占资源；AI 一连接就醒，里面的文件和状态都保留，不是每次从零开始。
- **能看直播、能接管**：AI 操作时，你可以打开 [box 实时画面](https://box.simular.ai/box) 看它在干什么，需要时点接管（Take control）自己上手，手机 App 里也能看。
- **电脑免费，脑子按量**：box 本体不收费，但 AI 在里面思考和操作要消耗你账号的**每日 credits**，每天刷新（UTC 午夜重置）。官方没有公布免费档的具体数字，以你账号里实际显示为准；用完了要么等第二天，要么去账单页加购。

它和本站之前讲的 [AI Agent 完全指南](/posts/ai-agent-complete-guide-2026/) 是同一个思路：让 AI 从「会说」变成「会做」。区别是以前要自己搭环境、配服务器，现在人家把电脑摆好了，你只负责接线。想再看看这类工具的全景，可以回 [AI工具实测](/categories/ai工具实测/) 中心页慢慢挑。

## 开始之前：前置条件

- **一个能正常使用的 AI 工具账号**：Claude、ChatGPT、Gemini 任选其一，或者电脑上装了 Claude Code、Codex、Cursor 这类编程工具。免费账号可以，box 这边不挑。
- **注册 box 不用绑卡**：第一次连接时用 Simular 账号登录授权（OAuth），支持 Google、GitHub 等方式登录，全程不用填支付信息。
- **编程路线多一个要求**：走一键命令安装的话，电脑上要有 Node.js 18.17 或更高版本。
- **一句实话**：Claude、ChatGPT 这些工具本身在国内的使用门槛并没有变，box 解决的是「AI 没有电脑用」，不解决网络问题。已经能用上这些工具的人，这篇就是给你加装备的。

## 方法一：Claude 接入（最简单，手机就能办）

Claude 是所有工具里接 box 最省事的，手机和电脑都可以：

1. 在 Claude 里打开官方的一键添加入口（官网文档给的 [Add to Claude](https://claude.ai/customize/connectors?modal=add-custom-connector&connectorName=box&connectorUrl=https%3A%2F%2Fmcp.box.simular.ai%2Fmcp) 链接），页面会自动把 box 的名称和地址填好。
2. 点 **Continue（继续）**，跳转到 box 的登录页，登录你的 Simular 账号。
3. 在授权页确认允许这个应用使用你的 box，并选择授权时长，点批准。
4. 回到 Claude，新开一个对话，在对话的工具菜单里把 **box 打开**，然后直接派活。

手动添加的路径也一样简单：Claude 设置 → Connectors（连接器）→ Add custom connector，名称填 `box`，地址填 `https://mcp.box.simular.ai/mcp`，高级设置留空，点 Connect 后登录授权即可。

**一个必须知道的限制**：Claude 免费版只允许添加 **1 个**自定义连接器。如果你已经接了别的 MCP 工具，加 box 就得先想好取舍；付费版没有这个限制。

## 方法二：ChatGPT 接入（要在电脑网页版操作一次）

ChatGPT 把 box 当作一个自定义 MCP 插件来添加，添加动作只能在电脑上完成，手机 App 只能用、不能加：

1. 在电脑浏览器打开 chatgpt.com，点侧边栏的 **Plugins（插件）**，或直接进 chatgpt.com/plugins。
2. 点 **Add**，选择 **Add custom MCP server（添加自定义 MCP 服务器）**。
3. 名称填 `box`；Connection（连接）里的 Server URL 填 `https://mcp.box.simular.ai/mcp`；身份验证方式选 **OAuth**。
4. 勾选「I understand and want to continue」，点 **Create as a plugin** 创建，再点安装（Install）。
5. 安装过程中会弹出 box 的登录授权页，登录 Simular 账号并批准。
6. 回到对话，输入 `@` 选 **box**，就可以派活了。添加一次之后，手机上的 ChatGPT App 里也能直接用。

注意：官方文档明确说，**部分 ChatGPT 套餐或团队工作区可能还没开放自定义 MCP 服务器**，找不到「Add custom MCP server」入口就是这种情况，不是你的操作问题——可以先用方法一的 Claude 路线。

## 方法三：编程工具一键接入（Claude Code / Codex / Cursor）

如果你用的是编程类工具，最快的是官方的一键安装命令。在终端里运行：

```bash
npx @simular-ai/box connect
```

它会自动找出你电脑上装了哪些受支持的工具（Claude Code、Codex、Cursor、OpenCode、Hermes、OpenClaw、VS Code），问你给哪几个接上 box，然后按每个工具自己的格式写好配置——**其他已有设置不会动**，改动过的文件旁边还会留备份。之后每个工具第一次连接时，会弹浏览器让你登录 box 授权，不用粘贴任何密钥。配套的两个命令也记一下：

```bash
npx @simular-ai/box doctor   # 检查每个工具的接入状态，有问题会给出修法
npx @simular-ai/box remove   # 一键撤销接入，恢复原样
```

只用 Claude Code 的话也可以手动加，两步：

```bash
claude mcp add --transport http box https://mcp.box.simular.ai/mcp
```

然后在 Claude Code 里输入 `/mcp`，选中 box，点 **Authenticate**，在浏览器里登录并批准。

懒得敲命令还有一招：直接把这句话发给你的编程 Agent，它会自己照着官方安装页把 box 装好：

```text
Set up box from https://box.simular.ai/install
```

## 方法四：Gemini 接入（限制最多，先看清再动手）

Gemini 网页版也能加：打开 gemini.google.com → 设置 → Connected Apps，在 Custom apps 里点 Add a custom app，粘贴同一个服务器地址 `https://mcp.box.simular.ai/mcp`，然后登录授权。但官方文档把门槛写得很清楚：**只支持个人 Google 账号（公司、学校账号不行）、18 岁以上、美国地区、英文界面、且要开着 Keep Activity**。国内用户基本不符合，这个路线了解即可；真想在 Gemini 体系里用，走 Gemini CLI：

```bash
gemini mcp add --scope user --transport http box https://mcp.box.simular.ai/mcp
```

启动 gemini 后运行 `/mcp auth box` 完成登录授权。

## 接好之后，让它干点什么

第一次派活，建议从官方给的三个示例任务开始，都是安全、可验证的小事：

- 「Use box to open Chrome, search Google for "Simular", and summarize the top 3 results.」（用 box 打开 Chrome，搜索 Simular，总结前 3 条结果）
- 「用 box 打开 GitHub Trending，告诉我今天前 3 个仓库是做什么的」
- 「用 box 打开 news.ycombinator.com，把今天前 5 条新闻整理成表格」

派活时记得在开头点名 box（ChatGPT 和 Codex 里用 `@box` 唤起），免得 AI 用错工具——Codex 里尤其要注意， plain 一句「use box」可能被匹配到同名的网盘应用 Box。任务跑起来后，打开 [box 实时画面](https://box.simular.ai/box) 就能围观全过程，它点错了你可以随时接管纠正。这种「给任务、看执行、随时纠偏」的用法，就是 [从零手写一个会干活的 AI Agent](/posts/build-your-own-ai-agent-tutorial/) 里讲的 Agent 循环，只不过这次不用你写一行代码。

## 常见报错与解决

- **11 月 4 日之前加过 box，现在登录失败**：box 在 11 月 4 日换过服务器地址，旧地址 `relay.simular.cloud/mcp` 还能连上但登录会出问题。终端跑 `npx @simular-ai/box@latest connect` 自动换新；手动添加的，把 box 删掉、用新地址 `https://mcp.box.simular.ai/mcp` 重新加一遍。
- **登录成功但对话里没有 box 的工具**：开一个**新对话**就有了，老对话不会刷新工具列表。Claude Code 里用 `claude mcp list`、Gemini CLI 里用 `gemini mcp list` 可以查连接状态。
- **AI 说 credits 用完了**：当天的免费额度耗尽。要么等 UTC 午夜重置（北京时间早上 8 点），要么去 [账单页](https://box.simular.ai/billing) 加购或换套餐。重活、大批量任务先想好再派，别让它半夜自己烧额度。
- **用着用着被登出了**：授权时选的时长到期了，按第一次的方法重新登录批准即可。所有已连接的应用和密钥都能在 [Keys 管理页](https://box.simular.ai/keys) 看到，不用的随时撤销。
- **浏览器授权页写着「Can't connect this agent」**：重新登录一次；还不行就把 box 从工具里移除、重新添加。
- **实在搞不定**：先跑 `npx @simular-ai/box doctor` 自检，它会逐项指出问题和修法；再不行写邮件给官方支持 support@simular.ai，注明你用的是哪个工具、卡在哪一步。

## 安全提醒：这台电脑再方便，也不是你的

box 好用，但有三条线要守住：

- **别往云电脑里放敏感东西**：它毕竟是第三方服务器，不要在里面登录网银、支付、主邮箱这类重要账号，也不要把身份证件、私人文档传进去。让它干公开信息的活——搜索、整理、跑脚本、测网页，这才是它的正确岗位。
- **个人密钥（personal key）当密码看**：有些不能走 OAuth 的工具要用密钥接入，在 [Keys 页](https://box.simular.ai/keys) 生成，**只显示一次**，别发到聊天记录和共享文件里，怀疑泄露立刻撤销重建。
- **Beta 免费期不是永久承诺**：现在免费是产品推广期的政策，团队也说了是想多收反馈。额度规则、免费政策随时可能调整，重要工作不要只押在这一台免费电脑上；真跑出依赖了，再对照付费档考虑也不迟。更多免费工具的长期可用情况，可以看本站的 [真正好用的免费 AI 工具](/posts/free-ai-tools-2026/) 合集交叉比对。

## 常见问题

**Q：完全免费吗，要不要绑卡？**
A：box 本体免费，注册和接入都不用绑卡。消耗的是账号的每日 credits，当天用完等次日刷新即可；只有你主动加购或升级套餐时才涉及付款。

**Q：免费的 Claude / ChatGPT 账号能用吗？**
A：能。box 是接在你现有 AI 工具外面的电脑，不看你的 AI 订阅档位。唯一的例外是 Claude 免费版只允许 1 个自定义连接器，名额被占就先腾位置。

**Q：它关机或休眠后，我放的文件还在吗？**
A：还在。休眠只是省电，文件和状态会保留，下次连接约 1 秒唤醒接着用。但重要文件还是建议自己另存一份，别把云端当唯一副本。

**Q：国内网络能用吗？**
A：box 的服务器在海外，它要配合的 Claude、ChatGPT 等工具本身也需要相应的网络条件，你原来怎么用这些工具，现在还怎么用。box 的文档站 box.simular.ai 是公开页面，可以先打开看看和测速。

**Q：不想用了怎么彻底断开？**
A：编程工具跑 `npx @simular-ai/box remove`；聊天类工具在各自的连接器/插件设置里删除 box；最后去 [Keys 页](https://box.simular.ai/keys) 把已连接应用和密钥全部撤销，三步做完就干净了。

## 参考来源

- [box by Simular 官网](https://box.simular.ai/)：产品定位、免费政策与各工具接入总览（查阅于 2026-11-08）
- [box 官方文档：MCP server](https://box.simular.ai/docs/mcp)：各应用的完整接入步骤、服务器地址与一键命令（查阅于 2026-11-08）
- [box 官方文档：Troubleshooting](https://box.simular.ai/docs/troubleshooting)：常见报错、旧地址迁移与 credits 说明（查阅于 2026-11-08）

## 更新记录

- 2026-11-08：首发。依据 Simular 官网与官方文档整理四种接入方法、额度规则与报错处理；box 处于 Beta 免费期，后续政策如有变化会更新本文。
