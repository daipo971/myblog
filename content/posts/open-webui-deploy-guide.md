---
title: "Open WebUI部署教程：接DeepSeek告别订阅费"
date: 2026-11-04T22:15:00+08:00
lastmod: 2026-11-04T22:15:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["教程", "本地部署", "API", "DeepSeek"]
description: "GitHub 15.7万星的Open WebUI可以装在自己电脑上当聊天界面。本文按官方文档一步步走：一条Docker命令启动、注册管理员、接上DeepSeek API按量付费，记录全存本地，不用订阅、不用翻墙。"
showtoc: true
---

**结论先说：** Open WebUI 是一个装在自己电脑上的 AI 聊天界面，GitHub 上已有 15.7 万星（2026 年 11 月 4 日经 GitHub API 核实）。用一条 Docker 命令就能装好，再填一个 DeepSeek 的 API Key，就能像用 ChatGPT 一样聊天：不用交月度订阅费，API 按量计费、几块钱能用很久，聊天记录全部存在本地硬盘，整个过程不需要任何海外服务。本文依据 Open WebUI 官方文档与 GitHub 仓库整理（查阅时间：2026 年 11 月 4 日），命令均引自官方快速开始页。

![封面示意：家里的电脑上开着干净的聊天界面，旁边连着本地服务器盒子，再通过虚线连到云端 API](/images/open-webui-deploy-guide/cover.webp)

## Open WebUI 是什么，适合谁

先分清三个概念：Open WebUI 本身**不是模型**，它只是一个「界面 + 管家」。模型在后台，可以是你电脑上用 Ollama 跑的本地模型，也可以是云端的 API。它负责的部分是：好看的聊天窗口、对话记录保存、多账号管理、文档问答、联网搜索等功能。

它在 [GitHub 仓库](https://github.com/open-webui/open-webui) 自我介绍为「可扩展、功能丰富、用户友好的自托管 AI 平台，可完全离线运行」，支持中文界面。适合这几类人：

- 不想每月为聊天机器人交订阅费，但愿意为 API 按量付几块钱的人；
- 在意隐私，希望聊天记录只存在自己电脑上的人；
- 想在一个界面里切换多个模型（DeepSeek、通义、智谱、本地模型）的人；
- 家里有台式机或小主机，想让手机、平板在局域网里共用同一个 AI 界面的人。

和直接打开 ChatGPT 网页版的取舍也很简单：网页版省事但要订阅、要稳定的网络、记录在别人服务器上；Open WebUI 前期要花二十分钟装一次，之后界面和数据都归你，后台接什么模型你说了算。本文选的后台是 DeepSeek API，理由是国内直连、注册简单、价格低；它家的版本和价格细节可以看站内的 [DeepSeek 模型档案](/posts/deepseek-complete-guide-2026/)。

## 准备工作：Docker 和 DeepSeek API Key

动手前要准备两样东西：一台能装 Docker 的电脑（Windows 或 Mac 都行，内存 4GB 以上即可，界面本身很轻），和一个 DeepSeek API Key。

### 第一步准备：安装 Docker Desktop

Docker 可以理解为「应用打包箱」：Open WebUI 官方推荐用 Docker 安装，一条命令拉起，不用自己配 Python 环境。

1. 打开 Docker 官网（docker.com），下载对应系统的 Docker Desktop 并安装。
2. Windows 用户注意：安装程序通常会引导开启 WSL 2 组件，按提示重启一次电脑即可；Mac 用户按芯片选对版本（Apple 芯片选 Apple Silicon 版，Intel 芯片选 Intel 版）。
3. 装好后打开 Docker Desktop，等右下角（Windows）或顶部菜单栏（Mac）的小鲸鱼图标不再闪烁，就是启动完成了。
4. 验证一下：打开终端（Windows 用 PowerShell，Mac 用「终端」应用），输入 `docker --version`，能显示版本号说明安装成功。

国内从官网下载 Docker Desktop 可能比较慢，这一步请预留耐心；只要最终能装上，后面的镜像拉取慢也有解法，见文末常见问题。

### 第二步准备：申请 DeepSeek API Key

1. 打开 DeepSeek 开放平台（platform.deepseek.com），用手机号注册并登录。
2. 先充值一笔小额：API 是按量计费，官方价格页显示当前 Flash 模型闲时每百万输入 tokens 低至 0.15 美元（美元计价，高峰时段价格翻倍，[官方价格页](https://api-docs.deepseek.com/quick_start/pricing) 为准），日常聊天用量很小，充几块钱人民币就能用很久，不必多充。
3. 在左侧菜单进入「API Keys」页面，点「创建 API Key」，给它起个名字（比如 open-webui），生成后立刻把这串以 `sk-` 开头的密钥复制保存好——页面只完整显示一次，丢了只能删掉重建。
4. 这个 Key 相当于你账户的钥匙，谁拿到都能花你的余额，不要发到群里、不要截图外传。

## 第一步：一条命令启动 Open WebUI

打开终端，把官方快速开始页的这条命令完整粘贴进去回车：

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

第一次运行会先下载镜像（体积不小，视网速等几分钟），下载完容器自动启动。逐个参数解释一下，方便出问题时排查：

- `-d`：在后台运行，关掉终端窗口也不会停。
- `-p 3000:8080`：把容器内部的 8080 端口映射到你电脑的 3000 端口，所以等下在浏览器开的是 3000。3000 被占用就改成别的，比如 `-p 3001:8080`。
- `--add-host=host.docker.internal:host-gateway`：让容器能通过 `host.docker.internal` 这个地址访问宿主机，为以后接 Ollama 本地模型留好通道。
- `-v open-webui:/app/backend/data`：**最重要的一条**。它把数据存进名为 `open-webui` 的 Docker 卷，官方文档特别提醒必须带上这一段，否则容器重建后账号和聊天记录全丢。
- `--name open-webui`：给容器起名，方便以后用命令管理。
- `--restart always`：电脑重启后容器自动跟着启动，不用每次手动开。
- `ghcr.io/open-webui/open-webui:main`：镜像地址和版本，`main` 是官方主版本。

命令执行后，在终端输入 `docker ps`，能看到名为 `open-webui` 的容器在运行，就说明启动成功。不想用 Docker 的话，官方也支持 `pip install open-webui` 后运行 `open-webui serve`（端口是 8080），但官方推荐 Docker 路线，本文也按 Docker 写。

## 第二步：注册第一个账号，它就是管理员

1. 打开浏览器，访问 `http://localhost:3000`（如果你把端口改成了 3001，就访问 3001）。
2. 第一次打开会看到登录页，点「注册」（Sign up），填名字、邮箱和密码，提交。
3. **第一个注册的账号自动成为管理员**，拥有全部管理权限，所以请用你自己的常用邮箱注册，并把密码记牢。之后再注册的账号默认需要管理员在后台批准才能登录，相当于天然的门禁。
4. 登录进去之后，右上角头像菜单里可以进「设置」，把界面语言切换为中文，接下来的菜单名对照着找更方便。

到这一步，一个空壳界面已经跑起来了。但它背后还没接任何模型，模型列表是空的，发不出消息——下一步就是接 DeepSeek。

## 第三步：接上 DeepSeek，发出第一条消息

Open WebUI 支持所有「OpenAI 兼容接口」，DeepSeek 正在此列，官方连接文档明确标注 DeepSeek 的模型列表可以自动识别，不用手动填模型名。路径如下：

1. 点右上角头像 →「设置」，进入「管理员设置」（Admin Settings）。
2. 找到「连接」（Connections）一页，在「管理 OpenAI API 连接」（Manage OpenAI API Connections）区域点「添加连接」（Add Connection，带 ➕ 图标）。
3. 在 URL 一栏填 DeepSeek 的接口地址：`https://api.deepseek.com/v1`；在 API Key 一栏粘贴准备工作中保存的 `sk-` 密钥。
4. 点旁边的「验证连接」（Verify Connection），提示连接成功后点「保存」（Save）。DeepSeek 的 `/models` 接口是通的，保存后模型列表会自动拉取。
5. 回到聊天主界面，点左上角的模型选择框，应该能看到 DeepSeek 的模型：日常聊天选 `deepseek-flash`（速度快、价格最低），遇到需要深度推理的难题再选 `deepseek-v4-pro`。模型名以你界面里实际显示的为准，官方改名时列表会自动跟着变。
6. 随便发一句「你好，用一句话介绍你自己」，能正常回复，就全部打通了。

之后想再接通义千问、智谱 GLM 等其他国产 API，方法完全一样：在同一页继续「添加连接」，填各自的接口地址和 Key，所有模型会汇总到同一个下拉框里随选随换。更多探活这个界面的玩法，可以回 [AI工具实测中心页](/categories/ai工具实测/) 翻同类教程。

## 进阶：本地模型、手机访问与安全提醒

**接 Ollama 本地模型。** 如果你的电脑配置不错（16GB 内存起步），可以再装一个 Ollama 在本地跑开源模型，断网也能聊，数据完全不出电脑。装好 Ollama 并拉取一个模型后，在 Open WebUI 的「连接」页确认 Ollama API 地址为 `http://host.docker.internal:11434` 即可（启动命令里预留的 host-gateway 就是为它准备的）。本地选模型、按内存挑尺寸的细节，站内已有专门一篇：[本地运行大模型教程：Ollama 和 LM Studio 离线用 AI](/posts/ai-local-llm-guide-2026/)，照着做即可。

**局域网和手机访问。** Open WebUI 跑在电脑上后，同一 Wi-Fi 下的手机、平板用浏览器打开 `http://电脑的局域网IP:3000` 也能用（局域网 IP 在路由器后台或电脑的网络设置里查）。第一次访问同样走注册流程，新账号要等管理员批准。

**安全提醒（重要）。** 只在自己家里局域网用是安全的，但**不要把这个 3000 端口直接暴露到公网**：不要在路由器上给它做端口转发，不要把带公网 IP 的地址发给别人。确实需要从外面访问时，用 Tailscale 这类组网工具或带密码保护的反向代理，并给每个账号设置强密码。想把折腾再往前推一步、让界面里的模型自己动手干活的，可以看 [从零手写一个会干活的 AI Agent](/posts/build-your-own-ai-agent-tutorial/)。

## 费用和许可证小结

- **软件费用**：Open WebUI 本体免费，跑在自己电脑上，不消耗订阅。
- **模型费用**：接 DeepSeek API 按量从余额扣费，价格见上文引用的官方价格页；接本地 Ollama 模型则零费用，只有电费。
- **许可证要说清**：Open WebUI 用的是一份名为「Open WebUI License」的**自定义许可证**（含品牌相关条款），并不是 MIT、Apache 那种标准 OSI 开源许可证。个人自己部署使用完全没问题；但如果将来想拿它改名、打包成产品给别人用，先去仓库读一遍许可证原文再决定。

## 常见问题

**1. 打开 localhost:3000 显示打不开或连接被拒绝？**
先确认 Docker Desktop 正在运行，再在终端执行 `docker ps` 看 `open-webui` 容器在不在。容器不在就执行 `docker start open-webui`；刚启动时服务需要十几秒到几十秒初始化，稍等再刷新。还是不行就用 `docker logs open-webui` 看最后几行报错，对照[官方故障排查页](https://docs.openwebui.com/troubleshooting/) 定位。

**2. 提示 3000 端口被占用怎么办？**
说明电脑上已有程序占了 3000。先停掉旧容器（`docker rm -f open-webui`），把启动命令里的 `-p 3000:8080` 改成 `-p 3001:8080` 重新运行，之后访问 `http://localhost:3001` 即可，其余参数不要动，尤其别删 `-v` 那段。

**3. 镜像下载特别慢或中途失败怎么办？**
镜像托管在 GitHub 的容器仓库（ghcr.io），国内拉取可能较慢，给三条正规解法：① 耐心重试，`docker pull ghcr.io/open-webui/open-webui:main` 支持断点续传，多试两次常能过；② 在 Docker Desktop 的设置里给 Docker Engine 配置你手头云服务商提供的镜像加速地址（各家云厂商控制台都有免费加速器说明）；③ 先用官方的精简版镜像把流程跑通——把命令结尾的 `:main` 换成 `:slim`，官方称它的下载体积只有约 197MB，功能精简但聊天核心功能都在，之后网络好了再换回主版本。

**4. 管理员密码忘了怎么办？**
Open WebUI 没有邮件找回通道，官方给的办法是直接改数据库：生成一段新密码的 bcrypt 哈希，再写进数据卷里的 `webui.db`。步骤对新手略硬核，照[官方重置管理员密码指南](https://docs.openwebui.com/troubleshooting/password-reset) 一步步抄即可。如果账号里没什么重要记录，还有个偷懒法：删掉容器和数据卷（`docker rm -f open-webui` 后 `docker volume rm open-webui`）再重新运行启动命令，从零注册——但聊天记录会全部清空，慎用。

**5. 聊天记录存在哪，怎么备份？**
所有账号、设置和聊天记录都在名为 `open-webui` 的 Docker 卷里（数据库文件 `webui.db`）。备份一条命令搞定，在终端执行：

```bash
docker run --rm -v open-webui:/data -v $(pwd):/backup alpine tar czf /backup/open-webui-backup.tar.gz -C /data .
```

当前目录下会生成一个压缩包，拷到移动硬盘或网盘存好即可；换电脑时把这个卷恢复回去，记录就都回来了。

## 参考来源

- [Open WebUI GitHub 仓库](https://github.com/open-webui/open-webui)：星标数、许可证、官方快速开始命令。
- [Open WebUI 官方文档](https://docs.openwebui.com/)：Docker 快速开始、镜像版本说明（`:main` 与 `:slim` 的区别）。
- [官方文档：连接 OpenAI 兼容接口](https://docs.openwebui.com/getting-started/quick-start/connect-a-provider/starting-with-openai-compatible/)：设置 → 管理员 → 连接的添加路径、验证连接、DeepSeek 模型自动识别。
- [DeepSeek API 官方价格页](https://api-docs.deepseek.com/quick_start/pricing)：模型名、接口地址与按量价格。
- [官方文档：重置管理员密码](https://docs.openwebui.com/troubleshooting/password-reset)：忘记密码时的处理步骤。

## 更新记录

- 2026-11-04：首发。按当日官方文档整理：Docker 一条命令部署、接 DeepSeek API 的完整路径、许可证性质与费用说明、五条常见问题。
