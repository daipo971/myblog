#!/bin/bash

# ============================================
# 自动推特运营管理脚本 (修复版)
# 使用 OpenCLI 浏览器控制推特
# ============================================

BLOG_URL="https://xinqiai.dpdns.org"
TWEET_FILE="auto-tweets.txt"
LOG_FILE=".tweet_auto_log.json"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; RED='\033[0;31m'; NC='\033[0m'
log_info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 初始化日志
init_log() {
    if [ ! -f "$LOG_FILE" ]; then
        echo '{"published":[],"last_run":"","today_count":0}' > "$LOG_FILE"
    fi
}

# 获取今天已发布数量
get_today_count() {
    today=$(date +%Y-%m-%d)
    count=$(python3 -c "import json; d=json.load(open('$LOG_FILE')); print(d.get('today_count',0) if d.get('last_run','')=='$today' else 0)" 2>/dev/null || echo 0)
    echo $count
}

# 从auto-tweets.txt读取一条未发布的推文
pick_unpublished_tweet() {
    today=$(date +%Y-%m-%d)
    
    # 获取今日已发布的推文短摘要（前40字符）
    published_today=""
    if [ -f "$LOG_FILE" ]; then
        published_today=$(python3 -c "
import json
try:
    d = json.load(open('$LOG_FILE'))
    print(','.join(d.get('$today', [])))
except: print('')
" 2>/dev/null)
    fi
    
    current_tweet=""
    reading=false
    
    while IFS= read -r line; do
        # 跳过空行
        [ -z "$line" ] && continue
        
        if [[ "$line" == "---" ]]; then
            if [ "$reading" = true ] && [ -n "$current_tweet" ]; then
                # 检查摘要是否已发布
                summary="${current_tweet:0:40}"
                if ! echo "$published_today" | grep -q "$summary"; then
                    echo "$current_tweet"
                    return 0
                fi
                current_tweet=""
            fi
            reading=true
            continue
        fi
        
        if [ "$reading" = true ]; then
            if [ -z "$current_tweet" ]; then
                current_tweet="$line"
            else
                current_tweet="$current_tweet"$'\n'"$line"
            fi
        fi
    done < "$TWEET_FILE"
    
    # 最后一个
    if [ -n "$current_tweet" ]; then
        echo "$current_tweet"
        return 0
    fi
    
    return 1
}

# 获取热门话题生成推文
generate_hot_tweet() {
    log_info "获取推特热门趋势..."
    
    # 直接调用opencli，过滤掉警告
    trending_json=$(opencli twitter trending --format json --window background 2>/dev/null | sed '/^$/d' | grep -v "Warning:" | grep -v "Update available")
    
    hot_topics=$(echo "$trending_json" | python3 -c "
import json, sys
try:
    data = json.loads(sys.stdin.read())
    topics = []
    for item in data[:8]:
        t = item.get('topic','')
        if t and len(t) < 30:
            topics.append(t)
    print('|'.join(topics[:4]))
except Exception as e:
    pass
" 2>/dev/null)
    
    if [ -z "$hot_topics" ]; then
        log_warn "获取热门趋势失败，使用备用推文"
        pick_unpublished_tweet
        return
    fi
    
    log_info "当前热搜: $hot_topics"
    main_topic=$(echo "$hot_topics" | cut -d'|' -f1)
    
    # 随机选一篇文章
    articles=(content/posts/*.md)
    count=${#articles[@]}
    if [ $count -eq 0 ]; then pick_unpublished_tweet; return; fi
    ridx=$((RANDOM % count))
    article="${articles[$ridx]}"
    aname=$(basename "$article" .md)
    
    # 从文件提取标题
    title=$(grep "^title:" "$article" | head -1 | sed 's/title: "*//' | sed 's/"//' 2>/dev/null)
    [ -z "$title" ] && title="$aname"
    
    # 生成话题标签
    tags="#${main_topic//[^a-zA-Z0-9]/}" 
    [ -z "$tags" ] && tags="#AI工具"
    
    cat << TWEET_EOF
🔥 $main_topic 登上热搜！刚好我写了篇关于「$title」的详细评测

📌 核心内容：
• 实测体验与使用技巧
• 完整配置教程
• 省钱使用方案

完整阅读 👉 $BLOG_URL/posts/$aname/

$tags #AI工具 #技术分享
TWEET_EOF
}

# 发布推文
publish_tweet() {
    text="$1"
    log_info "发布推文 (${#text} 字符)..."
    
    result=$(opencli twitter post "$text" --window background --site-session persistent --keep-tab true 2>/dev/null)
    
    if echo "$result" | grep -q "success"; then
        tweet_url=$(echo "$result" | python3 -c "
import json,sys
try:
    d=json.load(sys.stdin)
    if isinstance(d,list): d=d[0]
    print(d.get('url',''))
except: print('')
" 2>/dev/null)
        
        # 记录到日志
        today=$(date +%Y-%m-%d)
        summary="${text:0:40}"
        python3 -c "
import json
d=json.load(open('$LOG_FILE'))
if '$today' not in d: d['$today']=[]
d['$today'].append('$summary')
d['last_run']='$today'
d['today_count']=len(d.get('$today',[]))
json.dump(d,open('$LOG_FILE','w'),indent=2)
" 2>/dev/null
        
        log_ok "发布成功! $tweet_url"
        return 0
    else
        log_error "发布失败"
        return 1
    fi
}

# 关注相关用户
follow_users() {
    log_info "关注AI领域用户..."
    keywords=("AI" "ChatGPT" "Claude" "人工智能" "编程")
    kw=${keywords[$((RANDOM % ${#keywords[@]}))]}
    
    result=$(opencli twitter search "$kw" --format json --window background 2>/dev/null)
    
    users=$(echo "$result" | python3 -c "
import json,sys
try:
    data=json.load(sys.stdin.read())
    seen=set()
    out=[]
    for item in data[:8]:
        a=item.get('author','').strip()
        if a and a != 'tangjia6688' and a not in seen:
            seen.add(a)
            out.append(a)
    print(','.join(out[:3]))
except: print('')
" 2>/dev/null)
    
    if [ -n "$users" ]; then
        opencli twitter follow-batch "$users" --window background &>/dev/null
        log_ok "已关注: $users"
    else
        log_warn "没有找到可关注的用户"
    fi
}

# 运营主函数
run_daily() {
    today=$(date +%Y-%m-%d)
    today_count=$(get_today_count)
    
    log_info "=================================="
    log_info "📅 运营日: $today"
    log_info "📊 今日已发: $today_count 条"
    log_info "=================================="
    
    # 最多发2条
    max=2
    [ $today_count -ge $max ] && { log_info "今日已达上限"; return 0; }
    
    # 第一条：热门话题推文
    log_info "生成热门话题推文..."
    hot_tweet=$(generate_hot_tweet)
    if [ -n "$hot_tweet" ]; then
        publish_tweet "$hot_tweet"
        sleep 5
    fi
    
    today_count=$(get_today_count)
    
    # 第二条：预设推文
    if [ $today_count -lt $max ]; then
        log_info "从预设中选一条发布..."
        preset=$(pick_unpublished_tweet)
        [ -n "$preset" ] && publish_tweet "$preset"
        sleep 5
    fi
    
    # 交互（每两天）
    daynum=$(date +%j)
    if [ $((daynum % 2)) -eq 0 ]; then
        follow_users
    fi
    
    log_info "✅ 今日运营完成！"
}

# 查看统计
show_stats() {
    total_tweets=$(grep -c "http" "$TWEET_FILE" 2>/dev/null || echo 0)
    today_count=$(get_today_count)
    articles=$(ls content/posts/*.md 2>/dev/null | wc -l)
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  📊 推特运营统计"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  博客文章数: $articles"
    echo "  预设推文数: $total_tweets"
    echo "  今日已发布: $today_count"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

cmd="${1:-run}"
case "$cmd" in
    run)       init_log; run_daily ;;
    tweet)     
        if [ -z "$2" ]; then echo "用法: $0 tweet \"内容\""; exit 1; fi
        publish_tweet "$2" ;;
    hot)       
        init_log
        t=$(generate_hot_tweet)
        echo "$t" ;;
    follow)    follow_users ;;
    stats)     show_stats ;;
    *)         
        echo "用法: $0 {run|tweet|hot|follow|stats}"
        ;;
esac
