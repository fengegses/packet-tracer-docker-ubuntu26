# Packet Tracer 9.0.0 Docker 环境（Ubuntu 26.04+）

[![English](https://img.shields.io/badge/English-README-blue)](README.md)

一个开箱即用的 Docker 环境，用于在现代 Linux 发行版（已在 Ubuntu 26.04 上测试）中运行 Cisco Packet Tracer 9.0.0。  
它解决了 FUSE 不兼容、Qt/OpenGL 库缺失、Chromium 沙盒限制以及权限错误等常见问题。

---

## 目录

- [背景](#背景)
- [前置条件](#前置条件)
- [快速开始](#快速开始)
- [致谢](#致谢)
- [许可证](#许可证)

---

## 背景

Cisco Packet Tracer 9.0.0 基于 Qt6 构建，需要 glibc 2.34+。  
在 Ubuntu 26.04 等现代 Linux 发行版上，直接运行官方 `.deb` 或 AppImage 经常会遇到以下问题：

- FUSE 版本不兼容，AppImage 无法挂载
- Qt 平台插件（`xcb`）初始化失败
- Chromium 沙盒限制，不允许以 root 运行
- 缺少 OpenGL / EGL / xcb 等图形库
- `.local` 目录权限错误

本仓库提供了一个 **Docker 化环境**，一次性解决上述所有问题，让你在 Ubuntu 26.04（及其他现代发行版）上通过一条命令即可运行 Packet Tracer 9.0.0。

---

## 前置条件

- Docker 引擎（含 Compose 插件）
- Cisco NetAcad 账号（用于下载 `.deb` 安装包）
- X11 显示服务器（大多数 Linux 桌面默认已安装）

---

## 快速开始

### 1. 克隆本仓库

```
git clone https://github.comyour-usernamepacket-tracer-docker-ubuntu26.git
cd packet-tracer-docker-ubuntu26
```
### 2. 下载

- 下载 Packet Tracer 9.0.0 的 .deb 包
- 登录 Cisco NetAcad
- 下载 CiscoPacketTracer_900_Ubuntu_64bit.deb。将其放置到仓库根目录（与 Dockerfile 同级）。

### 3. 构建并运行
```
xhost +local:docker
sudo DISPLAY=$DISPLAY docker compose up --build
```
- 如果你已加入 docker 用户组，可以省略 sudo。

### 4. 登录

- 浏览器会自动打开 Cisco OAuth 登录页面。若未弹出，请手动复制终端中显示的链接到宿主机浏览器打开。

- 完成授权后，切回 Packet Tracer。

### 5. 保存实验文件

- 你的 .pkt 文件会保存在宿主机的 ./pt/ 目录中。

- 配置和登录状态保存在 ./Cisco_Packet_Tracer/ 目录中。

## 致谢

本项目受 andrecchia/packet-tracer-docker 启发，并针对 Packet Tracer 9.0.0、Ubuntu 22.04+（含 26.04）进行了更新，补充了大量现代系统的修复方案。

## 许可证

Docker 配置文件采用 MIT 许可证。
Packet Tracer 软件本身受 Cisco EULA 约束。
本仓库不包含 .deb 安装包。

---
