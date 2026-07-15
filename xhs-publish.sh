#!/bin/bash

# 小红书发布管理脚本
# 每日发布 1-2 篇帖文，配合引流策略

BLOG_URL="https://xinqiai.dpdns.org"
XHS_DIR="content/xhs"
LOG_FILE="xhs-publish-log.txt"
XHS_FILES=($(ls $XHS_DIR/*.md 2>/dev/null))

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

# 随机挑选一篇帖文
pick_post() {
    local used=()
    if [ -f "$LOG_FILE" ]; then
        used=($(cat "$LOG_FILE"))
    fi
    
    for f in "${XHS_FILES[@]}"; do
        local name=$(basename "$f" .md)
        if [[ ! " ${used[@]} " =~ " ${name} " ]]; then
            echo "$f"
            echo "$name" >> "$LOG_FILE"
            return
        fi
    done
    
    echo ""
}

# 提取标题
extract_title() {
    local file="$1"
    h1=$(grep "^## 标题选项" -A 10 "$file" | grep "选项1" | head -1)
    echo "${h1#*：}"
}

# 提取正文前50字作为预览
extract_preview() {
    local file="$1"
    # 取正文第一段（非空行非标题行）
    sed -n '/^## 正文/,/^---/p' "$file" | grep -v "^##" | grep -v "---" | grep -v "^$" | head -5
}

show_schedule() {
    echo ""
    echo "📅 小红书发布计划"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "12:00-13:00 → 技术教程类"
    echo "18:00-19:00 → 工具推荐类"
    echo "21:00-22:00 → 经验分享/赚钱类"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━"
}

show_all_posts() {
    echo ""
    echo "📋 已有帖文模板："
    echo "━━━━━━━━━━━━━━━━━━━━━"
    local i=1
    for f in "${XHS_FILES[@]}"; do
        echo "$i. $(basename "$f" .md): $(extract_title "$f")"
        ((i++))
    done
    echo "━━━━━━━━━━━━━━━━━━━━━"
}

# 引流文字
generate_cta() {
    local post_name="$1"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📌 更多干货在我的博客 👇"
    echo "   $BLOG_URL"
    echo "   搜「欣淇AI网」或查看主页"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

case "${1:-help}" in
    pick)
        post=$(pick_post)
        if [ -z "$post" ]; then
            log_warn "所有帖文已发布过一轮，重置日志"
            rm -f "$LOG_FILE"
            post=$(pick_post)
        fi
        echo ""
        log_info "推荐发布帖文：$(basename "$post")"
        echo ""
        echo "📄 标题：$(extract_title "$post")"
        echo ""
        echo "📝 预览："
        extract_preview "$post"
        generate_cta "$post"
        ;;
    list)
        show_all_posts
        ;;
    schedule)
        show_schedule
        show_all_posts
        ;;
    reset)
        rm -f "$LOG_FILE"
        log_ok "发布记录已重置"
        ;;
    *)
        echo "用法: ./xhs-publish.sh [命令]"
        echo ""
        echo "命令:"
        echo "  pick     - 推荐一篇未发布的帖文"
        echo "  list     - 列出所有帖文模板"
        echo "  schedule - 显示发布计划"
        echo "  reset    - 重置发布记录"
        ;;
esac
