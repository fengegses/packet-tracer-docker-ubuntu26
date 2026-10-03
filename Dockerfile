FROM ubuntu:22.04

# 构建参数：传入用户名，默认 cisco
ARG DOCKER_USER=cisco

ENV DEBIAN_FRONTEND=noninteractive
ENV QT_QPA_PLATFORM=xcb

# 安装 Packet Tracer 9.0 所需的全部依赖（比仓库原版多了 Qt6/OpenGL/xcb 相关库）
RUN apt-get update && apt-get install -y \
    wget \
    libxcb-xinerama0 \
    libnss3 \
    libxss1 \
    libasound2 \
    libglu1-mesa \
    libpulse0 \
    libx11-xcb1 \
    libxcb1 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libfuse2 \
    fuse \
    libgtk-3-0 \
    libpcre2-dev \
    sudo \
    xdg-utils \
    libopengl0 \
    libgl1-mesa-dri \
    libegl1 \
    libegl-mesa0 \
    libgles2 \
    libglvnd0 \
    libglx0 \
    libglx-mesa0 \
    mesa-utils \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    libdbus-1-3 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# 复制 deb 包（注意下面这行的文件名要和你的实际文件名一致）
COPY CiscoPacketTracer_900_Ubuntu_64bit.deb /tmp/packettracer.deb

# 安装 Packet Tracer，自动接受 EULA（输入 "2"）
RUN echo "2" | dpkg -i /tmp/packettracer.deb || apt-get install -f -y && \
    rm /tmp/packettracer.deb

# 创建非 root 用户（关键：解决 Chromium "Running as root without --no-sandbox" 报错）
# UID 设为 1000 是为了和宿主机用户权限对齐，方便挂载目录读写
RUN useradd -m -u 1000 -s /bin/bash $DOCKER_USER && \
    mkdir -p /home/$DOCKER_USER/.local/share && \
    chown -R $DOCKER_USER:$DOCKER_USER /home/$DOCKER_USER

USER $DOCKER_USER
WORKDIR /home/$DOCKER_USER

CMD ["packettracer"]
