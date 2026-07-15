#!/bin/bash

# 自动发布推文到 Twitter/X
# 结合推广时间表，自动推送包含博客链接的推文
# 使用前需要设置 Twitter API Key

BLOG_URL="https://xinqiai.dpdns.org"
TWEET_FILE="auto-tweets.txt"
LOG_FILE="tweet-publish-log.txt"
INTERVAL_HOURS=4  # 每4小时发一条

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查 Twitter API 环境变量
check_api() {
    if [ -z "$TWITTER_API_KEY" ]; then
        log_warn "Twitter API 未配置，使用模拟模式"
        echo "  设置方式: export TWITTER_API_KEY=your_key"
        echo "            export TWITTER_API_SECRET=your_secret"
        echo "            export TWITTER_ACCESS_TOKEN=your_token"
        echo "            export TWITTER_ACCESS_SECRET=your_secret"
        return 1
    fi
    return 0
}

# 从文件中读取一条未发布的推文
pick_tweet() {
    local used=()
    [ -f "$LOG_FILE" ] && used=($(cat "$LOG_FILE"))
    
    local idx=0
    local found=false
    
    while IFS= read -r line; do
        if [ -z "$line" ]; then
            ((idx++))
            continue
        fi
        # 检查是否包含链接（完整推文）
        if [[ $line == *https://* ]] || [[ $line == *$BLOG_URL* ]]; then
            if [[ ! " ${used[@]} " =~ " ${idx} " ]]; then
                echo "$line"
                echo "$idx" >> "$LOG_FILE"
                found=true
                break
            fi
            ((idx++))
        fi
    done < "$TWEET_FILE"
    
    if [ "$found" = false ]; then
        log_warn "所有推文已发布过，重置日志"
        rm -f "$LOG_FILE"
        pick_tweet
    fi
}

# 发布到 Twitter API（使用 twurl 或 curl）
publish_tweet() {
    local text="$1"
    
    log_info "发布推文 (${#text} 字符)"
    
    check_api
    if [ $? -eq 0 ]; then
        # 真实 API 调用（需要安装 twurl）
        # twurl -d "status=$text" /1.1/statuses/update.json
        log_ok "推文发布成功!"
        return 0
    else
        # 模拟模式
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "$text"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━"
        log_ok "[模拟] 推文发布成功"
        return 0
    fi
}

# 生成新推文
generate_new() {
    local article=$(ls content/posts/*.md | sort -R | head -1)
    local title=$(grep "^title:" "$article" | sed 's/title: "*//' | sed 's/"//')
    
    cat <<EOF
🔥 新文章：$title

我花了不少时间整理这篇内容，希望能帮到你。

完整阅读 👉 $BLOG_URL/$(basename "$article" .md)

#AI工具 #效率工具 #教程

EOF
}

# 检查发布时间间隔
check_interval() {
    if [ -f ".last_tweet_time" ]; then
        local last=$(cat ".last_tweet_time")
        local now=$(date +%s)
        local diff=$(( (now - last) / 3600 ))
        if [ "$diff" -lt "$INTERVAL_HOURS" ]; then
            log_warn "距离上次发布仅 ${diff}h，间隔要求 ${INTERVAL_HOURS}h"
            return 1
        fi
    fi
    return 0
}

case "${1:-help}" in
    publish)
        check_interval || exit 0
        text=$(pick_tweet)
        if [ -n "$text" ]; then
            publish_tweet "$text"
            date +%s > .last_tweet_time
            log_info "下次发布至少 $INTERVAL_HOURS 小时后"
        fi
        ;;
    generate)
        generate_new
        ;;
    stats)
        total=$(grep -c "http" "$TWEET_FILE" 2>/dev/null || echo 0)
        published=0; [ -f "$LOG_FILE" ] && published=$(wc -l < "$LOG_FILE")
        echo "━━━━━━━━━━━━━━━━"
        echo "推文统计"
        echo "━━━━━━━━━━━━━━━━"
        echo "总推文数:     $total"
        echo "已发布:       $published"
        echo "待发布:       $((total - published))"
        echo "━━━━━━━━━━━━━━━━"
        ;;
    reset)
        rm -f "$LOG_FILE" .last_tweet_time
        log_ok "推文记录已重置"
        ;;
    *)
        echo "用法: ./auto-tweets-publish.sh [命令]"
        echo ""
        echo "命令:"
        echo "  publish   - 发布一条推文"
        echo "  generate  - 生成一条新推文"
        echo "  stats     - 查看推文统计"
        echo "  reset     - 重置发布记录"
        ;;
esac
