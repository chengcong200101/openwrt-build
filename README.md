# OpenWrt x86 自动编译

使用 GitHub Actions 自动编译 OpenWrt x86 固件。

## 特性

- OpenWrt 23.05.3 稳定版
- x86/64 架构
- 包含基础插件：
  - Argon 主题
  - SmartDNS
  - TTYD Web 终端
  - DDNS-Go

## 使用方法

1. Fork 本仓库
2. 进入 GitHub Actions 页面
3. 选择 "Build OpenWrt x86" 工作流
4. 点击 "Run workflow"
5. 等待编译完成，下载固件

## 文件说明

- 固件位置：`openwrt/bin/targets/x86/64/`
- 编译日志：工作流运行详情中查看

## 自定义

编辑 `.github/workflows/build-openwrt.yml` 文件来自定义配置和插件。
