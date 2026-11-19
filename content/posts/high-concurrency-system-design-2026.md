---
title: "高并发系统设计实战：从单体到微服务的亿级流量架构演变"
date: 2026-07-20
lastmod: 2026-11-20T07:30:00+08:00
description: "深度解析高并发场景下的系统架构设计，包括缓存策略、数据库优化、消息队列、分布式事务、限流熔断，以及压测规划、可观测性与成本选型等核心实践，附常见问题解答"
summary: "高并发系统架构设计完整指南，覆盖Redis缓存架构、MySQL分库分表、Kafka消息队列、分布式事务Saga模式、Sentinel限流熔断等实战方案"
categories: ["建站与副业"]
tags: ["指南", "技术开发", "建站"]
showtoc: true
---


## 引言

大多数系统在起步阶段，都是一个单体应用 + 一台 MySQL，跑得好好的。然后某一天，用户在增长，QPS 从 100 涨到了 1000，系统开始不堪重负。

**系统的架构不是设计出来的，是演变出来的。** 每个架构决策背后都有一个性能瓶颈和用户投诉。本文模拟一个真实的电商系统，从 0 到 1 演变成一个支撑亿级流量的架构。

---

## 第一阶段：单体架构的黄金年代

### 初始架构

```
Nginx -> Tomcat(单体应用) -> MySQL
```

这个架构很简单：
- 一台 Nginx 做反向代理
- 一个 Spring Boot 单体应用
- 一台 MySQL 数据库

### 第一个性能瓶颈：数据库连接

当用户量开始增长，第一个倒下的一般是数据库。不是 MySQL 不够快，而是数据库连接数不够用。

#### 引入连接池

```yaml
# HikariCP 配置
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
```

连接池大小有个经典公式：

```
connections = ((core_count * 2) + effective_spindle_count)
```

但实际应用中，**数据库连接数一般不超过 CPU 核心数的 2 倍**。连接池太大的话，上下文切换的代价会超过并行带来的收益。

---

## 第二阶段：引入缓存层

### Redis 的出现时机

当你的数据库 QPS 超过 1000 时，就该上 Redis 了。一个简单的 Read-Write Through 模式：

```python
import redis
import json
from typing import Optional, Any
from functools import wraps
import hashlib

class CacheService:
    """
    多级缓存服务：本地缓存 -> Redis -> 数据库
    """

    def __init__(self, redis_client: redis.Redis):
        self.redis = redis_client
        self.local_cache = {}  # 进程内 LRU 缓存

    def cached(self, ttl: int = 300):
        """缓存装饰器"""
        def decorator(func):
            @wraps(func)
            async def wrapper(self, key: str, *args, **kwargs):
                # L1: 本地缓存
                cache_key = f"{func.__name__}:{key}"
                result = self.local_cache.get(cache_key)
                if result is not None:
                    return result

                # L2: Redis
                redis_key = f"cache:{func.__name__}:{key}"
                result = await self.redis.get(redis_key)
                if result is not None:
                    self.local_cache[cache_key] = json.loads(result)
                    return self.local_cache[cache_key]

                # L3: 数据库
                result = await func(self, key, *args, **kwargs)
                if result is not None:
                    await self.redis.setex(
                        redis_key,
                        ttl,
                        json.dumps(result),
                    )
                    self.local_cache[cache_key] = result

                return result
            return wrapper
        return decorator
```

### 缓存穿透/击穿/雪崩 解决方案

```python
class CacheShield:
    """缓存防护层"""

    def __init__(self, redis_client: redis.Redis):
        self.redis = redis_client

    async def get_with_bloom_filter(self, key: str) -> Optional[str]:
        """
        布隆过滤器防止缓存穿透
        - 穿透：请求不存在的数据，每次都打到 DB
        - 解决：用布隆过滤器过滤掉一定不存在的 key
        """
        if not self.bloom_filter.might_contain(key):
            return None  # 一定不存在，不查了

        return await self.redis.get(key)

    async def get_with_mutex(self, key: str) -> Optional[str]:
        """
        互斥锁防止缓存击穿
        - 击穿：热点 key 过期瞬间，大量请求打到 DB
        - 解决：同一时刻只允许一个请求重建缓存
        """
        value = await self.redis.get(key)
        if value is not None:
            return value

        # 分布式锁：只有一个线程能去查 DB
        lock_key = f"lock:rebuild:{key}"
        if await self.redis.set(lock_key, "1", nx=True, ex=10):
            try:
                value = await self._load_from_db(key)
                if value:
                    await self.redis.setex(key, 60, value)
                return value
            finally:
                await self.redis.delete(lock_key)
        else:
            # 获取锁失败，等 50ms 后重试
            await asyncio.sleep(0.05)
            return await self.get_with_mutex(key)

    async def set_with_random_ttl(self, key: str, value: str, base_ttl: int):
        """
        随机过期时间防止缓存雪崩
        - 雪崩：大量 key 同时过期，瞬间流量全打到 DB
        - 解决：过期时间加随机偏移
        """
        import random
        ttl = base_ttl + random.randint(0, base_ttl // 2)
        await self.redis.setex(key, ttl, value)
```

---

## 第三阶段：数据库优化

### 读写分离

```
主库(写) -> 从库1(读)、从库2(读)
```

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker
from contextlib import contextmanager
import random

class DatabaseRouter:
    """数据库读写分离路由"""

    def __init__(self):
        self.write_engine = create_engine(
            "mysql+pymysql://user:pass@master:3306/db",
            pool_size=10,
            max_overflow=20,
        )
        self.read_engines = [
            create_engine(f"mysql+pymysql://user:pass@slave{i}:3306/db")
            for i in range(2)
        ]
        self.WriteSession = sessionmaker(bind=self.write_engine)

    @contextmanager
    def read_session(self) -> Session:
        """获取读库连接（随机负载均衡）"""
        engine = random.choice(self.read_engines)
        Session = sessionmaker(bind=engine)
        session = Session()
        try:
            yield session
        finally:
            session.close()

    @contextmanager
    def write_session(self) -> Session:
        """获取写库连接"""
        session = self.WriteSession()
        try:
            yield session
            session.commit()
        except Exception:
            session.rollback()
            raise
        finally:
            session.close()
```

### 分库分表策略

当单表数据量超过 2000 万行时，MySQL 的写入性能开始显著下降。

#### Sharding 算法

```python
class ShardingStrategy:
    """一致性哈希分片策略"""

    def __init__(self, shard_count: int = 16):
        self.shard_count = shard_count
        self.virtual_nodes = 128
        self.ring = self._build_ring()

    def get_shard(self, user_id: str) -> int:
        """
        根据用户 ID 确定分片
        使用 user_id % shard_count 保证同一用户的请求落在同一分片
        """
        hash_val = hashlib.md5(user_id.encode()).hexdigest()
        return int(hash_val[:8], 16) % self.shard_count

    def get_table(self, order_id: str) -> int:
        """
        订单表按月分表
        单月数据量可控，方便归档清理
        """
        # order_id 格式: YYYYMMDD_xxxxx
        year_month = order_id[:6]
        return int(year_month)

# 使用示例
class OrderDAO:
    def __init__(self, sharding: ShardingStrategy):
        self.sharding = sharding
        self.shard_engines = {
            i: create_engine(f"mysql://.../db_shard_{i}")
            for i in range(sharding.shard_count)
        }

    def create_order(self, user_id: str, order: dict):
        shard = self.sharding.get_shard(user_id)
        table = f"orders_{self.sharding.get_table(order['order_id'])}"

        engine = self.shard_engines[shard]
        with engine.connect() as conn:
            conn.execute(
                f"INSERT INTO {table} (user_id, product_id, amount) VALUES (:uid, :pid, :amt)",
                uid=user_id,
                pid=order["product_id"],
                amt=order["amount"],
            )
```

---

## 第四阶段：引入消息队列

### 异步解耦

```
用户下单 -> 订单服务 -> Kafka -> 库存服务
                     -> Kafka -> 通知服务
                     -> Kafka -> 推荐服务
```

```python
from confluent_kafka import Producer, Consumer
import json
from dataclasses import dataclass
from typing import Callable

@dataclass
class KafkaConfig:
    bootstrap_servers: str = "localhost:9092"
    group_id: str = "order-service"
    auto_offset_reset: str = "earliest"

class EventBus:
    """基于 Kafka 的事件总线"""

    def __init__(self, config: KafkaConfig):
        self.config = config
        self._producer = None
        self._consumers: dict[str, Consumer] = {}

    @property
    def producer(self):
        if self._producer is None:
            self._producer = Producer({
                'bootstrap.servers': self.config.bootstrap_servers,
                'acks': 'all',  # 等待所有副本确认
                'retries': 3,
                'enable.idempotence': True,  # 幂等性保证
            })
        return self._producer

    def publish(self, topic: str, event: dict, key: str = None):
        """发布事件（异步）"""
        self.producer.produce(
            topic,
            key=key,
            value=json.dumps(event),
            callback=self._delivery_callback,
        )
        self.producer.poll(0)  # 触发回调

    def subscribe(self, topic: str, handler: Callable):
        """订阅事件"""

        consumer = Consumer({
            'bootstrap.servers': self.config.bootstrap_servers,
            'group.id': self.config.group_id,
            'auto.offset.reset': self.config.auto_offset_reset,
            'enable.auto.commit': False,  # 手动提交，保证 at-least-once
        })
        consumer.subscribe([topic])

        # 启动消费循环
        import threading
        thread = threading.Thread(
            target=self._consume_loop,
            args=(consumer, handler),
            daemon=True,
        )
        thread.start()

    def _consume_loop(self, consumer: Consumer, handler: Callable):
        while True:
            msg = consumer.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                print(f"Consumer error: {msg.error()}")
                continue

            try:
                event = json.loads(msg.value())
                handler(event)
                consumer.commit(msg)
            except Exception as e:
                print(f"Handle event error: {e}")
                # 不提交 offset，下次重试

    def _delivery_callback(self, err, msg):
        if err:
            print(f"Message delivery failed: {err}")
        else:
            print(f"Message delivered to {msg.topic()} [{msg.partition()}]")
```

---

## 第五阶段：服务拆分与微服务化

### 拆服务的方法论

什么时候该拆？一个信号：**当你修改一个功能需要改动多个模块时**。

```python
# 拆分后的订单服务
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import httpx

app = FastAPI(title="订单服务")

class OrderRequest(BaseModel):
    user_id: str
    product_id: str
    quantity: int

@app.post("/api/orders")
async def create_order(request: OrderRequest):
    # 1. 查询库存（调用库存服务）
    async with httpx.AsyncClient() as client:
        stock_resp = await client.get(
            f"http://inventory-service/api/stock/{request.product_id}"
        )
        if stock_resp.status_code != 200:
            raise HTTPException(status_code=502, detail="库存服务异常")

        stock = stock_resp.json()
        if stock["available"] < request.quantity:
            raise HTTPException(status_code=400, detail="库存不足")

        # 2. 扣减库存
        await client.post(
            f"http://inventory-service/api/stock/deduct",
            json={"product_id": request.product_id, "quantity": request.quantity},
        )

    # 3. 创建订单
    order_id = await create_order_in_db(request)

    # 4. 发送创建事件（异步）
    event_bus.publish("order.created", {
        "order_id": order_id,
        "user_id": request.user_id,
        "product_id": request.product_id,
        "quantity": request.quantity,
    })

    return {"order_id": order_id, "status": "created"}
```

---

## 第六阶段：分布式事务

### 分布式事务 Saga 模式

```python
from enum import Enum
from typing import List, Callable, Dict
import asyncio

class SagaStatus(Enum):
    PENDING = "pending"
    COMPLETED = "completed"
    COMPENSATING = "compensating"
    FAILED = "failed"

class SagaStep:
    """Saga 事务步骤"""

    def __init__(
        self,
        name: str,
        execute: Callable,
        compensate: Callable,
    ):
        self.name = name
        self.execute = execute
        self.compensate = compensate

class SagaOrchestrator:
    """
    Saga 编排器 - Choreography 模式

    每个步骤执行后，下一个步骤由事件驱动
    如果某步失败，自动补偿之前的所有步骤
    """

    def __init__(self):
        self.steps: List[SagaStep] = []
        self.status = SagaStatus.PENDING
        self.executed_steps: List[SagaStep] = []

    def add_step(self, step: SagaStep):
        self.steps.append(step)

    async def execute(self, context: Dict) -> Dict:
        """执行 Saga 事务"""
        try:
            for step in self.steps:
                print(f"执行步骤: {step.name}")
                result = await step.execute(context)
                self.executed_steps.append(step)
                context.update(result or {})

            self.status = SagaStatus.COMPLETED
            return {"status": "success", "context": context}

        except Exception as e:
            print(f"步骤 {step.name} 执行失败: {e}")
            self.status = SagaStatus.COMPENSATING
            await self._compensate(context)
            self.status = SagaStatus.FAILED
            return {"status": "failed", "error": str(e)}

    async def _compensate(self, context: Dict):
        """回滚已执行的步骤（逆序）"""
        print("开始补偿事务...")
        for step in reversed(self.executed_steps):
            try:
                print(f"补偿步骤: {step.name}")
                await step.compensate(context)
            except Exception as e:
                print(f"补偿步骤 {step.name} 失败: {e}")
                # 补偿失败需要人工介入
                # 发送告警通知运维

# 使用示例：订单创建 Saga
async def create_order_saga(user_id: str, product_id: str, quantity: int):
    saga = SagaOrchestrator()

    # 步骤1：创建订单
    async def execute_create_order(ctx):
        order_id = await order_service.create(ctx["user_id"], ctx["product_id"])
        ctx["order_id"] = order_id
        return ctx

    async def compensate_create_order(ctx):
        await order_service.cancel(ctx["order_id"])

    saga.add_step(SagaStep(
        name="创建订单",
        execute=execute_create_order,
        compensate=compensate_create_order,
    ))

    # 步骤2：扣减库存
    async def execute_deduct_stock(ctx):
        await inventory_service.deduct(ctx["product_id"], ctx["quantity"])
        return ctx

    async def compensate_deduct_stock(ctx):
        await inventory_service.restore(ctx["product_id"], ctx["quantity"])

    saga.add_step(SagaStep(
        name="扣减库存",
        execute=execute_deduct_stock,
        compensate=compensate_deduct_stock,
    ))

    # 步骤3：扣款
    async def execute_charge(ctx):
        await payment_service.charge(ctx["user_id"], ctx["amount"])
        return ctx

    async def compensate_charge(ctx):
        await payment_service.refund(ctx["user_id"], ctx["amount"])

    saga.add_step(SagaStep(
        name="用户扣款",
        execute=execute_charge,
        compensate=compensate_charge,
    ))

    return await saga.execute({
        "user_id": user_id,
        "product_id": product_id,
        "quantity": quantity,
    })
```

---

## 第七阶段：限流与熔断

### 令牌桶限流

```python
import time
import asyncio
from dataclasses import dataclass

@dataclass
class TokenBucket:
    """
    令牌桶限流器
    允许一定的突发流量（burst），但限制了平均速率
    """
    rate: float           # 每秒生成的令牌数
    capacity: int         # 桶容量（允许的突发流量）
    tokens: float = 0.0
    last_refill: float = 0.0

    def __post_init__(self):
        self.tokens = self.capacity
        self.last_refill = time.monotonic()

    async def acquire(self, tokens: int = 1) -> bool:
        """获取令牌"""
        self._refill()

        if self.tokens >= tokens:
            self.tokens -= tokens
            return True

        return False

    def _refill(self):
        now = time.monotonic()
        elapsed = now - self.last_refill
        self.tokens = min(self.capacity, self.tokens + elapsed * self.rate)
        self.last_refill = now


class SentinelGateway:
    """API 网关限流中间件"""

    def __init__(self):
        self.buckets: dict[str, TokenBucket] = {}

    def add_route(self, path: str, rate: int, burst: int):
        """注册路由限流规则"""
        self.buckets[path] = TokenBucket(rate=rate, capacity=burst)

    async def handle(self, path: str, handler):
        """限流中间件"""
        bucket = self.buckets.get(path)
        if bucket is None:
            return await handler()

        if not await bucket.acquire():
            raise HTTPException(
                status_code=429,
                detail="Too Many Requests - 请稍后重试",
                headers={"Retry-After": "5"},
            )

        return await handler()

# 使用示例
gateway = SentinelGateway()
gateway.add_route("/api/orders", rate=100, burst=200)   # 每秒100个请求，允许200突发
gateway.add_route("/api/search", rate=500, burst=800)    # 搜索接口更高频
```

### 熔断器模式

```python
from enum import Enum
from datetime import datetime, timedelta
import asyncio

class CircuitState(Enum):
    CLOSED = "closed"            # 正常状态
    OPEN = "open"               # 熔断状态，拒绝请求
    HALF_OPEN = "half_open"     # 半开状态，探测下游是否恢复

class CircuitBreaker:
    """
    熔断器实现

    状态流转：
    CLOSED -> (失败次数达标) -> OPEN -> (冷却时间过了) -> HALF_OPEN
    HALF_OPEN -> (探测成功) -> CLOSED
    HALF_OPEN -> (探测失败) -> OPEN
    """

    def __init__(
        self,
        failure_threshold: int = 5,       # 失败次数阈值
        timeout_seconds: int = 30,        # 冷却时间（秒）
        half_open_max_requests: int = 3,   # 半开状态允许的探测请求数
    ):
        self.failure_threshold = failure_threshold
        self.timeout = timedelta(seconds=timeout_seconds)
        self.half_open_max_requests = half_open_max_requests

        self.state = CircuitState.CLOSED
        self.failure_count = 0
        self.last_failure_time: datetime = None
        self.half_open_requests = 0

    async def call(self, func, *args, **kwargs):
        """通过熔断器调用下游服务"""
        if self.state == CircuitState.OPEN:
            if self._should_try_half_open():
                self.state = CircuitState.HALF_OPEN
                self.half_open_requests = 0
            else:
                raise CircuitBreakerOpenError("熔断器已打开，请稍后重试")

        if self.state == CircuitState.HALF_OPEN:
            if self.half_open_requests >= self.half_open_max_requests:
                raise CircuitBreakerOpenError("半开状态探测请求数已达上限")

            self.half_open_requests += 1

        try:
            result = await func(*args, **kwargs)
            self._on_success()
            return result
        except Exception as e:
            self._on_failure()
            raise

    def _on_success(self):
        """调用成功"""
        if self.state == CircuitState.HALF_OPEN:
            self.state = CircuitState.CLOSED
            self.failure_count = 0

    def _on_failure(self):
        """调用失败"""
        self.failure_count += 1
        self.last_failure_time = datetime.now()

        if (self.state == CircuitState.CLOSED
            and self.failure_count >= self.failure_threshold):
            self.state = CircuitState.OPEN

    def _should_try_half_open(self) -> bool:
        if self.last_failure_time is None:
            return True
        return datetime.now() - self.last_failure_time >= self.timeout

class CircuitBreakerOpenError(Exception):
    pass


# 使用示例
breaker = CircuitBreaker(failure_threshold=3, timeout_seconds=30)

@app.post("/api/orders")
async def create_order(request: OrderRequest):
    try:
        return await breaker.call(
            inventory_service.check_and_deduct,
            request.product_id,
            request.quantity,
        )
    except CircuitBreakerOpenError:
        # 熔断器打开，返回降级响应
        return {
            "status": "degraded",
            "message": "系统繁忙，订单已接收，请稍后查看状态",
            "order_id": await async_create_pending_order(request),
        }
```

---

## 第八阶段：异步非阻塞架构

### Python asyncio + FastAPI 的极致优化

```python
import asyncio
from concurrent.futures import ThreadPoolExecutor

class AsyncOptimizer:
    """
    异步优化器 - 避免同步阻塞

    关键原则：
    1. IO 密集用 async/await
    2. CPU 密集用 run_in_executor
    3. 数据库查询用异步驱动（asyncpg / aiomysql）
    """

    def __init__(self):
        self.cpu_executor = ThreadPoolExecutor(max_workers=4)

    async def fetch_user_orders(self, user_id: str) -> dict:
        """并行获取用户数据（多个下游服务同时调）"""
        # 同时调用三个无依赖的服务
        results = await asyncio.gather(
            order_service.get_orders(user_id),
            user_service.get_profile(user_id),
            recommendation_service.get_recommended(user_id),
            return_exceptions=True,  # 部分失败不影响其他
        )

        orders, profile, recommendations = results

        return {
            "user": profile if not isinstance(profile, Exception) else None,
            "orders": orders if not isinstance(orders, Exception) else [],
            "recommendations": recommendations if not isinstance(recommendations, Exception) else [],
        }

    async def compute_heavy_task(self, data: list) -> dict:
        """CPU 密集型任务转移到线程池"""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(
            self.cpu_executor,
            self._cpu_bound_algorithm,
            data,
        )

    def _cpu_bound_algorithm(self, data: list) -> dict:
        """CPU 密集型计算"""
        # 复杂的数据聚合、计算
        result = {}
        for item in data:
            # ... 复杂运算
            pass
        return result
```

---

## 第九部分：压测与容量规划——先算数，再扩容

> （2026-11-20 新增）

前面总结表里写的 QPS 上限，每一行后面都该加一句备注：**估计值**。同一套架构，换一批业务逻辑、换一批数据量，上限能差出几倍。自己系统的上限是多少，只能压出来，不能抄表。

压测不是上线前走个过场，它要回答三个具体问题：单实例安全承载多少 QPS、第一个瓶颈出现在哪里、峰值再翻一倍时哪一环先倒。回答不了这三个问题，扩容就是凭感觉加机器。

### 压什么、看什么

压测看四个数，缺一个都不完整：**QPS、延迟分位数、错误率、资源水位**。延迟只看平均值会骗人：平均 50ms 的接口，P99 可能是 2 秒，意味着一百个用户里就有一个在等两秒。大促真正伤口碑的，就是这 1% 的长尾。资源水位要同时看 CPU、内存、数据库连接数和慢查询，瓶颈常常不在应用层，而在连接池先被打满。

### 怎么做才有效

工具任选，k6、JMeter、wrk 都能用，关键是四条纪律。第一，压测环境与生产同配置，拿开发机压出来的数字没有参考价值。第二，**预热**：缓存冷启动时压出来的曲线，前半段全是失真，先跑几分钟热身再采样。第三，数据隔离：压测数据与生产数据分开，压测流量绝不直接打生产库。第四，读写都要压：只压读接口不压写接口，等于只测了一半系统，下单、支付这些写链路往往才是第一个倒下的。

### 容量怎么算

算法很朴素：**所需实例数 ≈ 峰值 QPS ÷ 单实例安全 QPS**，再留出约 30% 的余量。单实例安全 QPS 取压测中错误率开始抬头、P99 开始恶化之前的那个点，不要取极限值。连接池、线程池、带宽同理，都按峰值加余量算。余量不是浪费，是给突发流量和单机故障留的活路：一台机器挂了，剩下的机器要能接住它的流量，而不是跟着一起倒。

### 常见的三个坑

一是压测把第三方依赖打爆了：短信、支付、对象存储都有配额和限流，压测前先确认配额，或者把第三方调用挡在 Mock 后面。二是大促前只压一次：压测结果的有效期很短，一次大的代码改动、一次缓存策略调整，都可能让旧结论作废，大促前要重新压一轮。三是把压测当成性能优化的终点：压测找到的瓶颈要一个一个修，修完再压，直到瓶颈移到可以接受的位置，或者移到改动成本最高的那一环。

---

## 第十部分：可观测性与故障演练——出问题时，先看到

> （2026-11-20 新增）

前面讲的限流、熔断、降级，都是出问题时的止血动作。但止血的前提是**先看到问题**：哪个接口慢了、哪台机器满了、哪条链路断了。没有可观测性，故障发现靠用户投诉，定位靠翻日志猜，恢复时间按小时计。

### 三大支柱，缺一不可

**指标**看趋势：Prometheus 采 CPU、内存、QPS、延迟、错误率，Grafana 做成大盘。指标回答的是“现在怎么样”，适合做告警。**日志**看细节：结构化日志，每条带上 trace_id，把一次请求经过的所有服务串起来；出了问题，先按 trace_id 把全链路日志捞出来，而不是逐台机器翻。**链路追踪**看全貌：OpenTelemetry 这类工具把一次请求在各服务间的耗时画出来，慢在哪一段一目了然。三个各有分工，只搭指标不搭追踪，定位还是靠猜；只记日志不做指标，故障发现还是靠用户。

### 告警设在哪条线

告警的黄金信号就四个：**延迟、流量、错误、饱和度**。阈值举例（示例值，按自己业务调）：P99 延迟连续 5 分钟超过 800ms 告警；错误率超过 1% 告警；CPU 或内存持续超过 80% 告警；数据库连接池使用率超过 80% 告警。阈值宁可先设得宽一点再慢慢收紧，也不要一上来就设得很严——告警风暴的结局永远是没人再看告警。每次故障复盘时，顺手补一条规则：如果这次故障本可以被某个指标提前发现，就把这条告警加上。

### 故障演练：每月杀一次自己的系统

演练清单不用复杂，四个场景就够：杀掉一个应用节点，看流量能不能自动切走；断开 Redis，看降级逻辑是不是真生效，还是只在文档里生效；打满一块磁盘，看日志轮转和告警是不是及时；把一个依赖的响应时间人为拉长十倍，看超时和熔断是不是按预期触发。演练每月一次，每次只做一个场景，做完写一页复盘：预期是什么、实际是什么、差在哪里、下次改什么。演练的价值不在“通过”，而在把那些只在纸面上的容灾设计，变成真的跑通过的路径。

### 值班手册：先止血，再定位

故障处理的第一步永远是止血：限流、降级、切流量、回滚，哪一步最快见效就先做哪一步；定位原因排在止血之后。止血动作要能一键执行，写在值班手册第一页，不要等故障发生了才去翻代码找开关。手册里还要写清：谁有权做降级决策、什么情况下可以直接做不需要等审批、事后复盘的负责人是谁。很多小团队的故障拖成大事故，差的不是技术，是故障当时没人敢拍板。

---

## 第十一部分：国内落地与成本——自建还是云托管

> （2026-11-20 新增）

前面八个阶段用的都是开源组件名：Redis、MySQL、Kafka。落到国内，第一件事是决定：**自己搭，还是用云厂商的托管版**。没有标准答案，只有算账。

### 托管版对照

主流云厂商都有对应产品：Redis 对应云数据库 Redis 版，MySQL 对应云数据库 RDS，Kafka 对应消息队列 Kafka 版，对象存储直接用 OSS/COS 这类服务。功能上托管版基本覆盖了自建 90% 的常用能力，区别在三点：一是价格按量计费，具体以官网为准，本文不写具体价；二是运维责任转移了，备份、主从切换、版本升级由厂商做；三是某些高级配置和插件可能受限，用之前先核对功能清单，确认自己要用的特性在托管版里有。

### 对外服务先过备案

只要网站对公网开放，就要做 ICP 备案；域名也要完成实名认证。备案期间域名无法对外提供访问，排期要留进上线计划里，不要等到上线前一天才想起备案。个人博客和公司主体备案材料不同，按云厂商备案页面的清单准备，一次备齐比反复补材料快得多。

### 成本的三个杠杆

第一个杠杆是**缓存命中率**：命中率每提高一档，数据库的读压力就下降一档，数据库实例就可以小一号，这是性价比最高的降本手段。第二个杠杆是**异步化削峰**：把非实时的写操作丢进消息队列，峰值时需要的应用实例数直接下降，机器按峰值买单，峰值下来了账单就下来了。第三个杠杆是**冷热分离**：热数据放 Redis 和 MySQL，冷数据归档到对象存储，数据库不用为很少被访问的历史数据一直付高价。以上都是经验判断，具体能省多少，取决于业务的读写比例和数据冷热分布，以实测为准。

### 小团队怎么选

建议很直接：**先用托管服务，把时间花在业务上**。一个三五人的团队，自己搭一套高可用的 Redis 集群加 Kafka 集群，再配上值班，成本远高于托管费。等到日活过万、账单大到值得专门优化，或者有合规要求必须自建时，再评估把哪一层收回来自己搭。自建的成本不只是机器，还有值班、升级、故障处理的人力，算账时要把这一并算进去。


---

## 架构演变总结

| 阶段 | 核心问题 | 解决方案 | QPS 上限 |
|------|---------|---------|---------|
| 单体 | 数据库连接不足 | 连接池(HikariCP) | ~500 |
| 缓存 | 数据库压力太大 | Redis多级缓存 | ~5,000 |
| 数据库 | 单表数据太大 | 读写分离 + 分库分表 | ~20,000 |
| 消息队列 | 同步链路太长 | Kafka异步解耦 | ~50,000 |
| 微服务 | 代码耦合严重 | 服务拆分 + RPC | ~200,000 |
| 分布式事务 | 跨服务数据一致 | Saga补偿模式 | - |
| 限流熔断 | 雪崩效应 | Sentinel + Hystrix | - |
| 异步架构 | CPU/IO阻塞 | asyncio + 协程 | ~500,000 |

---

## 终极原则

1. **不要过早优化**：QPS 不到 1000 时，你的瓶颈大概率在你自己的代码，不在架构
2. **先监控后优化**：没有监控数据的优化就是盲人摸象
3. **缓存是第一优先级**：80% 的性能问题加个 Redis 就解决了
4. **数据一致性 > 性能**：分布式系统下，不能拿业务正确性去换 10ms 的延迟提升
5. **架构是长出来的**：不要在一开始就设计一个"完美的架构"，跟着业务的节奏一步一步来

---

*声明：本文中的性能数据是基于常见硬件配置的估计值，实际表现会因具体业务逻辑、数据规模和硬件环境而异。架构设计需要结合实际情况进行决策。*

---

## 常见问题

**QPS 还不到 1000，需要微服务吗？** 不需要。单体加 Redis、加读写分离就能撑到几千 QPS。微服务解决的是团队协作和代码耦合问题，不是性能问题；QPS 不到 1000 就拆服务，得到的是一堆分布式事务和排查难度，没有性能收益。

**缓存和数据库不一致怎么办？** 先接受一个前提：强一致和缓存很难兼得，绝大多数业务用最终一致就够了。做法是先更新数据库、再删除缓存，删除失败时用延迟双删补一次；读请求先查缓存、没有再查库。关键场景（如下单扣库存）直接读库，不走缓存。

**分库分表之后，跨库查询怎么办？** 尽量不要有跨库查询。拆之前先把查询模式想清楚：按用户维度的查询走用户分片键，按订单维度的查询走订单分片；必须跨库的，用冗余字段、宽表或者搜索引擎做查询层，不要在业务代码里写跨库 join。

**一个人维护的项目，怎么落地这套架构？** 从单体加 Redis 加托管数据库起步，只做当前瓶颈需要的那一步。QPS 上不去先加缓存，单表太大再读写分离，链路太长再上消息队列。架构是跟着瓶颈长出来的，不是照着八个阶段一次搭完的。

---

## 核验与更新记录

- 核对日期：2026-11-20
- 本次更新：新增第九部分（压测与容量规划）、第十部分（可观测性与故障演练）、第十一部分（国内落地与成本）与常见问题四问；正文（去代码块）从约 900 字增至约 3700 字；标题、日期、网址、分类与标签未动。
- 官方来源：托管服务对应关系以各云厂商官网产品页为准，本文未引用具体价格；k6、JMeter、Prometheus、Grafana、OpenTelemetry 均为开源项目，以各自官网文档为准。
- 经验标注：表中 QPS 上限、告警阈值示例、30% 容量余量、缓存命中率与成本的关系均为经验估计值，不同业务实测结果会不同；压测结论以自己环境的实测为准。

## 相关阅读

- [Rust 指令编程实战：从新手到精通的完整路线图](/posts/rust-programming-complete-guide-2026/)
- [LLM 应用后端开发实战：构建生产级 AI 应用的工程实践](/posts/llm-backend-engineering-2026/)
- [2026年AI内容营销策略：从内容创作到流量转化的完整指南](/posts/ai-content-strategy-2026/)
- 更多「建站与副业」文章：[/categories/建站与副业/](/categories/建站与副业/)
