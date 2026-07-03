#!/bin/bash
cd ~/myblog
git add .
git commit -m "Auto update blog: $(date +'%Y-%m-%d %H:%M:%S')"
git push
echo "🎉 已經成功推送！Cloudflare 正在後台幫你更新網站..."
sleep 3
