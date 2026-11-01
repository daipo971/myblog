---
title: "从零手写一个会干活的 AI Agent：零框架完整教程"
date: 2026-11-01T22:15:00+08:00
description: "不用任何框架，只用 Python 和一个国产大模型 API，从零写出一个能查天气、做计算、读文件的 AI Agent。完整代码逐段讲清，含报错排查表，全程约 30 分钟。"
categories: ["AI工具实测"]
tags: ["教程", "AI Agent", "自动化", "DeepSeek"]
showtoc: true
---

聊天机器人只能陪你说话，Agent 能替你干活。区别不在模型多聪明，而在结构：Agent 就是一个循环——模型想一想，决定调用哪个工具，你的程序替它执行，再把结果喂回去，直到任务完成。

这篇不借助任何 Agent 框架，只用 Python 和一个国产大模型 API，从零写出一个有三件工具（查天气、做计算、读文件）的 Agent。代码全部可以复制运行，每一步都写清楚为什么。概念还没搞清的，先看 [AI Agent 完全指南](/posts/ai-agent-complete-guide-2026/)，这篇是动手篇。

## 成品长什么样

跑起来之后，你在终端里给它派活，它会自己决定用哪件工具：

```text
你想让它做什么：北京明天适合晨跑吗？
  [第1步] 调用 get_weather({'city': '北京'})
答复：明天（11月3日）北京 4.9~15.9℃，降雨概率 0%，适合晨跑，就是早晚温差大，记得加件外套。

你想让它做什么：(328+457)×12 等于多少？
  [第1步] 调用 calculator({'expression': '(328+457)*12'})
答复：(328+457)×12 = 9420。

你想让它做什么：读一下 notes.txt，总结成三句话
  [第1步] 调用 read_file({'filename': 'notes.txt'})
答复：……
```

注意中间那行 `[第1步] 调用 …`：那是它自己做的决定，不是你写死的流程。这就是 Agent 和普通脚本的根本区别。

## 准备工作（四步）

### 第一步：装 Python

需要 Python 3.10 以上。

- Windows：去 python.org 下载安装包，安装时**务必勾选最下面的「Add python.exe to PATH」**，不勾后面命令会找不到 Python。
- Mac：终端执行 `brew install python`，没有 Homebrew 就去 python.org 下安装包。

装完打开终端（Windows 用 PowerShell 或 Windows Terminal），验证：

```bash
python --version
```

显示 `Python 3.11.x` 之类的版本号就对了。

### 第二步：拿一个 API 密钥

本文用 DeepSeek 做例子，因为它便宜、接口标准、国内直连。步骤：

1. 打开 platform.deepseek.com，用手机号或邮箱注册并登录。
2. 左侧菜单点「API Keys」→「创建 API Key」，名字随便填，创建后**立刻复制保存**——密钥只完整显示这一次，丢了只能删掉重建。
3. 左侧菜单点「充值」，充 10 元就够练很久（为什么便宜，下面有成本账）。

想换其他模型也行，它们都提供同一种「OpenAI 兼容接口」，只需要改三个值：

| 模型 | base_url | model 填什么 | 备注 |
|---|---|---|---|
| DeepSeek | https://api.deepseek.com | deepseek-chat | 本教程默认，便宜 |
| 通义千问 | https://dashscope.aliyuncs.com/compatible-mode/v1 | qwen-plus | 阿里云百炼开通，有免费额度 |
| 智谱 GLM | https://open.bigmodel.cn/api/paas/v4 | glm-4.5-flash | Flash 系列有免费档 |
| Kimi | https://api.moonshot.cn/v1 | kimi-k2-0905-preview | 月之暗面开放平台开通 |

没有 API 密钥、想先白嫖额度的，看这篇 [免费 AI API 指南](/posts/free-ai-api-guide/)。

### 第三步：装一个库

```bash
pip install openai
```

慢或者超时就换国内镜像：

```bash
pip install openai -i https://pypi.tuna.tsinghua.edu.cn/simple
```

只需要这一个库。后面查天气用的是 Python 自带的网络库，不再装别的——依赖越少，报错越少。

### 第四步：建项目文件夹

新建一个文件夹，比如 `my-agent`，在里面建两个空文件：`agent.py`（主程序，一会儿往里写）和 `notes.txt`（给读文件工具练手用，随便写几段话进去，比如你这周的待办）。

## 第一步：先让它「能说话」

把下面 7 行写进 `agent.py`，把密钥换成你自己的：

```python
from openai import OpenAI

client = OpenAI(api_key="sk-你的密钥", base_url="https://api.deepseek.com")

resp = client.chat.completions.create(
    model="deepseek-chat",
    messages=[{"role": "user", "content": "你好，用一句话介绍你自己"}],
)
print(resp.choices[0].message.content)
```

终端里切到 `my-agent` 文件夹，运行：

```bash
python agent.py
```

它回一句话，就说明「你的程序 ↔ 大模型」这条线通了。后面所有复杂功能，都是在这 7 行上添东西。

这一步最常见的两个报错，先说在前面：

- **401**：密钥错了。多半是复制时带了空格，或者把密钥填到了别的平台。回平台删掉重建一个。
- **402**：余额不足。DeepSeek 新账号没有免费额度，先充 10 元。

## 第二步：给它三件工具

工具在 Agent 里有两半：一半是**真正干活的 Python 函数**（它的手），一半是**写给模型看的说明书**（JSON 格式，告诉模型这件工具叫什么、干什么、要什么参数）。先写手，说明书在第三步统一给。

### 工具一：计算器

为什么不让模型直接算？因为大模型是「猜」数字的，四则运算位数一多就出错。让它调用计算器，结果才可靠。

还有一个安全点：新手教程里常见写法是 `eval(expression)`，这等于把任意代码执行权交出去，模型一旦被诱导，后果不可控。下面这版只认数字和加减乘除，用语法树逐个节点验算：

```python
import ast
import operator

OPS = {ast.Add: operator.add, ast.Sub: operator.sub, ast.Mult: operator.mul,
       ast.Div: operator.truediv, ast.USub: operator.neg}

def _eval(node):
    if isinstance(node, ast.Expression):
        return _eval(node.body)
    if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
        return node.value
    if isinstance(node, ast.BinOp) and type(node.op) in OPS:
        return OPS[type(node.op)](_eval(node.left), _eval(node.right))
    if isinstance(node, ast.UnaryOp) and type(node.op) in OPS:
        return OPS[type(node.op)](_eval(node.operand))
    raise ValueError("只支持加减乘除")

def calculator(expression: str) -> str:
    try:
        return str(_eval(ast.parse(expression, mode="eval")))
    except Exception as e:
        return f"计算失败：{e}"
```

注意最后的写法：出错时不抛异常崩掉，而是把「计算失败：原因」当结果返回——模型看到错误信息，有机会自己改正表达式重试。这是写工具的一条通用原则：**工具永远要返回字符串，报错也要返回，不要让程序崩**。

### 工具二：查天气（免密钥）

天气数据用 Open-Meteo：免费、不用注册、不用密钥，国内可直连。它分两步：先按城市名查经纬度，再用经纬度查预报。本站已实测可用（北京未来三天预报能正常返回）：

```python
import json
import urllib.parse
import urllib.request

def get_weather(city: str) -> str:
    try:
        q = urllib.parse.quote(city)
        with urllib.request.urlopen(
            f"https://geocoding-api.open-meteo.com/v1/search?name={q}&count=1&language=zh",
            timeout=15,
        ) as r:
            places = json.load(r).get("results")
        if not places:
            return f"找不到城市：{city}"
        p = places[0]
        url = ("https://api.open-meteo.com/v1/forecast"
               f"?latitude={p['latitude']}&longitude={p['longitude']}"
               "&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max"
               "&timezone=Asia%2FShanghai&forecast_days=3")
        with urllib.request.urlopen(url, timeout=15) as r:
            d = json.load(r)["daily"]
        lines = [f"{p['name']}未来三天天气："]
        for i in range(len(d["time"])):
            lines.append(
                f"{d['time'][i]}：{d['temperature_2m_min'][i]}~{d['temperature_2m_max'][i]}℃，"
                f"降雨概率 {d['precipitation_probability_max'][i]}%")
        return "\n".join(lines)
    except Exception as e:
        return f"查天气失败：{e}"
```

### 工具三：读文件

让 Agent 读你指定的文件并总结、改写、提取信息。关键是围栏：只许读程序所在文件夹里的文件，防止它（或诱导它的人）去翻你电脑里的其他东西：

```python
from pathlib import Path

BASE_DIR = Path(__file__).parent

def read_file(filename: str) -> str:
    try:
        path = (BASE_DIR / filename).resolve()
        if not str(path).startswith(str(BASE_DIR.resolve())):
            return "拒绝：只能读本文件夹内的文件"
        text = path.read_text(encoding="utf-8")
        return text[:3000]
    except FileNotFoundError:
        return f"文件不存在：{filename}"
    except Exception as e:
        return f"读文件失败：{e}"
```

`text[:3000]` 是把返回内容截到 3000 字：文件太长会撑爆模型的上下文，还费钱。真实项目里读大文件要做分段和摘要，练手阶段先这样。

## 第三步：说明书 + 核心循环（Agent 的脑）

### 先写工具说明书

模型看不到你的函数源码，它靠这份 JSON 说明书决定调哪件工具。说明书有三样必须写清：工具名（和函数名一字不差）、它是干什么的（模型靠这句判断何时用）、参数是什么类型：

```python
TOOLS = [
    {"type": "function", "function": {
        "name": "calculator",
        "description": "计算数学表达式，只支持加减乘除和括号",
        "parameters": {"type": "object", "properties": {
            "expression": {"type": "string", "description": "如 (328+457)*12"}},
            "required": ["expression"]}}},
    {"type": "function", "function": {
        "name": "get_weather",
        "description": "查询某个城市未来三天的天气预报",
        "parameters": {"type": "object", "properties": {
            "city": {"type": "string", "description": "城市名，如 北京、武汉"}},
            "required": ["city"]}}},
    {"type": "function", "function": {
        "name": "read_file",
        "description": "读取程序所在文件夹里的文本文件内容",
        "parameters": {"type": "object", "properties": {
            "filename": {"type": "string", "description": "文件名，如 notes.txt"}},
            "required": ["filename"]}}},
]

# 工具名 → 函数本体，循环里按名字找函数就靠这张表
TOOLS_IMPL = {"calculator": calculator, "get_weather": get_weather, "read_file": read_file}
```

`description` 写得越具体，模型选工具越准。比如天气工具的说明如果只写「天气」，你问「明天适合跑步吗」它未必反应过来；写上「查询未来三天天气预报」，它就知道该先查再答。

### 再写核心循环

整个 Agent 的灵魂就是这二十几行。先把第一步那 7 行的开头换成这段配置，再把循环接在所有工具和说明书之后：

```python
SYSTEM = """你是一个能干活的助手。你有三件工具：calculator（计算）、get_weather（查天气）、read_file（读文件）。
遇到算数、天气、读文件的问题，必须调用工具拿真实结果，不许凭记忆编造。
工具结果出来之后，用简洁的中文给出最终答复。"""

def run_agent(task: str, max_steps: int = 6) -> str:
    messages = [{"role": "system", "content": SYSTEM},
                {"role": "user", "content": task}]
    for step in range(max_steps):
        resp = client.chat.completions.create(model=MODEL, messages=messages, tools=TOOLS)
        msg = resp.choices[0].message
        messages.append(msg)
        if not msg.tool_calls:
            return msg.content
        for call in msg.tool_calls:
            fn = TOOLS_IMPL[call.function.name]
            args = json.loads(call.function.arguments)
            print(f"  [第{step+1}步] 调用 {call.function.name}({args})")
            result = fn(**args)
            messages.append({"role": "tool", "tool_call_id": call.id, "content": result})
    return "（已达到最大步数，任务未完成）"

if __name__ == "__main__":
    while True:
        task = input("\n你想让它做什么（输入 q 退出）：").strip()
        if task.lower() == "q":
            break
        print("答复：", run_agent(task))
```

其中配置部分（放在文件顶部工具函数之前）：

```python
client = OpenAI(api_key="sk-你的密钥", base_url="https://api.deepseek.com")
MODEL = "deepseek-chat"
```

### 逐段拆解这个循环

1. **messages 是它的全部记忆**。列表里装着系统提示、你的问题、它每一步的回复和每个工具的结果。对话能「记住上下文」，靠的就是每次请求都把这个列表整个发过去——模型本身是无记忆的。
2. **tools=TOOLS 是把菜单递给它**。每次请求都带上说明书，它才知道自己有手。
3. **判断它想不想用工具**，看返回的 `msg.tool_calls`：为空，说明它认为可以直接答，`msg.content` 就是最终答复；不为空，里面写着它点名的工具和参数（参数是 JSON 字符串，要用 `json.loads` 解开）。
4. **执行并回喂**：按名字从 TOOLS_IMPL 找到函数、执行、把结果包装成 `role` 为 `tool` 的消息塞回列表，然后进入下一轮循环——它看到工具结果后，可能收尾答复，也可能接着调下一个工具（比如先读文件、再计算，一次任务连用两件工具，就是这么发生的）。
5. **max_steps 是刹车**。万一它钻牛角尖反复调同一个工具，6 步强制停。没有这行，bug 能烧掉你全部余额。

组装顺序自查一遍：配置（client、MODEL）→ 三个工具函数 → TOOLS 说明书与 TOOLS_IMPL → SYSTEM 与 run_agent → 主入口。`json`、`ast` 等 import 都写在各段开头了，照抄不会缺。

## 跑起来实测

保存文件，在 `my-agent` 文件夹里运行 `python agent.py`，依次试这三个任务：

1. 「北京明天适合晨跑吗？」——应看到它调用 get_weather，再结合温度和降雨概率给建议。
2. 「(328+457)×12 等于多少？」——注意把「×」换成「*」写进问题也没关系，模型会自己把表达式翻译成 `(328+457)*12` 再调用 calculator；正确答案 9420。
3. 「读一下 notes.txt，用三句话总结」——先往 notes.txt 里随便写点东西，它读完会给你摘要。

三个都能跑通，你的 Agent 就完工了。它已经具备 Agent 的全部核心机制，剩下的都是往上加东西。

## 报错排查表

| 报错/现象 | 原因 | 解法 |
|---|---|---|
| 401 AuthenticationError | 密钥错或串平台 | 回平台删旧密钥、重建，复制时别带空格 |
| 402 Insufficient Balance | 没充值 | 充 10 元再试 |
| 429 Rate Limit | 请求太频繁 | 等几十秒；别开多个窗口同时跑 |
| ModuleNotFoundError: openai | 库没装或装错 Python | 用 `python -m pip install openai` 重装 |
| pip 下载超时 | 网络到 PyPI 慢 | 加清华镜像参数（见准备工作第三步） |
| 它不调工具、直接编答案 | 系统提示没压住，或问题太含糊 | 照抄本文的 SYSTEM，把问题说具体（如点名城市） |
| 反复调用同一个工具不停 | 工具返回的信息不够或报错含糊 | 工具报错要写清原因；max_steps 会兜底停 |
| Windows 终端中文乱码 | 控制台编码问题 | 先执行 `chcp 65001`，或改用 Windows Terminal |

## 成本账

这种练手 Agent 花不了多少钱。以 DeepSeek 为例，一次「查天气 + 回答」的全程消耗大约几千 token，按官方价格页折算通常不到 1 分钱；充 10 元够你反复改代码测试几百次。各家价格都在变，下单前以官网价格页为准——重点是：**自己搭 Agent 的门槛从来不是钱，是有没有人把步骤写清楚**。

## 常见问题

**完全不会 Python，能跟着做吗？**
能。本文的代码都是整段给好的，照抄就能跑；看不懂的语法，把代码段贴给任意一个 AI 让它逐行解释即可。想真正走远，再补一周 Python 基础（变量、函数、列表、字典四样就够用很久）。

**一分钱不花行不行？**
行。用智谱的免费 Flash 模型或阿里云百炼的免费额度，按准备工作里的表格换上对应的 base_url 和 model，整个教程照跑。代价是速度慢一些、额度有上限，练手足够。

**这和直接用豆包、ChatGPT 有什么区别？**
它们是成品，这个是你自己的：工具由你定、能读你电脑里的文件、流程能嵌进你自己的程序里。本文的重点也不是这个玩具本身，而是让你看清所有 Agent 产品共用的骨架。

**它能自己上网搜索吗？**
本文没配搜索工具，因为好用的搜索 API 大多要单独申请密钥。想加仍然是那三步：找一个搜索 API 写成函数、补说明书、登记名字，十分钟的事。

**能放到服务器上长期跑吗？**
能，但上公网之前做两件事：密钥改从环境变量读取，不要写死在代码里；给它套一层最基本的访问限制，别裸奔。先在自己电脑上玩明白，再考虑上服务器。

## 进阶路线（按需求选一条）

- **想要图形界面、不想写代码**：用 Dify 或扣子搭，本文这套工具说明书的思路原样通用；先横向看看 [AI 自动化工具对比](/posts/ai-automation-tools-2026/) 再选。
- **想让工具无限扩展**：去了解 MCP——给工具定的统一接口标准，相当于工具界的 USB。理解了本文的「说明书」，MCP 一看就懂。
- **想让它定时自动干活**（每天早上汇总新闻、定时查价）：把 Agent 接到调度工具上，站内这篇 [用 n8n 搭建 AI 自动化工作流](/posts/ai-agent-workflow-guide-2026/) 是现成路线。
- **不想花 API 钱**：把模型换成本地运行的开源模型，接口同样兼容，见 [本地大模型部署指南](/posts/ai-local-llm-guide-2026/)。
- **想在手机上遥控电脑里的 Agent**：这是今年刚出的新玩法，见 [Hermes Agent 手机版公测](/posts/hermes-agent-mobile-beta/)。

## 最后，给它加一件你自己的工具

验收标准只有一个：你能独立给它加第四件工具。方法永远是三步——写一个「输入字符串、返回字符串」的函数；在 TOOLS 里照葫芦画瓢加一份说明书；在 TOOLS_IMPL 里登记名字。查快递、记账本、翻译、查快递单号背后的物流接口……全是这个套路。

所谓 Agent 框架，无论多贵多复杂，拆开都是本文这个循环加上更多工具、更长的记忆和更严的围栏。你已经把最核心的那部分亲手写出来了。
