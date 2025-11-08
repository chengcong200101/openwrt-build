#!/bin/bash

set -e

echo "=== Checking OpenWrt Build Dependencies ==="

# 检查基本编译工具
check_tool() {
    if command -v $1 &> /dev/null; then
        echo "✅ $1: $(which $1)"
    else
        echo "❌ $1: Not found"
        return 1
    fi
}

# 必要工具列表
tools=(
    "gcc"
    "g++"
    "make"
    "bash"
    "patch"
    "git"
    "wget"
    "curl"
    "unzip"
    "python3"
    "file"
    "rsync"
)

for tool in "${tools[@]}"; do
    check_tool $tool
done

# 检查库文件
check_lib() {
    if ldconfig -p | grep -q $1; then
        echo "✅ lib$1: Found"
    else
        echo "❌ lib$1: Not found"
        return 1
    fi
}

libs=("ncurses" "zlib" "ssl" "crypto" "stdc++")

for lib in "${libs[@]}"; do
    check_lib $lib
done

# 检查磁盘空间
echo "=== Disk Space Check ==="
df -h .

AVAILABLE_SPACE=$(df . | awk 'NR==2 {print $4}')
if [[ ${AVAILABLE_SPACE%G} -lt 20 ]]; then
    echo "⚠️  Warning: Low disk space - ${AVAILABLE_SPACE}"
    echo "Recommended: At least 20GB free space"
else
    echo "✅ Disk space: ${AVAILABLE_SPACE} - Sufficient"
fi

# 检查内存
echo "=== Memory Check ==="
free -h

TOTAL_MEM=$(free -g | awk 'NR==2 {print $2}')
if [[ $TOTAL_MEM -lt 4 ]]; then
    echo "⚠️  Warning: Low memory - ${TOTAL_MEM}GB"
    echo "Recommended: At least 4GB RAM"
else
    echo "✅ Memory: ${TOTAL_MEM}GB - Sufficient"
fi

echo "=== Dependency Check Complete ==="
