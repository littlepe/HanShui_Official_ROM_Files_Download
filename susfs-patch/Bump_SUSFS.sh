#!/bin/bash
set -e

PATCH158="./1.5.7_to_1.5.8.patch"
PATCH159="./1.5.8_to_1.5.9.patch"

echo "⬇️  正在下载补丁..."
curl -L -o "$PATCH158" https://raw.githubusercontent.com/littlepe/HanShui_Official_ROM_Files_Download/refs/heads/main/susfs-patch/1.5.7_to_1.5.8.patch
curl -L -o "$PATCH159" https://raw.githubusercontent.com/littlepe/HanShui_Official_ROM_Files_Download/refs/heads/main/susfs-patch/1.5.8_to_1.5.9.patch

if [[ ! -s "$PATCH158" ]] || [[ ! -s "$PATCH159" ]]; then
    echo "❌ 补丁下载失败，请检查网络"
    exit 1
fi

echo "🩹 正在应用 1.5.7 → 1.5.8 补丁..."
if patch -p1 --dry-run < "$PATCH158"; then
    patch -p1 < "$PATCH158"
    echo "✅ 已应用 1.5.8 补丁"
else
    echo "❌ 1.5.8 补丁存在冲突，请手动解决"
    exit 1
fi

echo "🩹 正在应用 1.5.8 → 1.5.9 补丁..."
if patch -p1 --dry-run < "$PATCH159"; then
    patch -p1 < "$PATCH159"
    echo "✅ 已应用 1.5.9 补丁"
else
    echo "❌ 1.5.9 补丁存在冲突，请手动解决"
    exit 1
fi

rm -f "$PATCH158" "$PATCH159"

echo "🎉 SUSFS 已成功升级到 v1.5.9"
