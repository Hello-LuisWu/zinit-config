#!/usr/bin/env bash

set -e

URL="https://raw.githubusercontent.com/Hello-LuisWu/zinit-config/refs/heads/main/.zshrc"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

echo "==> 下载配置文件..."

TMP_FILE=$(mktemp)

curl -fsSL "$URL" -o "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "错误：下载的文件为空"
    rm -f "$TMP_FILE"
    exit 1
fi

echo "==> 备份当前 ~/.zshrc"

if [ -f "$ZSHRC" ]; then
    cp "$ZSHRC" "$BACKUP"
    echo "备份完成: $BACKUP"
fi

echo "==> 检查是否已经添加..."

if grep -q "zinit-config" "$ZSHRC" 2>/dev/null; then
    echo "检测到已经存在 zinit-config 配置，跳过追加"
else
    {
        echo
        echo "# ===== zinit-config start ====="
        cat "$TMP_FILE"
        echo "# ===== zinit-config end ====="
    } >> "$ZSHRC"

    echo "追加完成"
fi

rm -f "$TMP_FILE"

echo
echo "加载配置中..."
exec zsh
