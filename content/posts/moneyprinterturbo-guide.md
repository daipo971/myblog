---
title: "MoneyPrinterTurbo教程：一键自动生成短视频"
date: 2026-11-06T10:40:00+08:00
lastmod: 2026-11-06T10:40:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["教程", "AI视频", "自媒体"]
description: "GitHub 近 14 万星的开源短视频流水线 MoneyPrinterTurbo：输入一个主题，脚本、素材、配音、字幕、配乐、成片全自动。Windows 一键包、pip、Docker 三种装法全拆解，含免费的零成本配置路线和同名假包避坑。"
showtoc: true
---

想批量做短视频又不想一条条剪？GitHub 上有个开源项目把整条流水线打包了：**MoneyPrinterTurbo**（作者 harry0703），你只输入一个主题或关键词，它自动写脚本、匹配高清素材、生成配音和字幕、配上背景音乐，最后合成一条能直接发的短视频。截至 2026 年 11 月 6 日，它在 GitHub 有约 **13.98 万星、2.23 万 Fork**，MIT 许可证，昨天还在更新代码，是本站 [GitHub 开源项目专题](/categories/ai工具实测/) 里热度最高的视频类项目。本文把三种安装方式、零成本配置和第一次出片的完整步骤写清。先说明口径：安装命令本站在沙箱里实测跑通；生成成片需要你自己的大模型与素材 API Key，生成环节按官方 README 与配置文档核对整理，不冒充全程实测。

![插画：一条短视频自动化流水线，主题输入、文案、素材、配音、字幕、成片依次排开](/images/moneyprinterturbo-guide/cover.webp)

## 它是怎么工作的：一条五环流水线

理解它先理解流水线，出问题也知道卡在哪一环：

1. **写脚本**：调用大模型（DeepSeek、通义千问、Kimi、ChatGPT 等都支持）按主题生成口播文案，并提炼素材搜索关键词；也可以跳过这环，直接粘贴你自己的脚本。
2. **找素材**：按关键词去 Pexels、Pixabay、Coverr 这类免费素材库匹配高清视频片段，或者用你上传的本地图片、视频。
3. **配音**：把脚本读出来。音色服务很多，其中 **Edge TTS 免费且不需要 API Key**，是零成本路线的关键。
4. **字幕与配乐**：按配音自动断句生成字幕（字体、位置、颜色、描边可调），背景音乐可随机、本地指定或 AI 生成，音量独立控制。
5. **合成成片**：竖屏 9:16（1080×1920）、横屏 16:9、方形 1:1 三种画幅，还支持一次批量生成多条、留任务历史。

所以它本质上是「库存素材 + AI 配音」的解说类视频流水线，强项是**量产**：科普、资讯、故事、盘点这类不露脸的内容。想要画面本身也是 AI 生成的原创镜头，那是另一条路线，看本站的 [AI 视频工作流拆解](/posts/ai-video-workflow-claude-seedance/) 和 [AI 视频生成横评](/posts/ai-video-generation-comparison-2026/)。

## 准备：配置要求和三个 Key

**电脑要求不高**（官方口径）：最低 4 核 CPU、4GB 内存，推荐 8GB 内存；显卡不是必需，主要吃云端服务时 CPU 和内存更重要。系统支持 Windows 10+、macOS 11+ 和主流 Linux。本地部署需要 **Python 3.11 或更高**（官方推荐就用 3.11）。

**要准备的 Key，按零成本路线列**：

| 用途 | 推荐 | 费用 |
| --- | --- | --- |
| 写脚本的大模型 | DeepSeek 或通义千问（国内直连、便宜）；也支持 Kimi、火山方舟、ChatGPT、Claude、Gemini 等 | DeepSeek 生成一条脚本通常不到 1 毛钱 |
| 视频素材 | Pexels（免费申请 API Key），备选 Pixabay、Coverr | 免费 |
| 配音 | Edge TTS | 免费、无需 Key |

也就是说，整套跑起来唯一可能花钱的就是大模型那一环，而且花的是零头。素材 Key 的申请都是在对应官网注册后在开发者页面生成，免费、几分钟搞定，这里不展开各家的注册截图（属于各平台常规流程）。

## 安装：三种方式选一条

### 方式一：Windows 一键启动包（小白首选）

1. 打开项目的 [GitHub Releases 页面](https://github.com/harry0703/MoneyPrinterTurbo/releases/latest)，在页面下方 **Assets** 区域下载 `.7z` 压缩包。注意别下错：GitHub 自动生成的 `Source code (zip)` 只是源码，不含启动脚本。
2. 解压到一个**路径里没有中文、空格和特殊字符**的文件夹（比如 `D:\MPT`），这是官方明确提醒的坑。
3. 先双击 `update.bat` 更新到最新代码，再双击 `start.bat` 启动，浏览器会自动打开操作界面；如果打开是空白，换 Chrome 或 Edge 打开它给的本地地址。

### 方式二：pip 安装（有 Python 环境选这个）

官方 PyPI 包名是 **`mpt`**（本站沙箱实测：Python 虚拟环境里一条命令装好）。**特别避坑：PyPI 上那个叫 `MoneyPrinterTurbo` 的包是第三方维护的，不是官方版本，别装错。**

```shell
# macOS / Linux
python3 -m venv .venv
source .venv/bin/activate
# Windows PowerShell
python -m venv .venv
.venv\Scripts\Activate.ps1

python -m pip install mpt
mpt webui
```

WebUI 会自动打开浏览器；想指定端口或不自动打开，用 `mpt webui --port 8503 --headless`。首次启动会自动生成 `config.toml` 配置文件，装 pip 版的数据默认存放在系统应用数据目录下的 MoneyPrinterTurbo 文件夹（Windows 是 `%LOCALAPPDATA%\MoneyPrinterTurbo`），生成的视频在其 `storage/tasks` 里。以后升级在虚拟环境里跑 `python -m pip install --upgrade mpt` 即可。

### 方式三：源码与 Docker（进阶）

源码部署：`git clone https://github.com/harry0703/MoneyPrinterTurbo.git` 后按仓库说明装依赖启动，首次启动同样会从 `config.example.toml` 自动生成 `config.toml`。Docker 用户在项目目录里用官方 compose 文件启动即可，适合想隔离环境或放服务器上跑的人。本文主推前两种，够用了。

## 第一次生成：跟着界面走一遍

1. **填 Key**：打开 WebUI 的基础设置，把上一步准备的大模型 Key、Pexels Key 填进去选好服务商。配音选 Edge TTS 就不用填。
2. **输入主题**：比如「为什么猫总是凌晨三点跑酷」，点生成脚本；脚本出来后可以逐句改，改文案是控制成片质量最便宜的一步。
3. **选素材源**：第一次就用 Pexels 自动匹配；对某几句不满意，可以单独换本地上传的图片或视频。
4. **定画幅和声音**：发抖音、快手、视频号、小红书选竖屏 9:16；选一个 Edge TTS 音色（先试听再定），字幕保持默认样式先跑通，配乐选随机。
5. **生成并取片**：点生成后等它跑完五环，成片在任务历史和 `storage/tasks` 目录里，先完整看一遍再发：重点查素材和文案对不对题、字幕断句有没有切错词。

跑通一条之后，批量模式就是同一套设置换主题列表，一次出多条，适合做系列栏目。

## 几个容易踩的坑

- **装错包**：再说一遍，pip 官方包是 `mpt`，同名的 `MoneyPrinterTurbo` 包是第三方的。
- **路径带中文**：一键包和源码部署都怕中文、空格路径，解压和克隆时就避开。
- **素材不对题**：是大模型提炼的关键词不准，回 WebUI 改脚本里的关键词或换素材源（Pixabay 的中文相关素材弱一些，Pexels 优先）。
- **流量素材慢**：Pexels 在国内访问偶尔慢，属正常现象；批量任务尽量错开网络高峰，或者改用本地素材。
- **版权与同质化**：Pexels、Pixabay 素材有各自的许可条款，商用前看一眼原文；更重要的是，纯流水线量产的解说视频各平台都在限流同质化内容——脚本要加自己的观点和改写，别指望原样量产就能起号。它是省时间的工具，不是流量保证。
- **自动发布别乱开**：它带一键上传 TikTok、Instagram、YouTube Shorts 的功能，那是海外平台；国内平台请下载成片后手动发，别为这个去折腾账号环境。

## 常见问题

**完全不花钱能跑吗？**
能：大模型用各家的免费额度或 DeepSeek（一条脚本几分钱量级），素材 Pexels 免费，配音 Edge TTS 免费。严格零元取决于大模型那环你选谁，但成本上限很低。

**和剪映、即梦是什么关系？**
不是一类东西。剪映是手动剪辑台，即梦是 AI 生成画面；MoneyPrinterTurbo 是把「现成素材 + 配音 + 字幕」自动拼成解说视频的流水线。只想做几秒的动图，用 [ChatGPT 生成 GIF](/posts/chatgpt-gif-guide/) 更快。

**生成的视频能商用吗？**
代码是 MIT 许可证没问题；成片的权利取决于你用的素材许可和大模型服务条款，商用前逐项确认，尤其是素材库条款。

**没有 Python 基础能用吗？**
能，Windows 一键包就是为这种情况准备的：下载、解压、双击两个 bat 文件，剩下的全在网页界面里点。

## 更新记录

- 2026-11-06：首发。数据（星标 139,826、Fork 22,297、MIT）与功能清单于发布当日经 GitHub 官方 API 与仓库 README 核实；pip 安装命令经沙箱实测（mpt 1.3.9，`mpt --help` 正常输出 cli / webui 子命令）。

更多同类项目，见本站 [AI工具实测](/categories/ai工具实测/) 中心页的「GitHub 开源项目精选」专题。

**资料来源**：[MoneyPrinterTurbo GitHub 仓库](https://github.com/harry0703/MoneyPrinterTurbo)（README、Releases 与仓库元数据，2026-11-06 查阅）。
