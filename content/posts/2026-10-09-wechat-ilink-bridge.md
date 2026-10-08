---
title: "免翻墙！微信官方通道直连 AI 助手：iLink / ClawBot 扫码登录完整教程"
date: 2026-10-09
draft: false
tags: ["微信", "AI助手", "iLink", "ClawBot", "教程"]
categories: ["AI工具"]
summary: "腾讯官方给个人 AI 助手开的微信通道：扫码授权、长轮询收发消息。附完整 Python 实现 bridge.py（登录/常驻/自动回复/看门狗），以及必须知道的限制、坑点与隐私取舍。"
---

想在微信里直接跟 AI 助手聊天，最大的拦路虎一直是"微信不开放个人号接口"。以前的野路子（itchat 之类走网页协议）在 2024 年基本全灭，轻则掉线、重则封号。

但 2026 年情况变了：腾讯官方为 OpenClaw 这类 AI 助手开了正式的微信通道——**iLink / ClawBot**：扫码授权登录，HTTP 长轮询收发消息，走的是腾讯自己的 `ilinkai.weixin.qq.com` 后端。这是官方能力，不是外挂。

先把最重要的取舍摆在前面，不隐瞒：

- ✅ 微信内直连，**国内不用翻墙**
- ⚠️ 所有消息必经腾讯服务器，**聊天内容腾讯可见**——走微信通道这一点绕不开
- ✅ 官方扫码授权流程，是目前接微信封号风险最低的方案

能接受第 2 条，再往下看。接受不了的话，直接拉到文末看替代方案。

## 一、先验证：这东西是真的吗

动手前我做了两件事：

1. 读了微信官方文档 `developers.weixin.qq.com/doc/aispeech/knowledge/openapi/Clawbotrelated.html`（微信智能对话开放平台 → clawbot 相关接口），里面明确写了二维码登录、状态轮询、凭据下发的完整流程。
2. 把腾讯官方开源的 npm 包 `@tencent-weixin/openclaw-weixin`（MIT 协议）2.4.9 版源码下载下来，对照着把协议逐项验证了一遍。

结论：协议真实存在，下面教程里的每一个接口、请求头、字段都和官方源码对得上。取二维码这一步我已实际调通，腾讯服务器正常返回了 `qrcode` 和 `qrcode_img_content`。

## 二、原理速览（30 秒看懂）

```
你（微信） ⇄ 腾讯 iLink 服务器 ⇄ 桥接程序 ⇄ AI 助手
```

1. 桥接程序向腾讯申请一个登录二维码
2. 你用微信扫码，在手机上点"确认授权"
3. 腾讯下发 `bot_token`（相当于登录态）+ 你的微信 ID
4. 桥接程序用 `getupdates` 长轮询收你的消息，用 `sendmessage` 把 AI 的回复发回去

你的手机和桥接程序**从不直连**，两边都只是出站连接腾讯服务器，所以不需要公网 IP，也不用内网穿透。

## 三、准备工作

- 一台能联网的机器（VPS、云服务器、家里的电脑都行，本文用 Linux）
- Python 3.8+
- 装一个二维码库：`pip install qrcode`

## 四、协议详解：5 个接口

基地址：`https://ilinkai.weixin.qq.com`

通用请求头（每个请求都带）：

- `iLink-App-Id: bot`
- `iLink-App-ClientVersion: 132105`（版本号 2.4.9 按 `0x00MMNNPP` 规则编码）

POST 请求额外带：`Content-Type: application/json`、`AuthorizationType: ilink_bot_token`、`X-WECHAT-UIN`（随机 uint32 → 十进制字符串 → base64）、登录后加 `Authorization: Bearer <bot_token>`。

| 接口 | 方法 | 作用 |
|------|------|------|
| `/ilink/bot/get_bot_qrcode?bot_type=3` | POST | 拿登录二维码。请求体 `{"local_token_list": []}`，**不带** Authorization 头和 base_info |
| `/ilink/bot/get_qrcode_status?qrcode=xxx` | GET | 35 秒长轮询扫码状态：`wait`（等待）/ `scaned`（已扫）/ `confirmed`（已确认）/ `expired`（过期）。**只带**上面两个通用头 |
| `/ilink/bot/getupdates` | POST | 35 秒长轮询收消息，请求体带 `get_updates_buf` 游标和 `base_info` |
| `/ilink/bot/sendmessage` | POST | 发消息（坑最多的接口，见下文） |

扫码状态变为 `confirmed` 时，腾讯返回四个关键值：`bot_token`、`baseurl`、`ilink_bot_id`、`ilink_user_id`（扫码人的微信 ID，格式如 `xxx@im.wechat`）。

### 大坑：sendmessage 的"幽灵字段"

这个接口最阴险的地方：字段缺了**不报错**——HTTP 200、空响应体，但消息就是发不出去。对照官方源码 + 社区实测，必须带全这些：

- `msg.from_user_id` 必须是空字符串 `""`（是传空字符串，不是"不传这个字段"）
- `msg.client_id` 每条消息唯一（随机生成，服务端拿它做去重和路由）
- `msg.message_type = 2`（标记为 Bot 发出的消息）
- `msg.message_state = 2`（标记为完成态）
- `msg.context_token` 原样回传**用户那条消息里带的**那个值——没有它，消息发不出去
- 顶层必须带 `base_info: {"channel_version": ..., "bot_agent": ...}`
- 文本内容放在 `msg.item_list: [{"type": 1, "text_item": {"text": "..."}}]`

以及一个硬性规则：**Bot 不能主动发起对话**。`context_token` 只有在用户先给你发过消息之后才能拿到，所以第一条消息必须由用户先发，这一点无解。

token 失效的唯一信号是 `ret` / `errcode = -14`，**没有刷新机制**，失效后只能重新扫码登录。

## 五、完整代码：bridge.py

下面是完整实现，只用 Python 标准库 `urllib`（外加 `qrcode` 画二维码），5 个命令：`login`（取码）/ `wait-login`（等扫码）/ `serve`（常驻收发）/ `send`（发测试消息）/ `status`（看状态）。存为 `bridge.py` 直接能跑：

```python
#!/usr/bin/env python3
"""微信 iLink 桥接：扫码登录 + 长轮询收发。只用标准库 urllib（+ qrcode 画二维码）。"""

import argparse, base64, json, os, random, sys, time
import urllib.parse, urllib.request, urllib.error, uuid
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
STATE_DIR = BASE_DIR / "state"          # 登录态等敏感文件，只放这里
INBOX_DIR = BASE_DIR / "inbox"          # 收到的消息
PENDING_DIR = BASE_DIR / "outbox" / "pending"  # 待发送的回复
SENT_DIR = BASE_DIR / "outbox" / "sent"         # 已发送的回复
SESSION_FILE = STATE_DIR / "session.json"
LOGIN_FILE = STATE_DIR / "login.json"
CURSOR_FILE = STATE_DIR / "cursor.txt"
PID_FILE = STATE_DIR / "serve.pid"
NEEDS_RELOGIN = STATE_DIR / "NEEDS_RELOGIN"
QR_PNG = BASE_DIR / "qr.png"

DEFAULT_BASE = "https://ilinkai.weixin.qq.com"
ILINK_APP_ID = "bot"
ILINK_APP_CLIENT_VERSION = str((2 << 16) | (4 << 8) | 9)  # 2.4.9 -> 132105
CHANNEL_VERSION = "2.4.9"
BOT_AGENT = "OpenClaw"
BOT_TYPE = "3"
QR_POLL_TIMEOUT = 40
UPDATES_POLL_TIMEOUT = 40
API_TIMEOUT = 15
STALE_TOKEN_ERRCODE = -14  # token 失效的唯一信号，没有刷新机制

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)

def mask(s, keep=4):
    s = str(s or "")
    return s[:keep] + "..." if len(s) > keep else "****"

def atomic_write_json(path: Path, obj, mode=0o600):
    """原子写入：先写临时文件再 rename，不会留下写一半的文件。"""
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".tmp")
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)
    os.chmod(tmp, mode)
    os.replace(tmp, path)

def atomic_write_text(path: Path, text, mode=0o600):
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".tmp")
    with open(tmp, "w", encoding="utf-8") as f:
        f.write(text)
    os.chmod(tmp, mode)
    os.replace(tmp, path)

def rand_uin():
    n = random.getrandbits(32)
    return base64.b64encode(str(n).encode()).decode()

def common_headers():
    return {"iLink-App-Id": ILINK_APP_ID,
            "iLink-App-ClientVersion": ILINK_APP_CLIENT_VERSION}

def post_headers(token=None):
    h = {"Content-Type": "application/json",
         "AuthorizationType": "ilink_bot_token",
         "X-WECHAT-UIN": rand_uin()}
    h.update(common_headers())
    if token:
        h["Authorization"] = f"Bearer {token}"
    return h

def base_info():
    return {"channel_version": CHANNEL_VERSION, "bot_agent": BOT_AGENT}

def http_post(base, endpoint, body: dict, token=None, timeout=API_TIMEOUT,
              with_base_info=True):
    if with_base_info:
        body = dict(body); body["base_info"] = base_info()
    raw = json.dumps(body, ensure_ascii=False).encode("utf-8")
    url = base.rstrip("/") + "/" + endpoint.lstrip("/")
    req = urllib.request.Request(url, data=raw, headers=post_headers(token), method="POST")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            text = r.read().decode("utf-8", "replace").strip()
    except urllib.error.HTTPError as e:
        raise RuntimeError(f"POST {endpoint} HTTP {e.code}")
    return json.loads(text) if text and text != "{}" else {"ret": 0}

def http_get(base, endpoint, timeout=QR_POLL_TIMEOUT):
    url = base.rstrip("/") + "/" + endpoint.lstrip("/")
    req = urllib.request.Request(url, headers=common_headers(), method="GET")
    with urllib.request.urlopen(req, timeout=timeout) as r:
        text = r.read().decode("utf-8", "replace").strip()
    return json.loads(text) if text else {}

def load_session():
    if not SESSION_FILE.exists():
        return None
    return json.loads(SESSION_FILE.read_text(encoding="utf-8"))

class TokenDead(Exception): pass

def check_stale(resp, where):
    if resp.get("errcode") == STALE_TOKEN_ERRCODE or resp.get("ret") == STALE_TOKEN_ERRCODE:
        raise TokenDead(f"{where}: token 失效 (errcode -14)")

def mark_needs_relogin(reason):
    atomic_write_text(NEEDS_RELOGIN, f"{time.strftime('%Y-%m-%d %H:%M:%S')} {reason}\n")

def cmd_login(_args):
    log("正在申请登录二维码 ...")
    resp = http_post(DEFAULT_BASE, f"ilink/bot/get_bot_qrcode?bot_type={BOT_TYPE}",
                     {"local_token_list": []}, token=None,
                     with_base_info=False, timeout=API_TIMEOUT)
    qrcode, img_content = resp.get("qrcode"), resp.get("qrcode_img_content")
    if not qrcode or not img_content:
        raise RuntimeError(f"二维码接口返回异常: {json.dumps(resp)[:200]}")
    atomic_write_json(LOGIN_FILE, {"qrcode": qrcode, "base": DEFAULT_BASE,
                                   "created_at": time.time()})
    import qrcode as qrmod
    qr = qrmod.QRCode(border=2); qr.add_data(img_content); qr.make(fit=True)
    qr.make_image(fill_color="black", back_color="white").save(str(QR_PNG))
    log(f"二维码已保存: {QR_PNG}（5 分钟有效，尽快扫码）")

def cmd_wait_login(args):
    if not LOGIN_FILE.exists():
        sys.exit("先运行 login 拿二维码")
    login = json.loads(LOGIN_FILE.read_text(encoding="utf-8"))
    qrcode, base = login["qrcode"], login.get("base", DEFAULT_BASE)
    deadline = time.time() + (args.timeout or 300)
    log("轮询扫码状态中（35 秒长轮询）...")
    while time.time() < deadline:
        try:
            st = http_get(base, f"ilink/bot/get_qrcode_status?qrcode={urllib.parse.quote(qrcode)}")
        except Exception as e:
            log(f"轮询出错，重试: {e}"); time.sleep(3); continue
        status = st.get("status")
        if status == "confirmed":
            sess = {"bot_token": st.get("bot_token"),
                    "baseurl": st.get("baseurl") or DEFAULT_BASE,
                    "ilink_bot_id": st.get("ilink_bot_id"),
                    "ilink_user_id": st.get("ilink_user_id"),
                    "context_token": "",
                    "login_at": time.strftime("%Y-%m-%d %H:%M:%S")}
            atomic_write_json(SESSION_FILE, sess, mode=0o600)  # 仅自己可读
            LOGIN_FILE.unlink(missing_ok=True)
            if NEEDS_RELOGIN.exists(): NEEDS_RELOGIN.unlink()
            log(f"登录成功，用户: {mask(sess['ilink_user_id'])}")
            print("LOGIN_OK"); return
        if status == "expired":
            LOGIN_FILE.unlink(missing_ok=True); sys.exit("二维码过期，重新运行 login")
        if status in ("need_verifycode", "verify_code_blocked"):
            sys.exit("微信要求输入配对码，请在手机上按提示操作后重试")
        if status == "scaned":
            log("已扫码，等待手机上点确认 ...")
        time.sleep(1)
    sys.exit("等待超时")

def extract_text(msg):
    return "\n".join((i.get("text_item") or {}).get("text", "")
                     for i in msg.get("item_list") or [] if i.get("type") == 1).strip()

def cmd_serve(_args):
    sess = load_session()
    if not sess: sys.exit("还没登录，先跑 login + wait-login")
    token, base, my_id = sess["bot_token"], sess.get("baseurl") or DEFAULT_BASE, sess.get("ilink_user_id")
    atomic_write_text(PID_FILE, str(os.getpid()), mode=0o644)
    cursor = CURSOR_FILE.read_text(encoding="utf-8").strip() if CURSOR_FILE.exists() else ""
    log(f"常驻服务启动，只处理用户 {mask(my_id)} 的私聊消息")
    backoff = 5
    while True:
        try:
            resp = http_post(base, "ilink/bot/getupdates", {"get_updates_buf": cursor},
                             token=token, timeout=UPDATES_POLL_TIMEOUT)
            check_stale(resp, "getupdates")
            if resp.get("get_updates_buf"):
                cursor = resp["get_updates_buf"]; atomic_write_text(CURSOR_FILE, cursor)
            for msg in resp.get("msgs") or []:
                from_id = msg.get("from_user_id") or ""
                if msg.get("group_id") or from_id != my_id:  # 只收自己的私聊，群消息忽略
                    continue
                text = extract_text(msg)
                if not text: continue
                mid = str(msg.get("message_id") or int(time.time() * 1000))
                INBOX_DIR.mkdir(parents=True, exist_ok=True)
                atomic_write_json(INBOX_DIR / f"{mid}.json",
                    {"message_id": mid, "text": text, "from_user_id": from_id,
                     "context_token": msg.get("context_token") or "",
                     "ts": time.strftime("%Y-%m-%d %H:%M:%S")}, mode=0o600)
                if msg.get("context_token"):  # 缓存最新的 context_token，供回复用
                    sess["context_token"] = msg["context_token"]
                    atomic_write_json(SESSION_FILE, sess, mode=0o600)
                log(f"收到: {text[:60]}")
            # 发掉待发送队列里的回复
            PENDING_DIR.mkdir(parents=True, exist_ok=True); SENT_DIR.mkdir(parents=True, exist_ok=True)
            for p in sorted(PENDING_DIR.glob("*.json")):
                job = json.loads(p.read_text(encoding="utf-8"))
                ctx = job.get("context_token") or sess.get("context_token") or ""
                if not ctx:
                    log(f"{p.name}: 还没有 context_token（等用户先发消息），跳过"); continue
                send_text(base, token, job.get("to_user_id") or my_id, job.get("text", ""), ctx)
                p.rename(SENT_DIR / p.name); log(f"已发送: {job.get('text','')[:60]}")
            backoff = 5
        except TokenDead as e:
            mark_needs_relogin(str(e)); log("token 失效，退出等待重新扫码"); sys.exit(10)
        except Exception as e:
            log(f"出错 {type(e).__name__}，{backoff} 秒后重试"); time.sleep(backoff)
            backoff = min(backoff * 2, 120)

def send_text(base, token, to_user_id, text, context_token):
    body = {"msg": {"from_user_id": "",  # 必须是空字符串！
                    "to_user_id": to_user_id,
                    "client_id": f"bridge-{uuid.uuid4().hex}",  # 每次唯一
                    "message_type": 2, "message_state": 2,
                    "context_token": context_token,  # 原样回传用户消息里的值
                    "item_list": [{"type": 1, "text_item": {"text": text}}]}}
    resp = http_post(base, "ilink/bot/sendmessage", body, token=token, timeout=API_TIMEOUT)
    check_stale(resp, "sendmessage")
    return resp

def cmd_send(args):
    sess = load_session()
    if not sess: sys.exit("还没登录")
    ctx = sess.get("context_token") or ""
    if not ctx: sys.exit("还没有 context_token：先在微信里给 Bot 发一条消息")
    try:
        send_text(sess.get("baseurl") or DEFAULT_BASE, sess["bot_token"],
                  sess["ilink_user_id"], args.text, ctx)
    except TokenDead as e:
        mark_needs_relogin(str(e)); sys.exit("token 失效，请重新扫码")
    log("测试消息已发送"); print("SEND_OK")

def cmd_status(_args):
    sess = load_session()
    out = {"logged_in": bool(sess), "needs_relogin": NEEDS_RELOGIN.exists()}
    if sess:
        out.update({"login_at": sess.get("login_at"), "user": mask(sess.get("ilink_user_id")),
                    "has_context_token": bool(sess.get("context_token"))})
    alive = False
    if PID_FILE.exists():
        try: os.kill(int(PID_FILE.read_text().strip()), 0); alive = True
        except Exception: pass
    out["serve_alive"] = alive
    out["inbox_count"] = len(list(INBOX_DIR.glob("*.json"))) if INBOX_DIR.exists() else 0
    out["pending_count"] = len(list(PENDING_DIR.glob("*.json"))) if PENDING_DIR.exists() else 0
    print(json.dumps(out, ensure_ascii=False, indent=2))

def main():
    ap = argparse.ArgumentParser(prog="bridge.py"); sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("login")
    w = sub.add_parser("wait-login"); w.add_argument("--timeout", type=int, default=300)
    sub.add_parser("serve")
    s = sub.add_parser("send"); s.add_argument("--text", required=True)
    sub.add_parser("status")
    args = ap.parse_args()
    {"login": cmd_login, "wait-login": cmd_wait_login, "serve": cmd_serve,
     "send": cmd_send, "status": cmd_status}[args.cmd](args)

if __name__ == "__main__":
    main()
```

另外建个 `.gitignore`，把敏感目录排除掉，凭据永远不进仓库：

```
state/
qr.png
```

## 六、运行步骤

### 1. 拿二维码

```bash
python3 bridge.py login
```

会在当前目录生成 `qr.png`。**二维码 5 分钟有效**，尽快扫。

### 2. 微信扫码确认

用手机微信扫 `qr.png`，在手机上点确认授权。

### 3. 完成登录

```bash
python3 bridge.py wait-login
```

看到 `LOGIN_OK` 就是成功了。凭据保存在 `state/session.json`（600 权限，仅自己可读）。

### 4. 常驻运行

```bash
nohup python3 bridge.py serve > state/serve.log 2>&1 &
```

serve 循环干两件事：长轮询收消息 → 写入 `inbox/`；把 `outbox/pending/` 里的回复发出去 → 移到 `outbox/sent/`。

### 5. 发第一条消息，打通链路

在微信里**你先给 Bot 发一条消息**（比如"你好"）——这是必须的，Bot 不能主动开口。然后：

```bash
python3 bridge.py send --text "链路测试：收发正常"
```

手机上收到这条回复，收发链路就全通了。

### 6. 自动回复 + 看门狗（可选）

- **自动回复**：写个定时任务，每 20 秒检查 `inbox/` 有没有未处理的新消息，有就调 AI 生成回复（200 字以内、朋友聊天的口吻），写入 `outbox/pending/<随机id>.json`（格式 `{"to_user_id", "text", "context_token"}`），serve 会自动发出去；处理过的 `message_id` 记入 `state/processed.json` 防重复。AI 处理不了的复杂问题，回一句"收到，我记下了"并转告主人。
- **看门狗**：每 5 分钟检查 serve 进程是否存活，挂了就拉起来；发现 `NEEDS_RELOGIN` 标记（token 失效）就提醒主人重新扫码（只提醒一次）。

跑通之后，在微信里发消息，半分钟内就能收到 AI 的回复。

## 七、官方限制（实话实说）

1. **只支持一对一私聊**，不支持群聊
2. **不能主动发起对话**：必须用户先发过消息、拿到 `context_token` 才能回复
3. 用户发消息后 24 小时内，连续主动发约 10 条、对方不回复会被限流，对方回一句就重置
4. token 没有刷新机制，失效（`errcode = -14`）后必须重新扫码；按社区实测，会话大约 24 小时过期，要有心理准备

## 八、安全红线（必读）

- `state/session.json` 里是 `bot_token`，等同于登录态：**600 权限、原子写入、绝不进代码仓库、绝不发给任何人**。如需更高安全级别，可以用 OpenSSL + 口令把它加密存放（代价是机器重启后需手动输入口令才能恢复常驻）。
- **聊天内容必经腾讯服务器**：这是微信通道绕不开的，敏感信息、私事不要在微信 Bot 里聊。能接受"图方便"，就别指望"绝对隐私"。
- **封号风险评估**：这是腾讯官方开的通道，扫码授权是官方设计的流程，不是外挂也不是协议破解，是目前所有接微信的方案里风险最低的。但"零风险"没人敢打包票——微信风控规则随时可能收紧。降低风险的做法：只回复自己的消息、不群发、不做营销动作。
- 微信只会知道你在官方 ClawBot 通道上挂了一个 AI 机器人（协议自报 OpenClaw），**不知道背后是哪个模型**——除非回复内容里自报家门。想低调的话，让回复里不提模型名字就行。
- 微信界面不会显示任何 IP；你的 IP 属地还是按你手机的来。腾讯后台日志能看到接口调用来自哪台服务器 IP，但那只是日志，不会出现在微信界面上。

## 九、接受不了腾讯可见？替代方案

如果你和我一样，对"聊天内容被腾讯看到"这件事过不去，那微信通道就不适合你。替代方案：

- **Telegram Bot**：自己创建一个 Bot，消息只经过 Telegram 服务器。国内使用需要翻墙，但隐私边界清晰得多，收发消息、定时推送都更自由。
- **直接在 App 里用**：比如 Muse / ChatGPT 的官方 App，链路最短，适合聊正事。

一句话总结：**要"微信里免翻墙直连"，就接受腾讯可见；要"腾讯不可见"，就别走微信。** 两者不可兼得，选哪个看你的优先级。

## 结语

这套方案最大的价值在于它是**官方通道**：协议来自腾讯官方开源插件，扫码授权是微信官方文档里写明的流程，不用再去碰那些随时会死的野路子。代码层面唯一的"魔法"就是那几个缺了会静默失败的字段，照着上面的 `bridge.py` 写，一遍就能跑通。

如果你照着教程跑通了，或者踩了新的坑，欢迎留言交流。教程里的协议细节对照的是 `@tencent-weixin/openclaw-weixin` 2.4.9，将来腾讯升级版本，`channel_version` 和 `ClientVersion` 记得跟着改。

（本文协议细节对照官方源码验证，接口行为以腾讯服务器实际返回为准。）
