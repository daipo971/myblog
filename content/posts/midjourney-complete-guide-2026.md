---
title: "Midjourney V7完整教程 2026：从入门到精通的AI绘画实战指南"
date: 2026-07-21
description: "Midjourney V7完整使用教程，从注册订阅到高级提示词技巧，涵盖文生图、图生图、参数调节、风格参考等实战技巧"
summary: "Midjourney V7从零到精通完整教程，注册订阅、提示词技巧、参数调节、图生图、风格参考、V7新功能全覆盖"
tags: ["Midjourney", "AI绘画", "AI艺术", "图像生成", "设计工具", "AI教程", "创意工具"]
showtoc: true
---

## 这玩意真的值得学吗

先交代一下背景。

我大概是Midjourney V5刚出来那会儿入坑的。当时被朋友安利了一张图——用MJ生成的一个"赛博朋克东京雨夜"——那个氛围感说实话把我震住了。从V5开始一路用到V6再到现在的V7，算是见证了MJ这个工具从"能看"到"能用"再到"好用"的整个过程。

这么说吧，Midjourney这些年几乎每出一个大版本都能把同类工具拉开一个身位的差距。到V7这个版本，我觉得它已经不是"纯玩具"了——它真的能当生产力工具用了。

这篇文章没什么官腔，就是我实际用了这么久，总结出来的一份人话版教程。不管你是完全没用过的新手，还是已经在V6上玩了一段时间想升V7的老用户，应该都能找到点有用的东西。

## 注册和订阅：先过第一关

Midjourney最劝退人的地方不是贵——是它还得用Discord。

没错，2026年了，这个AI绘画天花板级的产品依然没有自己的网页版界面。你得先装Discord、注册账号、加MJ的服务器，然后在聊天框里发消息生图。整个流程对不熟悉Discord的人来说，第一印象就是：什么鬼？

具体步骤如下：

1. **注册Discord账号** — [discord.com](https://discord.com)，下载客户端或者用网页版都行
2. **加入Midjourney服务器** — 进官网 [midjourney.com](https://midjourney.com) 点"Join the Beta"，会跳转到Discord服务器
3. **找个频道开始** — 去 `#newbies-xxx` 频道，在聊天框输入 `/imagine prompt: 你的描述` 就能生图了

但说实话，在公共频道生图体验很一般——别人刷屏太快了，你的图一下就被冲走了。我强烈建议你花点钱订阅之后，在Discord里建一个自己的私人服务器，把Midjourney Bot拉进来，一个人安安静静地玩。

### 订阅方案选哪个

Midjourney现在的订阅分三档：

- **基础版 $10/月** — 200张图，个人尝鲜够了，但很快就用完了
- **标准版 $30/月** — 15小时快速模式，无限慢速模式。大部分人的选择
- **专业版 $60/月** — 30小时快速模式，可以生成商业用途图片，接商用单子的人必选
- **超级版 $120/月** — 60小时快速模式，适合工作室或者高频使用

我自己的建议是：如果你想认真学起来当工具用，直接上标准版。基础版那200张限额，你认真玩一个下午就没了。慢速模式等图等到怀疑人生。

PS：如果你是第一次买，建议先按月的买一个月试试水，别一上来就年付。Midjourney适合不适合你，用一个月就知道了。

需要提醒的是，Midjourney不是每月自动续费就行，你还得在Discord里用 `/subscribe` 指令来管理订阅状态，这点也挺奇葩的。

如果你还在纠结"要不要花钱"，我之前写过一篇[AI绘画工具横评](/posts/ai-image-generation-comparison-2026/)，把Midjourney、DALL-E、Stable Diffusion放在一起比过，可以看看再做决定。

## V7相比V6到底升级了什么

我是V6一出来就升了，当时的感觉是"比V5好，但没有质变"。但V7不一样——V7是第一个让我觉得"画质到了另一种水平"的版本。

**写实感大幅提升。** V7对人像皮肤质感、毛发细节、光影自然度的处理，比V6好了不是一星半点。以前V6出的图放大看有时候会有"油画感"或"塑料感"，V7在这方面的控制强了很多。特别是皮肤上的毛孔、头发丝的飘动细节，V7处理得非常自然。

**文字渲染终于能看了。** 以前Midjourney最被人吐槽的一点就是——你让它在图上写字，它写出来的东西基本是乱码。V6虽然有所改善，但依然不稳定。V7在这方面提升了很多，虽然跟DALL-E 3比还是有差距，但至少可以输出一些简单的英文文字了。

**对象一致性增强。** V6时代最让人头疼的一个问题是：同一段prompt出四张图，四张图里同一个人的样子全不一样。V7引入了更强的特征保持能力，虽然还不能说做到完全一致（那个得靠后续的 --cref 参数），但相比V6已经是肉眼可见的进步了。

**--v 6.1 和 --v 7 共存。** 这个设计很聪明——如果你对V7的效果不满意，可以退回V6.1出图。毕竟V6已经迭代了好几个小版本，稳定性更高。V7在某些创意风格上的表现反而比V6激进，对于追求"稳"的用户来说，两个版本共存是个很好的过渡设计。

还有一个我特别喜欢的改进：V7的 --s 参数（风格化程度）效果更丰富了。调高 --s 值在V7上不会像V6那样导致过度扭曲，而是让画面更有艺术感。具体后面参数部分再细说。

## 基础提示词：结构化prompt公式

很多新手上来就是"a beautiful girl"或者"好看的山"，出来的图当然也好看不了。

Midjourney的prompt不是写作文，更像是一组描述性标签的组合。经过长期试错，我总结了一个好用的公式：

```
[主体描述] + [环境/场景] + [光线/氛围] + [构图] + [风格/媒介] + [参数]
```

举个例子：

```
/imagine prompt: a Japanese woman in her 30s with glasses, sitting in a cozy Tokyo cafe by the window, soft warm lighting from golden hour, close-up portrait, shot on Leica M6, cinematic --ar 3:2 --v 7
```

拆开来看：
- 主体：a Japanese woman in her 30s with glasses
- 场景：sitting in a cozy Tokyo cafe by the window
- 光线：soft warm lighting from golden hour
- 构图：close-up portrait
- 风格：shot on Leica M6, cinematic
- 参数：--ar 3:2 --v 7

这里有几个要点：

**Midjourney的prompt对形容词不太敏感。** 你写"extremely very beautifully rendered"这种叠词基本上没效果。它更吃具体的描述词——比如"misty"、"cinematic lighting"、"vintage tone"这种带明确指向性的词汇。

**多写质感关键词。** 比如"volumetric lighting"、"clean sharp focus"、"intricate details"、"textured"这类的词，比空洞的褒义词有用得多。

**场景描述越具体越好。** 不要写"a beautiful city"，写"a rain-slicked neon-lit Tokyo alleyway at midnight"。

**颜色和光线是最容易出效果的。** 加一个"golden hour"、一个"cool blue tones"、一个"dramatic side lighting"，质感能提升两个档次。

如果你对prompt工程感兴趣，我之前还写过一篇[AI提示词工程指南](/posts/ai-prompt-engineering-guide-2026/)，里面有很多通用技巧，虽然不全是针对MJ的，但思路一致。

## 核心参数详解

Midjourney的参数说多不多说少不少，但常用的一只手数得过来。

### --ar 宽高比

这个最简单也最常用。默认是1:1方形。

- `--ar 16:9` 横屏，适合壁纸和视频封面
- `--ar 3:2` 经典摄影比例
- `--ar 4:3` 显示器比例
- `--ar 2:3` 或 `--ar 9:16` 竖屏，适合手机壁纸和小红书封面

注意：宽高比太夸张（比如 --ar 1:4）容易让画面内容难以构图。MJ在处理超宽或超长比例时，经常在画面边缘露出奇怪的裁切痕迹。

### --s 风格化（Stylize）

V7默认 --s 100。范围是0到1000。

这个参数控制的是Midjourney"发挥创意"的程度。数值越低，MJ越忠实于你的prompt字面意思；数值越高，它越会天马行空地加滤镜、加细节、加艺术处理。

我的经验值：
- `--s 0`：完全忠实于prompt，但画面会比较"干"，适合需要精确控制的场景
- `--s 50-100`：默认值范围，适合大部分日常使用
- `--s 200-400`：画面变得更有艺术感，适合概念设计、幻想题材
- `--s 500-1000`：非常放飞，出来的图往往很有冲击力但可能偏离你的描述

在V7上，即使是高 --s 值，画面也不会像V6那样崩坏。这是V7的一大进步。

### --v 版本控制

- `--v 7` 用最新的V7模型
- `--v 6.1` 用回V6.1
- 不指定的话默认是V7

V7在写实场景上毫无悬念地碾压V6，但有些动画风格、插画风格的出图在V6.1上反而更稳定。我会根据题材来切换——需要真实感用V7，需要特定手绘风格回退到V6.1。

### --c 混乱度（Chaos）

范围0到100。默认是0。

数值越高，四张图的差异越大。这个参数适合用来"找灵感"——设一个较高的chaos值，出四张风格各异的图，看到喜欢的再细化。如果你心里已经有明确的目标了，就不要动这个参数，保持0就好。

### --no 排除元素

这个参数挺有用的。比如你生成人物图，不想出现帽子，就加上 `--no hat`。不过它的实际效果有时候不太稳定，我觉得还是直接在prompt里说清楚比用 --no 更靠谱。

还有一些进阶参数比如 `--iw`（图像权重）、`--stylize` 的老参数变体，后面讲到图生图的时候再细说。

## 图生图（Image Prompts）

文生图是基础，但真正好玩的是一图生图。MJ的图生图能力在V7上也有明显增强。

操作方式很简单：把一张图的URL放进prompt里就行。

```
/imagine prompt: https://example.com/your-image.jpg a fantasy castle in the sky, magical atmosphere --ar 16:9 --v 7
```

可以传你自己电脑上的图。MJ会基于这张图的风格、构图和色彩来生成新的图片。

**Image Weight（--iw）参数**控制原图影响程度。

在V7上，--iw 默认是1.0（等权重）。数值范围是0到2。

- `--iw 0.5`：原图影响较轻，MJ主要按你的prompt来
- `--iw 1.0`：默认，原图和prompt大约五五开
- `--iw 1.5`：强烈保留原图特征
- `--iw 2.0`：几乎完全基于原图风格微调

还有一个很实用的功能：**Blend（混合）**。用 `/blend` 命令可以融合两张或多张图片，生成结合它们特征的新图。这个功能做产品设计概念图特别好用——比如把一张产品图和一个场景图融合，不用再跑什么Stable Diffusion图生图流程。

## 风格参考（--sref）

这是一个让我从V6用到V7就回不去的功能。

简单说，`--sref` 就是"把你的风格借给我用"。你可以上传一张或者一组参考图，MJ会提取它们的风格特征（配色、笔触、氛围、光照逻辑），然后应用到新图的生成上。

用法：

```
/imagine prompt: a modern minimalist living room --sref https://example.com/style.jpg --ar 16:9 --v 7
```

这个功能在实际工作流里太有用了：

**做系列图。** 比如你给客户做一套品牌视觉物料，第一次设计出风格后，用了 --sref 就能把后续所有图的风格锁住，保持视觉一致性。

**学习风格。** 看到一张喜欢的图？把它作为 --sref 的参考图，MJ能解析出它的风格来。虽然做不到完全一模一样，但已经很接近了。

**多图风格参考。** `--sref` 可以接受多个URL（用空格分隔），MJ会自动综合这些图的风格。你可以给两张不同氛围的参考图，让MJ取它们的平均值——这个玩法挺有意思的。

## V7的人物和面部表现

V7一个非常大的改进是人像质量。

以前Midjourney生人物图，最大的槽点是"脸不行"。V5和V6早期版本经常出现诡异的面部表情、不自然的眼神、或者是"千人一面"的网红脸。到V7，这些人像问题虽然不能说完全解决，但改善非常明显。

V7的人像好处体现在：

- **皮肤质感写实。** 皮肤不再像蜡像了，能看到毛孔、细纹、雀斑这些细节
- **眼睛有神了。** 以前MJ的眼睛经常"死鱼眼"，V7处理的眼睛更有生命力
- **亚洲面孔表现变好。** 老版本MJ对亚洲面孔的还原一直被人吐槽（容易出混血感或者欧美化），V7明显改善了这个情况。如果你想要东亚人物形象，建议在prompt里加 "East Asian"、"Chinese" 这类明确的描述词
- **表情更自然。** 微笑、沉思、忧郁这些微妙表情，V7的还原比V6好很多

不过说实话，MJ在人物一致性问题（同一个角色在不同图里长相统一）上依然不如一些专攻人像的工具。如果你需要多张图里保持同一个人物的长相，需要用 --cref 参数（Character Reference）来锁定角色特征。

## MJ vs 其他工具

用MJ越久，越能感觉到它和其他工具之间的差异。

||Midjourney V7|DALL-E 3|Stable Diffusion XL / Flux|
|---|---|---|---|
|上手难度|中等（要学Discord）|低（ChatGPT内置）|高（要本地部署/云端）|
|审美上限|极高|中等|取决于模型|
|提示词精确度|中等|极高|中等|
|写实风格|最佳|良好|好（取决于模型）|
|价格|$10-120/月|$20/月（含ChatGPT）|免费-按需付费|
|商业化授权|Pro才可商用|默认可商用|开源，看模型许可|

我的个人排序：
- **追求极致视觉效果** → Midjourney V7
- **需要精确控制内容** → DALL-E 3（prompt理解力确实最强）
- **要完全掌控全部参数** → Stable Diffusion / Flux（但需要一定技术基础）
- **做短视频配图、小红书封面** → 上面随便一个都行，但MJ最出片

我之前写过一篇详细的[AI图片生成工具横评](/posts/ai-image-generation-comparison-2026/)，里面对比更细致，哪个工具适合什么场景写得比较清楚。

另外，如果你也在玩AI视频，可以看看我的[AI视频生成工具对比](/posts/ai-video-generation-comparison-2026/)，很多视频工具其实可以和MJ配合使用——先用MJ生成概念图，再丢进视频工具里动起来。

## 实战案例：从想法到成品

说了这么多理论，来个完整的实战流程。

**需求：** 给一篇博客文章生成封面图，主题是"未来城市中的智能家居"

**第一步：先在ChatGPT[（chatgpt.com）](https://chatgpt.com/)里构思prompt**

我会先跟[ChatGPT](https://chatgpt.com/)聊一下想法，让它帮我把需求转成结构化的prompt。有时候也会用[Claude](https://claude.ai/)来反复迭代prompt文案——它的长文本能力让这个过程特别顺畅。

**第二步：初稿生成**

```
/imagine prompt: a futuristic smart home living room, holographic interface floating in the center, floor-to-ceiling windows overlooking a neon-lit city skyline at dusk, warm amber interior lighting contrast with cool blue exterior city lights, ultra-realistic, photorealistic interior design photography, 8k --ar 16:9 --v 7 --s 200
```

出四张图，选一张最接近想法的。

**第三步：微调**

对选中的图按 U（放大）按钮，得到大图后按 Vary (Subtle) 或 Vary (Strong) 继续微调。如果想改构图，可以直接改prompt里的关键词重新生成。

**第四步：风格锁定**

这张图出来之后，如果后续还要做同一系列的其他配图，把它作为 --sref 参考图：

```
/imagine prompt: a futuristic smart kitchen with holographic recipe display --sref https://... --ar 16:9 --v 7
```

这样整个系列的视觉风格就统一了。

**第五步：后期处理**

MJ出图后，我一般会用其他工具做最后的处理：
- 如果需要去背景或者微调构图 → Photoshop Generative Fill
- 如果需要提升分辨率 → Topaz Gigapixel 或者 MJ自己的Upscale
- 如果需要调整色调 → 直接手机相册就能调了

整个流程走下来，从想法到成品封面图，大概15分钟左右。没有MJ之前，我得去图库找图、PS里改半天，至少要一两个小时。

## 写到最后

Midjourney V7是目前为止我个人认为对**大众用户最友好且出图质量最高**的AI绘画工具。虽然有Discord这种反人类的交互、价格也不便宜，但如果你真的需要高质感的AI图像，它依然是最值得投入的那个。

几个建议送给你：

1. **别贪便宜买基础版**，200张图根本不够玩，反而会打击你学习的动力
2. **prompt质量决定一切**，花时间学怎么写好prompt比折腾参数值一百倍
3. **结合其他工具使用**，MJ出图 + ChatGPT构思prompt + PS后期，这条链路目前是最舒服的
4. **多看图多练习**，你刷小红书、Pinterest的时候就可以想"这个风格怎么用MJ复现"，慢慢就熟练了

如果你想继续深入，可以看看：

- [AI图片生成工具横评：Midjourney、DALL-E、Stable Diffusion全面对比](/posts/ai-image-generation-comparison-2026/)
- [2026年最值得订阅的AI工具：这8个我每个月都在花钱](/posts/best-ai-subscriptions-2026/)
- [AI视频生成工具对比：Sora、Runway、可灵实测](/posts/ai-video-generation-comparison-2026/)

有啥问题欢迎在评论区留言，我平时刷博客的时间不多，但看到了就会回。如果想交流AI工具的用法，也可以去 [xinqiai.dpdns.org](https://xinqiai.dpdns.org) 找我。

Happy prompting 🎨
