#!/bin/bash

set -e

echo "=== Running Disk Space Optimization ==="

# 清理系统缓存
clean_system_cache() {
    echo "Cleaning system caches..."
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*
}

# 清理 GitHub Actions 缓存
clean_actions_cache() {
    echo "Cleaning GitHub Actions cache..."
    # 清理各种工具缓存
    sudo rm -rf /usr/share/dotnet/sdk/
    sudo rm -rf /usr/share/dotnet/shared/
    sudo rm -rf /opt/hostedtoolcache/CodeQL
    sudo rm -rf /usr/local/graalvm
    sudo rm -rf /opt/microsoft
    sudo rm -rf /usr/local/lib/android
}

# 清理日志文件
clean_logs() {
    echo "Cleaning log files..."
    sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;
    sudo journalctl --vacuum-size=1M
}

# 显示磁盘使用
show_disk_usage() {
    echo "=== Current Disk Usage ==="
    df -h
    echo "=== Large directories ==="
    sudo du -sh /home/runner/* 2>/dev/null | sort -hr | head -10
}

main() {
    show_disk_usage
    
    clean_system_cache
    clean_actions_cache
    clean_logs
    
    echo "=== After Cleanup ==="
    show_disk_usage
    
    echo "✅ Disk cleanup completed"
}

main "$@"