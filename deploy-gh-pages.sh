#!/usr/bin/env bash
# 重新部署 agent deck 到 GitHub Pages（gh-pages 分支）
# 用法: ./deploy-gh-pages.sh
# 原理: 在隔离的临时仓库里只放 index.html + deck-stage.js，强制推送到 gh-pages 分支。
#       主仓库工作区与当前分支完全不受影响。
# 代理: 访问 GitHub 需要代理，默认读 $http_proxy，否则用 Clash 端口 127.0.0.1:7890。

set -euo pipefail

# 基于脚本位置定位仓库（本脚本放在仓库根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DECK_DIR="$SCRIPT_DIR/designs/agent-zero-to-one-talk"
REMOTE="https://github.com/David-qiuwenhui/ai-agent-department-share.git"
BRANCH="gh-pages"
SITE_URL="https://david-qiuwenhui.github.io/ai-agent-department-share/"
PROXY="${http_proxy:-http://127.0.0.1:7890}"
FILES=(index.html deck-stage.js)

echo "==> 部署 agent deck 到 GitHub Pages"
echo "    源目录: $DECK_DIR"
echo "    远程  : $REMOTE ($BRANCH)"

# 1. 校验源文件存在
for f in "${FILES[@]}"; do
  [[ -f "$DECK_DIR/$f" ]] || { echo "错误: 缺少 $DECK_DIR/$f" >&2; exit 1; }
done

# 2. 隔离的临时仓库（孤儿分支，不碰主仓库）；EXIT 时自动清理
DEPLOY_DIR="$(mktemp -d)"
trap 'rm -rf "$DEPLOY_DIR"' EXIT
echo "==> 临时仓库: $DEPLOY_DIR"
cd "$DEPLOY_DIR"
git init -q
for f in "${FILES[@]}"; do cp "$DECK_DIR/$f" .; done
git add "${FILES[@]}"
git commit -q -m "Redeploy agent deck ($(date +'%Y-%m-%d %H:%M'))"

# 3. 强制推送到 gh-pages（孤儿历史每次重建，故用 --force）
echo "==> 推送（代理 $PROXY，--force 覆盖远程孤儿分支）"
git remote add origin "$REMOTE"
https_proxy="$PROXY" http_proxy="$PROXY" git push --force -u origin "$BRANCH"

echo "==> 完成！站点: $SITE_URL"
echo "    （国内访问需开代理；Pages 构建通常 10-30 秒内完成）"
