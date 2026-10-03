# Packet Tracer 9.0.0 Docker Environment (Ubuntu 26.04+)

[![中文](https://img.shields.io/badge/中文-README_zh_CN-blue)](README_zh_CN.md)

A ready-to-use Docker environment for running Cisco Packet Tracer 9.0.0 on modern Linux distributions (tested on Ubuntu 26.04).  
It solves common issues such as FUSE incompatibility, missing Qt/OpenGL libraries, Chromium sandbox restrictions, and permission errors.

---

## Table of Contents

- [Background](#background)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Credits](#credits)
- [License](#license)

---

## Background

Cisco Packet Tracer 9.0.0 is built with Qt6 and requires glibc 2.34+.  
On modern Linux distributions like Ubuntu 26.04, running the official `.deb` or AppImage directly often fails due to:

- FUSE version mismatch (AppImage cannot mount)
- Qt platform plugin (`xcb`) initialization failure
- Chromium sandbox restrictions (cannot run as root)
- Missing OpenGL / EGL / xcb dependencies
- Permission issues with `.local` directories

This repository provides a **Dockerized environment** that solves all these problems, allowing you to run Packet Tracer 9.0.0 on Ubuntu 26.04 (and other modern distros) with a single command.

---

## Prerequisites

- Docker Engine (with Compose plugin)
- A Cisco NetAcad account (to download the `.deb` installer)
- X11 display server (standard on most Linux desktops)

---

## Quick Start

### 1. Clone this repository

```
git clone https://github.com/your-username/packet-tracer-docker-ubuntu26.git
cd packet-tracer-docker-ubuntu26
```
### 2.Download
- Download Packet Tracer 9.0.0 .deb
- Log in to Cisco NetAcad and download
- CiscoPacketTracer_900_Ubuntu_64bit.deb.Place it in the repository root (the same directory as Dockerfile).

### 3. Build and run
```
xhost +local:docker
sudo DISPLAY=$DISPLAY docker compose up --build
```
- If you are in the docker group, you can omit sudo.

### 4. Login
- A browser window will open for Cisco OAuth. If it doesn't, manually open the link shown in the terminal.

- After authorization, return to Packet Tracer.

### 5. Save your work
- Your .pkt files will be saved in ./pt/ on the host.

- Configuration and login state are stored in ./Cisco_Packet_Tracer/.

## Credits
This project is inspired by `andrecchia/packet-tracer-docker`.
We updated it for Packet Tracer 9.0.0, Ubuntu 22.04+ (including 26.04), and added comprehensive fixes for modern systems.

## License
The Docker configuration files are provided under the MIT License.
Packet Tracer itself is subject to Cisco's EULA.
The .deb installer is not included in this repository.