---
title: "markitdown教程：一键转Markdown喂给AI"
date: 2026-11-04T22:19:00+08:00
lastmod: 2026-11-04T22:19:00+08:00
draft: false
categories: ["AI工具实测"]
tags: ["教程", "知识管理", "AI办公"]
description: "微软开源的 markitdown 能把 PDF、Word、PPT、Excel 一键转成干净的 Markdown，再喂给 AI 读。这篇从装 Python 开始手把手走完安装与转换，附真实输出、批量转换代码和扫描版 PDF 等常见坑的解法。"
showtoc: true
---

把文件喂给 AI 读之前，先用微软开源的 markitdown 转成 Markdown：一条命令安装、一条命令转换，标题、表格、列表都能完整保留，AI 读得准、你也省 token。本文从装 Python 开始全程手把手，转换效果附真实输出。

![各类文件经漏斗转换成一页 Markdown 文本的示意图](/images/markitdown-guide/cover.webp)

## 为什么喂给 AI 之前，先转成 Markdown

直接把 PDF 拖进聊天窗口，是很多人用 AI 读文档的第一步，也经常是踩坑的第一步：双栏排版的论文会被按错误顺序拼接，表格散成一堆对不齐的数字，页眉页脚混进正文里。换个工具、换个版本，结果还不一样，全靠运气。

先转成 Markdown 再喂，是更稳的做法，原因有三：

- **结构还在**。Markdown 用 `#` 标标题、用 `|` 画表格，文档的层级关系被明明白白写出来，AI 不用猜哪行是标题、哪块是表格。
- **大模型最熟这种格式**。markitdown 官方 README 的说法是：主流大模型原生就「说」Markdown，训练语料里有大量 Markdown 文本，理解得最好，顺带还省 token。
- **结果可控**。转换在本地一次完成，生成一个 `.md` 文件，你可以先打开检查一遍，确认没丢内容，再发给任何一个 AI，而不是每个平台都重新抽取一次。

markitdown 是微软开源在 GitHub 上的一个 Python 小工具，专门干「把各种文件转成适合喂给大模型的 Markdown」这一件事。截至 2026 年 11 月，它在 GitHub 上有 19 万多星标，是这个领域最受欢迎的工具，采用 MIT 许可证，个人和公司都可以免费用。按官方 README 的清单，它支持转换的格式包括：

- 文档类：PDF、Word（.docx）、PowerPoint（.pptx）、Excel（.xlsx / .xls）
- 图片（提取附带信息）、音频（语音转文字）
- 网页与数据：HTML、CSV、JSON、XML
- 其他：ZIP 压缩包（逐个转里面的文件）、电子书 EPUB、YouTube 视频链接等

核心的本地文件转换全程离线，不需要翻墙、不调用任何云服务；只有 YouTube 链接、以及后面会提到的 Azure / 大模型增强功能才需要联网。这一点对国内用户很友好。

## 第一步：装好 Python

markitdown 是 Python 工具，需要 Python 3.10 或更高版本（官方支持 3.10 到 3.14）。已经装过 Python 的，先确认版本再跳到第二步。

### Windows（大多数人看这里）

1. 打开官网 [python.org](https://www.python.org/downloads/)，点黄色的 Download 按钮，下载最新版安装包。
2. 双击运行安装包。**安装的第一个界面底部有一个「Add python.exe to PATH」复选框，务必勾上再点 Install**。这是新手最容易踩的坑：不勾，后面输入命令会提示「python 不是内部或外部命令」，本文常见问题里有补救方法。
3. 装完后打开开始菜单，搜索并打开「PowerShell」（或「命令提示符」），输入：

```powershell
python --version
```

能显示类似 `Python 3.13.x` 的版本号，就装好了。

### Mac

打开「终端」，输入 `python3 --version`。有版本号就直接用；没有的话去 python.org 下载 macOS 安装包一路下一步即可。注意 Mac 上命令是 `python3` 和 `pip3`，后文出现 `pip` 的地方替换成 `pip3`。

## 第二步：一条命令装上 markitdown

在 PowerShell / 终端里输入这一条命令：

```bash
pip install "markitdown[all]"
```

说明三点：

- 方括号里的 `all` 表示把全部格式的支持一次性装齐，省得转某种文件时再补装。引号不要漏，PowerShell 里不加引号会直接报错。
- 如果下载特别慢或中途失败，多半是网络问题，换国内镜像源再装一次（清华源， pip 的常规用法）：

```bash
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple "markitdown[all]"
```

- 只想转一两种文件也可以按需装，例如 `pip install "markitdown[pdf,docx]"` 只装 PDF 和 Word 的支持，体积更小。

装完验证一下：输入 `markitdown --help`，能打印出用法说明就是安装成功。本文写作前在 Python 3.12 环境按上面步骤实际安装验证，当时装到的版本是 0.1.9（2026 年 11 月 4 日）。

## 第三步：第一次转换（附真实输出）

假设桌面上有一份 Word 报告 `report.docx`，先在终端里进入它所在的文件夹，然后运行：

```bash
markitdown report.docx -o report.md
```

`-o` 是指定输出文件名。同目录下会多出一个 `report.md`，用记事本或任何文本编辑器打开，就是转换结果。不写 `-o`、改用 `markitdown report.docx > report.md` 效果相同；直接运行 `markitdown report.docx` 则会把结果打印在终端里。

用一份自造的样例 Word 文档（标题 + 正文 + 一张三行数据的表格）实际转换，输出如下（原文节选，未做加工）：

```markdown
# 季度销售汇报

本季度华东区销售额同比增长 12%，主要来自新客户的拓展。以下为各产品线明细。

## 产品线明细

|  |  |  |
| --- | --- | --- |
| 产品线 | 销售额（万元） | 同比 |
| 智能音箱 | 320 | +18% |
| 扫地机器人 | 215 | +9% |
| 空气净化器 | 140 | -3% |

结论：智能音箱继续领跑，空气净化器需要调整定价策略。
```

一级标题、二级标题、数据行列都完整保留，这正是 AI 最容易读懂的形态。有一个小瑕疵如实说明：这份样例的表格转出时多了一行空表头，因为示例文件里的表格没有单独设置「标题行」。遇到这种情况，花十秒钟手动删掉空行、把真正的表头挪到第一行即可，不影响使用。

PDF 同理：`markitdown notice.pdf -o notice.md`，样例是一份会议通知 PDF，转换后正文一字不差地被抽了出来：

```markdown
会议通知

全体成员请于周五下午三点到三楼会议室参加项目复盘会。

请提前准备好各自负责模块的进度说明。
```

其他格式也顺手验证过：PPT 转出来每页有标题和要点列表，并带页码注释；Excel 以工作表名作小标题，表格完整成行。日常办公的四件套（Word、PDF、PPT、Excel）都可以放心转。

## 第四步：把转好的 Markdown 喂给 AI

转换只是手段，目的是让 AI 读。用法很简单：

1. 打开生成的 `.md` 文件，全选复制，粘贴到 DeepSeek、Claude、ChatGPT 等任意对话框，后面跟一句明确指令，例如「按要点总结这份报告，表格里的数据单独列出来，不要改动数字」。
2. 不想复制粘贴，也可以直接把 `.md` 文件作为附件上传，主流 AI 工具都支持。
3. 长文档要分块：一份几百页的 PDF 转出来可能有几十万字，超过多数工具的单次上限。按章节拆成几个 `.md` 分开发，或者先只发目录和第一章，让 AI 有个整体概念再逐节深入。

想对比各家 AI 直接读 PDF 的效果（文件上限、引用定位、中文表现），可以看本站的 [AI 读 PDF 工具对比](/posts/ai-pdf-tools-comparison-2026/)：直接读胜在省事，先转 Markdown 胜在稳定可控，两条路线按文件重要程度选。

## 进阶：在代码里调用和批量转换

如果你会一点 Python，或者想给自己的小工具、Agent 加上「读文件」能力，markitdown 也可以直接在代码里调用。最小写法（实际运行通过）：

```python
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert("report.docx")
print(result.markdown)
```

一个文件夹里几十个文件要批量转，不用一个个敲命令，用一段循环脚本（实际运行通过，Word 和 PDF 都能正确生成对应的 `.md`）：

```python
from pathlib import Path
from markitdown import MarkItDown

md = MarkItDown()
for path in Path("待转换").glob("*.*"):
    if path.suffix.lower() in {".docx", ".pdf", ".pptx", ".xlsx"}:
        result = md.convert(str(path))
        out = Path("已转换") / (path.stem + ".md")
        out.write_text(result.markdown, encoding="utf-8")
        print("已转换:", path.name, "->", out.name)
```

把文件放进脚本同目录的「待转换」文件夹，运行脚本，「已转换」文件夹里就会出现同名 `.md`。给 Agent 准备读文件的预处理环节时，先经 markitdown 转一遍也是业内常见做法（本站的 [从零手写一个会干活的 AI Agent](/posts/build-your-own-ai-agent-tutorial/) 里读文件的环节就可以换成这种转法）。

还有一个可选增强知道即可：给图片生成文字描述、把扫描件里的文字识别出来，需要接入视觉大模型（官方提供 `llm_client` 参数）或微软 Azure 的文档智能服务，要联网、要 API 密钥、可能收费。新手阶段用不上，先把本地转换用熟。

## 常见问题

**问：输入 pip 提示「不是内部或外部命令」，怎么办？**
答：装 Python 时没勾选「Add python.exe to PATH」。补救：重新运行 Python 安装包，选择 Modify（修改），在高级选项里勾上把 Python 加入环境变量；或者干脆卸载后重装并记得勾选。改完要新开一个终端窗口再试，旧窗口不会刷新。

**问：转换出来的中文是乱码？**
答：markitdown 输出的是 UTF-8 编码，用记事本、VS Code 打开 `.md` 文件一般都正常。如果是在 Windows 终端里直接打印结果时乱码，先执行一次 `chcp 65001` 把终端切到 UTF-8 再运行；更稳妥的办法是用 `-o` 输出到文件再打开看。

**问：扫描版 PDF 转出来是空白，怎么回事？**
答：内置转换只抽取 PDF 里已有的文字层，不做 OCR（文字识别）。拿一页纯图片做的 PDF 实测过，输出就是空白。解决办法：先用 OCR 工具把扫描件识别成带文字的版本（手机扫描类 App、Adobe Acrobat 都能做），再交给 markitdown；或者用官方的 markitdown-ocr 插件接视觉大模型识别，需要联网和 API 密钥。

**问：有打开密码的 PDF 转不了？**
答：先在 PDF 阅读器里输入密码打开，另存一份没有密码的副本，再转换副本。

**问：图片文件转出来只有几行字，是坏了吗？**
答：没坏。图片的内置转换只提取 EXIF 等附带信息；想让它「看图说话」生成内容描述，需要接入视觉大模型，属于上面说的可选增强，不是默认功能。

## 参考来源

- GitHub 仓库：[microsoft/markitdown](https://github.com/microsoft/markitdown)
- 官方 README（支持格式、安装与用法说明）：[README.md](https://github.com/microsoft/markitdown/blob/main/README.md)
- PyPI 项目页：[markitdown](https://pypi.org/project/markitdown/)

更多同类工具教程，见本站 [AI工具实测](/categories/ai工具实测/) 中心页。

## 更新记录

- 2026-11-04：首发。基于 markitdown 0.1.9 与 Python 3.12 实际安装验证，Word、PDF、PPT、Excel 各转换一份样例并核对输出，批量转换脚本实际运行通过。
