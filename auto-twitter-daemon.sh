#!/bin/bash

# ============================================
# 推特自动运营守护进程
# 持续运行，按时间计划自动执行
# ============================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"
PID_FILE="$SCRIPT_DIR/.twitter_daemon.pid"
RECORD_FILE="$LOG_DIR/.publish_records.txt"

mkdir -p "$LOG_DIR"

log_info()  { echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_DIR/daemon.log"; }
log_ok()    { echo "[OK] $(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_DIR/daemon.log"; }
log_warn()  { echo "[WARN] $(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_DIR/daemon.log"; }
log_error() { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_DIR/daemon.log"; }

PUBLISH_TIMES="08:00 12:00 20:00"

init_records() { touch "$RECORD_FILE"; }

is_published() {
    grep -q "${1}" "$RECORD_FILE" 2>/dev/null
    return $?
}

mark_published() { echo "$1" >> "$RECORD_FILE"; }

check_and_publish() {
    now=$(date +%H:%M)
    today=$(date +%Y-%m-%d)
    for slot in $PUBLISH_TIMES; do
        if [ "$now" = "$slot" ]; then
            key="${today}_${slot}"
            if ! is_published "$key"; then
                log_info "发布时间到: $slot，开始运营"
                cd "$SCRIPT_DIR"
                result=$(bash "$SCRIPT_DIR/auto-twitter-manager.sh" run 2>&1)
                code=$?
                if [ $code -eq 0 ]; then
                    log_ok "$slot 运营完成"
                    mark_published "$key"
                else
                    log_error "$slot 运营失败: $result"
                fi
            fi
        fi
    done
}

main_loop() {
    init_records
    log_info "===== 推特自动运营守护进程启动 ====="
    log_info "发布时间: $PUBLISH_TIMES"
    echo $$ > "$PID_FILE"
    log_info "PID: $$"
    while true; do
        check_and_publish
        sleep 60
    done
}

cmd="${1:-start}"

if [ "$cmd" = "start" ]; then
    if [ -f "$PID_FILE" ]; then
        oldpid=$(cat "$PID_FILE")
        if kill -0 "$oldpid" 2>/dev/null; then
            echo "守护进程已在运行 (PID: $oldpid)"
            exit 0
        fi
        rm -f "$PID_FILE"
    fi
    main_loop
elif [ "$cmd" = "stop" ]; then
    if [ -f "$PID_FILE" ]; then
        stoppid=$(cat "$PID_FILE")
        kill "$stoppid" 2>/dev/null && echo "已停止 (PID: $stoppid)" || echo "进程不存在"
        rm -f "$PID_FILE"
    else
        echo "未运行"
    fi
elif [ "$cmd" = "status" ]; then
    if [ -f "$PID_FILE" ]; then
        statpid=$(cat "$PID_FILE")
        if kill -0 "$statpid" 2>/dev/null; then
            echo "✅ 运行中 (PID: $statpid)"
            bash "$SCRIPT_DIR/auto-twitter-manager.sh" stats 2>/dev/null
        else
            echo "PID 文件存在但进程已死"
            rm -f "$PID_FILE"
        fi
    else
        echo "❌ 未运行"
    fi
else
    echo "用法: $0 {start|stop|status}"
fi
