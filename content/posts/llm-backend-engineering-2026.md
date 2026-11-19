---
title: "LLM 应用后端开发实战：构建生产级 AI 应用的工程实践"
date: 2026-07-20
lastmod: 2026-11-19T18:00:00+08:00
description: "深入讲解如何从工程角度构建生产级LLM应用，包括RAG架构、流式响应、Token管理、错误处理、成本优化等核心工程实践"
summary: "LLM应用后端开发完整指南，深度解析RAG检索增强生成、流式处理(SSE/WebSocket)、Token管理与成本控制、Prompt版本管理、并发限流等工程实践"
categories: ["建站与副业"]
tags: ["指南", "技术开发", "API"]
showtoc: true
---


## 引言

2026年，LLM 已经从"玩具"变成了"工具"。但这中间有个巨大的鸿沟——**你写的 LangChain Demo 和真正上线能用的 AI 应用，中间隔着至少一个阿里云。** 这篇文章不讲 Prompt Engineering 技巧，不讲哪个模型更强，而是从后端工程师的角度，系统讲解构建生产级 LLM 应用需要解决的那些"脏活累活"。

---

## 第一部分：RAG 架构——不仅仅是"检索+生成"

### 1.1 RAG 的核心问题

RAG (Retrieval-Augmented Generation) 是目前最主流的 LLM 应用架构。简单说就是：**先检索相关文档，再让 LLM 基于文档生成答案。**

但 RAG 从 Demo 到生产环境的距离比你想象的远得多。

### 1.2 文档分块策略

很多人上来就用 LangChain 的 `RecursiveCharacterTextSplitter`，chunk_size=1000，overlap=200。这在 Demo 阶段可以，但到了生产环境，你需要考虑：

```python
# 生产级文档分块策略
from abc import ABC, abstractmethod
from typing import List, Dict, Optional
from dataclasses import dataclass
import hashlib

@dataclass
class DocumentChunk:
    """文档块数据结构"""
    chunk_id: str
    text: str
    metadata: Dict
    source_document_id: str
    chunk_index: int
    prev_chunk_id: Optional[str] = None
    next_chunk_id: Optional[str] = None

class SemanticChunker(ABC):
    """语义分块器基类"""

    @abstractmethod
    def chunk(self, text: str, metadata: Dict) -> List[DocumentChunk]:
        pass

class HierarchicalChunker(SemanticChunker):
    """
    层级分块策略：
    1. 按文档结构分段（标题、章节）
    2. 在段落级别再进行语义分块
    3. 保留层级上下文
    """

    def chunk(self, text: str, metadata: Dict) -> List[DocumentChunk]:
        chunks = []
        # 第一层：按标题切分
        sections = self._split_by_headings(text)

        for section_idx, section in enumerate(sections):
            # 第二层：按段落语义切分
            section_chunks = self._split_by_semantic_boundaries(
                section["content"],
                heading=section["heading"]
            )

            for chunk_idx, chunk_text in enumerate(section_chunks):
                chunk_id = self._generate_chunk_id(
                    metadata.get("source"),
                    section_idx,
                    chunk_idx
                )

                chunks.append(DocumentChunk(
                    chunk_id=chunk_id,
                    text=chunk_text,
                    metadata={
                        **metadata,
                        "section_heading": section["heading"],
                        "section_index": section_idx,
                    },
                    source_document_id=metadata.get("source", ""),
                    chunk_index=len(chunks),
                ))

        # 建立前后链接
        self._link_chunks(chunks)
        return chunks

    def _generate_chunk_id(self, source: str, section: int, chunk: int) -> str:
        raw = f"{source}:{section}:{chunk}"
        return hashlib.md5(raw.encode()).hexdigest()[:16]

    def _link_chunks(self, chunks: List[DocumentChunk]):
        for i, chunk in enumerate(chunks):
            if i > 0:
                chunk.prev_chunk_id = chunks[i-1].chunk_id
            if i < len(chunks) - 1:
                chunk.next_chunk_id = chunks[i+1].chunk_id
```

### 1.3 多路检索 + 重排序

单一的向量检索在生产环境下有严重的局限性。**语义相似不等于答案相关。**

```python
from typing import List
import asyncio
import cohere

class HybridRetriever:
    """混合检索器：向量 + 关键词 + 重排序"""

    def __init__(
        self,
        vector_db,            # 向量数据库 (Pinecone / Weaviate / Qdrant)
        keyword_index,        # BM25 / Elasticsearch 关键词索引
        cohere_client,        # Cohere 重排序 API
    ):
        self.vector_db = vector_db
        self.keyword_index = keyword_index
        self.cohere = cohere_client

    async def retrieve(
        self,
        query: str,
        top_k: int = 10,
        rerank_top_k: int = 5,
    ) -> List[DocumentChunk]:
        # 第一阶段：并行多路召回
        vector_hits, keyword_hits = await asyncio.gather(
            self._vector_search(query, top_k=top_k * 2),
            self._keyword_search(query, top_k=top_k * 2),
        )

        # 第二阶段：融合去重
        all_candidates = self._reciprocal_rank_fusion(
            [vector_hits, keyword_hits],
            k=60  # RRF 系数，经验值
        )

        # 第三阶段：语义重排序
        reranked = await self._rerank(
            query,
            all_candidates,
            top_n=rerank_top_k
        )

        # 第四阶段：补齐上下文窗口
        return self._expand_context_windows(reranked)

    async def _vector_search(self, query: str, top_k: int):
        # 向量检索（语义相似度）
        embedding = await self._embed(query)
        results = await self.vector_db.query(
            vector=embedding,
            top_k=top_k,
            include_metadata=True,
        )
        return [{"chunk": r.metadata, "score": r.score} for r in results]

    async def _keyword_search(self, query: str, top_k: int):
        # 关键词检索（精确匹配）
        results = await self.keyword_index.search(
            query=query,
            top_k=top_k,
        )
        return [{"chunk": r.document, "score": r.score} for r in results]

    def _reciprocal_rank_fusion(
        self,
        result_lists: List[List],
        k: int = 60,
    ) -> List:
        """
        RRF 融合算法：
        score(d) = Σ 1 / (k + rank_i(d))

        相比简单的分数加权，RRF 不需要归一化不同检索源的分数
        """
        scores = {}
        for results in result_lists:
            for rank, item in enumerate(results):
                doc_id = item["chunk"]["chunk_id"]
                scores[doc_id] = scores.get(doc_id, 0) + 1 / (k + rank + 1)

        return sorted(scores.items(), key=lambda x: x[1], reverse=True)

    async def _rerank(self, query: str, docs: List, top_n: int):
        """Cohere Rerank API：语义重排序"""
        response = await self.cohere.rerank(
            query=query,
            documents=[d["chunk"]["text"] for d in docs],
            top_n=top_n,
            model="rerank-english-v3.0",
        )
        return [docs[r.index] for r in response.results]
```

---

## 第二部分：流式处理架构

### 2.1 为什么需要流式（SSE）？

用户的注意力是有限的。一个用户愿意等的时长大约在 **2-3 秒**，超过这个时间体验就差很多。流式响应让 LLM 可以在生成第一个 token 时就开始返回，降低感知延迟。

### 2.2 FastAPI SSE 实现

```python
from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse
from typing import AsyncGenerator, Optional
import json
import asyncio
import tiktoken
from datetime import datetime

app = FastAPI()

class StreamingLLMService:
    """生产级流式 LLM 服务"""

    def __init__(self, model: str = "claude-sonnet-4-20250514"):
        self.model = model
        self.tokenizer = tiktoken.get_encoding("cl100k_base")

    async def stream_chat(
        self,
        messages: list,
        max_tokens: int = 4096,
        temperature: float = 0.7,
    ) -> AsyncGenerator[str, None]:
        """
        流式生成，每个事件包含完整的状态信息
        事件格式: data: {"type": "...", "content": "...", "finish_reason": null, "usage": {...}}
        """
        try:
            # 发送开始事件
            yield self._format_sse_event({
                "type": "message_start",
                "model": self.model,
                "timestamp": datetime.now().isoformat(),
            })

            # 模拟流式生成（实际接入 Anthropic / OpenAI API）
            async with self._create_stream(messages, max_tokens, temperature) as stream:
                accumulated_content = ""
                token_count = 0

                async for chunk in stream:
                    if chunk.type == "content_block_delta":
                        text = chunk.delta.text
                        accumulated_content += text
                        token_count += len(self.tokenizer.encode(text))

                        yield self._format_sse_event({
                            "type": "content_block_delta",
                            "content": text,
                            "accumulated": accumulated_content,
                            "token_count": token_count,
                        })

                    elif chunk.type == "content_block_stop":
                        yield self._format_sse_event({
                            "type": "message_stop",
                            "finish_reason": chunk.delta.stop_reason,
                            "usage": {
                                "input_tokens": chunk.usage.input_tokens,
                                "output_tokens": chunk.usage.output_tokens,
                            },
                            "full_content": accumulated_content,
                        })

        except Exception as e:
            yield self._format_sse_event({
                "type": "error",
                "error": str(e),
                "error_type": type(e).__name__,
            })

    def _format_sse_event(self, data: dict) -> str:
        return f"data: {json.dumps(data, ensure_ascii=False)}\n\n"

    async def _create_stream(self, messages, max_tokens, temperature):
        """创建到 LLM API 的流式连接（实际实现）"""
        # 这里接入实际的 Anthropic/OpenAI API
        # 示例使用 anthropic-python SDK
        import anthropic
        client = anthropic.AsyncAnthropic()
        return await client.messages.create(
            model=self.model,
            max_tokens=max_tokens,
            messages=messages,
            stream=True,
        )


@app.post("/api/chat/stream")
async def chat_stream(request: Request):
    """流式聊天端点"""
    body = await request.json()
    messages = body["messages"]

    service = StreamingLLMService()

    return StreamingResponse(
        service.stream_chat(messages),
        media_type="text/event-stream",
        headers={
            "Cache-Control": "no-cache",
            "Connection": "keep-alive",
            "X-Accel-Buffering": "no",  # Nginx 关闭缓冲
        },
    )
```

### 2.3 前端消费 SSE

```javascript
// 前端消费流式响应
async function streamChat(messages) {
  const response = await fetch('/api/chat/stream', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ messages }),
  });

  const reader = response.body.getReader();
  const decoder = new TextDecoder();
  let buffer = '';

  while (true) {
    const { done, value } = await reader.read();
    if (done) break;

    buffer += decoder.decode(value, { stream: true });
    const events = buffer.split('\n\n');
    buffer = events.pop(); // 最后一个可能不完整

    for (const event of events) {
      if (event.startsWith('data: ')) {
        const data = JSON.parse(event.slice(6));

        switch (data.type) {
          case 'content_block_delta':
            onToken(data.content);  // 实时渲染每个 token
            break;
          case 'message_stop':
            onComplete(data.full_content, data.usage);
            break;
          case 'error':
            onError(data.error);
            break;
        }
      }
    }
  }
}
```

---

## 第三部分：Token 管理与成本控制

### 3.1 Token 计数与预算

```python
from dataclasses import dataclass, field
from typing import List, Dict
import tiktoken
from enum import Enum

class TokenBudgetStrategy(Enum):
    STRICT = "strict"            # 严格限流
    GRADUAL = "gradual"         # 分级降级
    ADAPTIVE = "adaptive"       # 自适应调整

@dataclass
class TokenBudget:
    """Token 预算管理器"""

    daily_limit: int = 1_000_000        # 每日总预算
    per_request_limit: int = 100_000     # 单次请求上限
    user_daily_limit: int = 500_000      # 单用户每日限额

    strategy: TokenBudgetStrategy = TokenBudgetStrategy.ADAPTIVE

    _daily_used: int = 0
    _user_usage: Dict[str, int] = field(default_factory=dict)
    _encoder: tiktoken.Encoding = field(default_factory=lambda: tiktoken.get_encoding("cl100k_base"))

    def count_tokens(self, text: str) -> int:
        return len(self._encoder.encode(text))

    def count_messages(self, messages: List[dict]) -> int:
        """计算消息列表的 token 数"""
        total = 0
        for msg in messages:
            total += 4  # 每条消息的开销
            for key, value in msg.items():
                total += self.count_tokens(str(value))
        total += 2  # 回复的开销
        return total

    def check_budget(self, user_id: str, estimated_tokens: int) -> bool:
        """检查是否在预算内"""
        # 系统级别检查
        if self._daily_used + estimated_tokens > self.daily_limit:
            raise BudgetExceededError("系统每日 Token 预算已用完")

        # 用户级别检查
        user_used = self._user_usage.get(user_id, 0)
        if user_used + estimated_tokens > self.user_daily_limit:
            raise BudgetExceededError(f"用户 {user_id} 今日 Token 额度已用完")

        # 单次请求检查
        if estimated_tokens > self.per_request_limit:
            raise BudgetExceededError(
                f"单次请求 Token 数 ({estimated_tokens}) 超过上限 ({self.per_request_limit})"
            )

        return True

    def record_usage(self, user_id: str, tokens: int):
        """记录 Token 使用量"""
        self._daily_used += tokens
        self._user_usage[user_id] = self._user_usage.get(user_id, 0) + tokens


class BudgetExceededError(Exception):
    pass
```

### 3.2 智能降级策略

```python
class ModelRouter:
    """根据任务的复杂度自动选择合适的模型"""

    MODELS = {
        "simple": {
            "model": "claude-haiku-4-5-20251001",
            "cost_per_1k_input": 0.00025,
            "cost_per_1k_output": 0.00125,
        },
        "standard": {
            "model": "claude-sonnet-5",
            "cost_per_1k_input": 0.003,
            "cost_per_1k_output": 0.015,
        },
        "complex": {
            "model": "claude-opus-4-8",
            "cost_per_1k_input": 0.015,
            "cost_per_1k_output": 0.075,
        },
    }

    def route(self, task: str, context_length: int, budget: TokenBudget) -> str:
        """自动路由到合适的模型"""

        # 简单任务（分类、提取、改写）：用 Haiku
        if self._is_simple_task(task) and context_length < 4000:
            return self.MODELS["simple"]["model"]

        # 标准任务（问答、摘要、翻译）：用 Sonnet
        if not self._is_complex_task(task):
            return self.MODELS["standard"]["model"]

        # 复杂任务（推理、代码生成、分析）：用 Opus（有预算限制）
        if budget._daily_used < budget.daily_limit * 0.3:  # 前30%预算可以用
            return self.MODELS["complex"]["model"]

        # 预算紧张时降级
        return self.MODELS["standard"]["model"]

    def _is_simple_task(self, task: str) -> bool:
        simple_keywords = ["分类", "提取", "改写", "总结", "翻译"]
        return any(kw in task for kw in simple_keywords)

    def _is_complex_task(self, task: str) -> bool:
        complex_keywords = ["分析", "推理", "代码", "设计", "架构"]
        return any(kw in task for kw in complex_keywords)
```

---

## 第四部分：Prompt 版本管理

### 4.1 Prompt 即代码

```python
from dataclasses import dataclass
from typing import Dict, Optional
import yaml
from datetime import datetime

@dataclass
class PromptVersion:
    """Prompt 版本"""
    name: str
    version: str
    template: str
    variables: Dict[str, str]
    model: str
    parameters: Dict
    created_at: datetime
    updated_at: datetime
    performance_score: Optional[float] = None

class PromptRegistry:
    """Prompt 注册中心"""

    def __init__(self, storage_path: str = "./prompts"):
        self.storage_path = storage_path
        self._prompts: Dict[str, Dict[str, PromptVersion]] = {}

    def register(
        self,
        name: str,
        template: str,
        variables: Dict[str, str],
        model: str = "claude-sonnet-5",
        parameters: Dict = None,
    ) -> PromptVersion:
        """注册新的 Prompt 版本"""
        version = self._generate_version(name)
        prompt = PromptVersion(
            name=name,
            version=version,
            template=template,
            variables=variables,
            model=model,
            parameters=parameters or {"temperature": 0.7, "max_tokens": 4096},
            created_at=datetime.now(),
            updated_at=datetime.now(),
        )

        if name not in self._prompts:
            self._prompts[name] = {}
        self._prompts[name][version] = prompt

        # 持久化到文件系统
        self._save_to_file(prompt)
        return prompt

    def render(
        self,
        name: str,
        variables: Dict[str, str],
        version: str = "latest",
    ) -> str:
        """渲染 Prompt 模板"""
        prompt = self.get(name, version)
        return prompt.template.format(**variables)

    def get(self, name: str, version: str = "latest") -> PromptVersion:
        if name not in self._prompts:
            raise ValueError(f"Prompt '{name}' 不存在")

        if version == "latest":
            # 返回最新版本
            return max(
                self._prompts[name].values(),
                key=lambda p: p.created_at,
            )

        if version not in self._prompts[name]:
            raise ValueError(f"Prompt '{name}' 版本 '{version}' 不存在")

        return self._prompts[name][version]

    def _generate_version(self, name: str) -> str:
        if name not in self._prompts:
            return "v1.0.0"

        versions = list(self._prompts[name].keys())
        latest = max(versions)
        major, minor, patch = map(int, latest[1:].split("."))
        return f"v{major}.{minor}.{patch + 1}"

    def _save_to_file(self, prompt: PromptVersion):
        """持久化到 YAML 文件"""
        import os
        os.makedirs(self.storage_path, exist_ok=True)

        filepath = f"{self.storage_path}/{prompt.name}_{prompt.version}.yaml"
        with open(filepath, "w") as f:
            yaml.dump({
                "name": prompt.name,
                "version": prompt.version,
                "template": prompt.template,
                "variables": prompt.variables,
                "model": prompt.model,
                "parameters": prompt.parameters,
                "created_at": prompt.created_at.isoformat(),
            }, f, allow_unicode=True)
```

---

## 第五部分：并发限流与队列

```python
import asyncio
import time
from typing import Dict
from collections import defaultdict

class RateLimiter:
    """可配置的限流器"""

    def __init__(self):
        self._per_minute: Dict[str, list] = defaultdict(list)
        self._per_hour: Dict[str, list] = defaultdict(list)

    async def acquire(
        self,
        key: str,
        max_per_minute: int = 60,
        max_per_hour: int = 1000,
    ) -> bool:
        """获取执行许可"""
        now = time.time()
        self._cleanup(key, now)

        # 检查每分钟限额
        if len(self._per_minute[key]) >= max_per_minute:
            # 计算需要等待的时间
            wait_time = 60 - (now - self._per_minute[key][0])
            if wait_time > 0:
                await asyncio.sleep(wait_time)
                return await self.acquire(key, max_per_minute, max_per_hour)

        # 检查每小时限额
        if len(self._per_hour[key]) >= max_per_hour:
            raise RateLimitExceededError(f"Key {key} 每小时限额已用尽")

        self._per_minute[key].append(now)
        self._per_hour[key].append(now)
        return True

    def _cleanup(self, key: str, now: float):
        """清理过期记录"""
        self._per_minute[key] = [
            t for t in self._per_minute[key]
            if now - t < 60
        ]
        self._per_hour[key] = [
            t for t in self._per_hour[key]
            if now - t < 3600
        ]


class RequestQueue:
    """基于优先级的请求队列"""

    def __init__(self, max_concurrent: int = 5):
        self.max_concurrent = max_concurrent
        self._queue = asyncio.PriorityQueue()
        self._active_count = 0
        self._semaphore = asyncio.Semaphore(max_concurrent)

    async def enqueue(self, task, priority: int = 0):
        """
        入队并等待执行
        priority 越小优先级越高
        """
        future = asyncio.Future()
        await self._queue.put((priority, time.time(), task, future))

        # 触发处理
        asyncio.create_task(self._process())
        return await future

    async def _process(self):
        async with self._semaphore:
            if self._queue.empty():
                return

            priority, timestamp, task, future = await self._queue.get()
            try:
                result = await task()
                future.set_result(result)
            except Exception as e:
                future.set_exception(e)
            finally:
                self._queue.task_done()
```

---

## 第六部分：可观测性

### 6.1 LLM 调用的日志和指标

```python
import time
import structlog
from typing import Dict, Any
from contextlib import asynccontextmanager

logger = structlog.get_logger()

@asynccontextmanager
async def traced_llm_call(
    call_name: str,
    model: str,
    tags: Dict[str, str] = None,
):
    """
    LLM 调用的全链路追踪上下文管理器
    记录：耗时、Token 使用、错误、成功/失败率
    """
    start_time = time.monotonic()
    span_id = _generate_span_id()

    logger.info(
        "llm.call.start",
        span_id=span_id,
        call_name=call_name,
        model=model,
        tags=tags or {},
    )

    metrics = {
        "span_id": span_id,
        "input_tokens": 0,
        "output_tokens": 0,
        "total_cost": 0.0,
    }

    try:
        yield metrics
        # 成功
        elapsed_ms = (time.monotonic() - start_time) * 1000
        logger.info(
            "llm.call.success",
            span_id=span_id,
            duration_ms=elapsed_ms,
            input_tokens=metrics["input_tokens"],
            output_tokens=metrics["output_tokens"],
            cost_usd=metrics["total_cost"],
            tokens_per_second=metrics["output_tokens"] / (elapsed_ms / 1000),
        )

    except Exception as e:
        elapsed_ms = (time.monotonic() - start_time) * 1000
        logger.error(
            "llm.call.error",
            span_id=span_id,
            error=str(e),
            error_type=type(e).__name__,
            duration_ms=elapsed_ms,
        )
        raise


# 使用示例
async def generate_response(messages: list) -> str:
    async with traced_llm_call("chat.completion", "claude-sonnet-5") as metrics:
        response = await llm_client.messages.create(
            model="claude-sonnet-5",
            messages=messages,
        )
        metrics["input_tokens"] = response.usage.input_tokens
        metrics["output_tokens"] = response.usage.output_tokens
        return response.content[0].text
```

---

---

## 第七部分：错误处理与重试——先分清错，再决定重试

> （2026-11-19 新增）

上线后最常见的故障不是模型答得差，而是调用失败。重试之前先分清错误的种类，因为不是所有错误都能重试：能重试的只有三类——限流（429）、超时与网络断连、服务方临时错误（500/502/503）。参数错误（400）、认证失败（401/403）、内容被拒，这三类重试多少次结果都一样，只会白白烧钱和拖慢响应。

限流重试要用指数退避加随机抖动：第一次等 1 秒，第二次 2 秒，第三次 4 秒，每次再加 0 到 1 秒的随机量。固定间隔重试最容易踩的坑，是大量请求在同一时刻一起重试，把刚恢复的服务又打垮。重试次数设上限，一般 3 次；超过 3 次还没成功就直接走降级，不要无限重试。经验值：把退避参数和上限写进配置而不是写死在代码里，线上调参不用重新发版。

流式调用的中断要单独处理。SSE 断在中间，用户已经看到半截回答，这时整个重来体验最差。做法是：服务端按消息 ID 记录已生成的部分，重连后从断点续写；续不上就把已生成的内容原样保留，再补一句说明，而不是清空重写。前端也要处理这种情况：收到 error 事件先显示"正在重试"，不要直接把半截内容清掉。

幂等是另一个容易被忽略的点。扣费、写库、下单这类有副作用的操作，重试时必须带幂等键——同一个请求 ID 只执行一次。没有幂等键的重试，超时后到底执行了没有谁也不知道，账就对不上了。调用方在请求头或请求体里带一个客户端生成的唯一 ID，服务端按这个 ID 去重，这是生产环境的基本要求，不是可选优化。

最后是降级话术。所有重试都失败时，不要把"API 调用失败"这类技术报错直接甩给用户。准备三档降级：第一档换备用模型重试一次；第二档返回缓存过的相似答案并注明；第三档给一句能用的兜底回复加人工客服入口。三档都走不通，也要让用户知道发生了什么、什么时候能再试，而不是一个空白页。

---

## 第八部分：缓存与成本测算——先算账，再扩量

> （2026-11-19 新增）

Token 账要按"一次请求多少钱"来算，而不是按"一个月多少钱"来估。公式很简单：单次成本 = 输入 Token 数 × 输入单价 + 输出 Token 数 × 输出单价。先在小流量上跑一两百次真实请求，记下输入和输出 Token 的平均数，再乘以预期的日请求量，得到的才是可信的预算。直接按"每天一万次"拍脑袋估，误差经常在几倍以上。

省成本最有效的三招，按见效排序：第一是裁剪上下文。RAG 检索回来十段只用三段，剩下七段的 Token 全是浪费——重排序后只把真正用到的段落拼进提示词，输入 Token 常常能砍掉一半以上。第二是提示词缓存。系统提示词、固定指令这类每次都一样的内容，用模型服务商提供的缓存能力，只按首次全价、后续按缓存价计费，适合指令长、对话轮次多的场景。第三是语义缓存。用户问过的相似问题直接返回缓存答案，命中率取决于业务：客服类高频重复问题能命中三到四成，开放式创作类几乎命中不了，上线前先拿一周真实问题测命中率再决定做不做。

模型分档要和缓存一起看。简单任务走便宜档、复杂任务走强档，这个思路第三部分已经讲过；补充一点：分档的标准要定期复核。模型版本更新后，原来必须用强档的任务可能便宜档就能做好，每季度拿真实任务样本重新测一次分档效果，分档阈值跟着调。价格以各模型官方定价页为准，本文不写具体数字，因为定价变了文章不会自动跟着变。

成本失控时先看三张表：按用户排的用量表、按接口排的用量表、按时间排的用量表。绝大多数超支都是少数几个用户或某个接口在某天突然放量，定位到这三张表里的异常行，再决定是限流、降档还是找对方确认需求。没有分用户、分接口的用量统计，成本问题永远只能靠猜。

---

## 第九部分：国内落地三件实事

> （2026-11-19 新增）

第一件是接入渠道。国内开发者的现实是：境外模型官方 API 需要按官方要求完成注册和支付，流程走官方渠道，不要用来源不明的所谓中转或共享账号——账号归属不清，封号、丢数据、费用纠纷都没有申诉对象。能走官方直连就走官方直连；走不通的，优先看国产模型官方 API，同样的任务先在国产模型上测一轮效果，很多中文问答、摘要、分类任务国产模型已经够用，价格也按国内计价，更适合先跑起来。

第二件是选型方法。选国产模型替代时不要只看榜单分数，按三项实测：中文理解与表达、长上下文下的稳定性、按量计价的真实成本。拿自己业务里最难的二十个真实问题，三个候选模型各跑一遍，人工打分，分数结合单次成本一起看。榜单分数高但长上下文一拉就丢信息的模型，上线后返工的成本比省下的调用费贵得多。

第三件是数据合规。不要把含个人身份信息、未脱敏的业务数据直接发给境外模型；必须发时先脱敏，姓名、电话、证件号、地址这类字段能不发就不发。日志里也不要存完整的用户原文，只存脱敏后的摘要和用量指标，留存周期写进配置，到期清理。合规不是上线后再补的文档，是写第一行调用代码时就要有的习惯。

---

## 常见问题

**小团队从零上线，先做哪三件？** 先做流式响应、Token 预算和错误重试。这三件直接决定用户能不能忍、账会不会爆、挂了能不能自己恢复。RAG 重排序、语义缓存这些可以第二期再做。

**RAG 效果差，先查什么？** 先查检索回来的片段对不对，再查提示词拼得对不对，最后才怀疑模型。多数 RAG 效果差是检索召回了不相关的段落，或者把十段全塞进提示词把关键信息淹没了，换模型解决不了这两个问题。

**流式输出断在中间，用户看到半截怎么办？** 保留已生成的内容不断线重连续写，续不上就补一句说明。不要清空重写，也不要假装什么都没发生。

**成本突然翻倍，先看哪里？** 按用户、按接口、按时间三张用量表找异常行。先定位是哪类请求放量，再决定限流还是降档，不要先调全局预算。

---

## 总结

构建生产级 LLM 应用需要关注的远不止"调 API"：

| 层次 | 关注点 | 关键实践 |
|------|--------|---------|
| **检索层** | 文档分块、多路检索、重排序 | RRF 融合、层级分块、上下文扩展 |
| **服务层** | 流式处理、Token 管理、模型路由 | SSE、预算控制、智能降级 |
| **工程层** | Prompt 管理、限流、可观测性 | 版本控制、优先级队列、全链路追踪 |
| **容错层** | 错误分类、重试、降级（2026-11-19 新增） | 指数退避、幂等键、三档降级 |
| **成本层** | 缓存、成本测算（2026-11-19 新增） | 上下文裁剪、提示词缓存、用量分表 |
| **落地层** | 国内接入与数据合规（2026-11-19 新增） | 官方渠道、国产模型实测选型、脱敏 |

这些不是"高级技巧"，而是从 Demo 到生产环境的必修课。花时间把这些基础设施建设好，你的 LLM 应用才能真正稳定地服务用户。

---

*声明：本文中提到的各第三方服务的定价信息截至2026年7月，实际价格请以官方定价页面为准。2026-11-19 新增的第七至九部分与常见问题为工程经验总结，不含新的价格数据；原文代码中的模型名与价格为2026年7月原文，未改动。*

## 核验与更新记录

- 核对日期：2026-11-19
- 本次更新：新增第七部分（错误处理与重试）、第八部分（缓存与成本测算）、第九部分（国内落地三件实事）与常见问题四问；正文字数从约 640 字增至 1800 字以上；标题、日期、网址、分类与标签未动。
- 官方来源：各模型价格与接入方式以官方定价页与官方文档为准，本文未引用具体价格。
- 经验标注：重试次数上限 3 次、退避参数、缓存命中率区间为工程经验值，不同业务实测结果会不同。

## 相关阅读

- [实战：我用 AI + GitHub Actions 做了个全球疫情信息聚合站，开源、零成本](/posts/2026-10-07-plague-aggregator/)
- [Rust 指令编程实战：从新手到精通的完整路线图](/posts/rust-programming-complete-guide-2026/)
- [高并发系统设计实战：从单体到微服务的亿级流量架构演变](/posts/high-concurrency-system-design-2026/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
