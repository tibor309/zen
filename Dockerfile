FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.description="Web accessible Zen Browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/zen
LABEL org.opencontainers.image.url=https://github.com/tibor309/zen/packages
LABEL org.opencontainers.image.licenses=GPL-3.0

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV TITLE="Zen Browser"

RUN \
    echo "**** install package dependencies ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        lsb-release \
        libasound2 \
        libatk1.0-0 \
        libc6 \
        libcairo-gobject2 \
        libcairo2 \
        libdbus-1-3 \
        libfontconfig1 \
        libfreetype6 \
        libgcc-s1 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libharfbuzz0b \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb-shm0 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        bzip2 && \
    echo "**** install zen browser ****" && \
    curl -o \
        /tmp/zen.linux-generic.tar.bz2 -L \
        "https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-generic.tar.bz2" && \
    tar -xf \
        /tmp/zen.linux-generic.tar.bz2 -C \
        /app && \
    echo "**** cleanup ****" && \
    rm -rf \
        /config/.cache \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config