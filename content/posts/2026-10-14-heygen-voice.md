---
title: "HeyGen 自研语音模型登顶 TTS 榜：短剧配音成本算到小数点后三位"
date: 2026-10-14T15:00:00+08:00
lastmod: 2026-10-14T15:00:00+08:00
draft: false
tags: ["快讯", "AI音频", "HeyGen"]
categories: ["AI工具实测"]
description: "HeyGen 10 月 9 日发布自研语音模型 HeyGen Voice，盲测登顶 Artificial Analysis TTS 榜（Elo 1201）。launch 价 $15/百万字符只到 10 月 31 日。"
---

10 月 9 日，做 AI 数字人的 HeyGen 发布了自研语音模型 **HeyGen Voice**，号称"不靠外部 TTS，自己从头训了一个"。上线 5 天，独立盲测榜单 Artificial Analysis 的 Controlled Voice TTS Arena 上它 Elo **1201 排第一**，压过了 Qwen 和 ElevenLabs。10 月 13 日又加了个 Turbo 版。

先说结论：**榜单是真的（独立盲测），价格是真的香（launch 半价到 10 月 31 日），但慢也是真的（40 字符/秒）**——给短剧配旁白正合适，拿去做实时对话就别想了。

## 跑分：盲测第一，含金量看怎么算

Artificial Analysis 的 TTS Arena 是盲测：听众不知道哪段是谁生成的，纯拼听感。HeyGen Voice 拿 1201 分第一，Qwen 和 ElevenLabs 的模型排后面。

这个第一有两层含金量：

- **正向**：盲测拼的是"像不像真人说话"——重音、情绪、停顿、节奏。HeyGen 本来就是做数字人起家的，强项正好是"表演感"，赢在这个维度不意外。
- **打折**：AA 的榜单主要反映英文听感。**中文表现目前没有独立验证**，HeyGen 通稿里也没单独提中文评测。中文短剧旁白能不能打，实测之前别下结论。

## 定价：launch 半价，10 月 31 日截止

| | HeyGen Voice | Qwen TTS | ElevenLabs v4 Turbo |
|---|---|---|---|
| 标准价 / 百万字符 | $30 | $19.3 | $40 |
| 当前价 | **$15（至 10-31）** | $19.3 | $40 |
| 生成速度 | ~40 字符/秒 | 更快 | 更快 |

$15 是 launch 期自动半价，10 月 31 日之后回到 $30——到时候它就是三家里最贵的。所以**薅羊毛窗口就是这半个月**。

## 算笔账：一集短剧旁白多少钱

拿我们《穿书恶女》Ep1 的 7 条旁白实测字数：

「夜宴之上，御赐琉璃盏碎了——而所有人都看向了我。」等 7 条，加起来约 **150 个汉字**。

- 按 launch 价 $15/百万字符：一集 ≈ **$0.0023，约 1.6 分人民币**
- 按标准价 $30/百万字符：一集 ≈ $0.0045，约 3 分钱

结论：**配音成本在短剧制作里可以直接忽略不计**。真正的成本是调音色、调情绪、试错重生成花的时间，不是按字符计的那点钱。

顺带一提，40 字符/秒的速度：150 字旁白生成要 ~4 秒。对配音这是"喝口水就好"的水平；但对实时语音助手，这是不可接受的延迟。HeyGen 自己也清楚这个定位——通稿主打的是创作者和营销视频场景，不是语音助手。

## 三个冷静点

1. **通稿数字别全信**：71.6% 小企业主拍了视频不敢发——这是 HeyGen 调查**自家用户**得出的；4000 万用户、2 亿美元 ARR、85% 财富 100 强——自报、未审计。独立第三方 alfw.ai 已经把这点挑明了。
2. **Voice Clone 专业版 $99/月**：想克隆自己的声音做专属旁白，得交 30 分钟到 3 小时的语音，还要本人同意。对短剧来说，用标准音色库大概率就够了，别急着上专业版。
3. **免费试用真实存在**：HeyGen 平台有永久免费档（每月 3 个积分、带水印、无需信用卡），Voice 模型已在平台内上线。想验证中文效果，**先拿免费额度跑一集旁白听听**，比看榜单靠谱。OpenRouter 上也有 `heygen/heygen-voice-1`（10 月 13 日上架），走 API 更灵活。

## 一句话

HeyGen Voice 是今年 TTS 圈最值得试的一次"免费午餐"：榜单第一有盲测背书，launch 半价到月底，中文短剧旁白一集成本不到一分钱。**别信通稿，信自己的耳朵**——免费额度先跑一集，行就趁半价囤，不行就当没来过。

---

*参考：HeyGen PR 通稿（PR Newswire, 10-09）、vibeleaderboard.ai 第三方细读、alfw.ai fact-check、Artificial Analysis、OpenRouter*

## 参考来源

- [HeyGen 官方：HeyGen Voice（英文）](https://www.heygen.com/heygen-voice)
- [HeyGen 官方博客：Voice Turbo（英文）](https://www.heygen.com/blog/heygen-voice-turbo)
- [AlphaSignal：HeyGen Voice 超过 ElevenLabs 和阿里登顶 TTS 榜（英文）](https://alphasignal.ai/news/heygen-voice-beats-elevenlabs-and-alibaba-to-top-tts-rankings)

## 相关阅读

- [AI语音克隆与TTS工具对比：ElevenLabs、Fish Audio、Azure、CosyVoice](/posts/ai-voice-clone-tts-tools-2026/)
- [Gemini App 上线 Task 模式：Spark agent 收进主 App，任务后台一直跑](/posts/2026-10-14-gemini-task-mode/)
- 更多「AI工具实测」文章：[/categories/ai工具实测/](/categories/ai工具实测/)
