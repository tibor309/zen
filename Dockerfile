FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.authors="tibor309"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Zen Browser"
LABEL org.opencontainers.image.description="Web accessible Zen Browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/zen
LABEL org.opencontainers.image.url=https://github.com/tibor309/zen/packages
LABEL org.opencontainers.image.licenses=GPL-3.0
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV TITLE="Zen Browser"

RUN \
    echo "**** add icon ****" && \
    curl -o \
        /kclient/public/icon.png \
        https://raw.githubusercontent.com/tibor309/icons/main/icons/zen/zen_dark_light.png && \
    curl -o \
        /kclient/public/favicon.ico \
        https://raw.githubusercontent.com/tibor309/icons/main/icons/zen/zen_dark_light_favicon.ico && \
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
        "https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.bz2" && \
    tar -xf \
        /tmp/zen.linux-generic.tar.bz2 -C \
        /app && \
    echo "**** default zen settings ****" && \
    mkdir -p /app/zen/browser/defaults/preferences && \
    ZEN_SETTING="/app/zen/browser/defaults/preferences/zen.js" && \
    echo 'pref("zen.welcome-screen.enabled", false);' > ${ZEN_SETTING} && \
    echo 'pref("startup.homepage_welcome_url", "");' >> ${ZEN_SETTING} && \
    echo 'pref("startup.homepage_welcome_url.additional", "");' >> ${ZEN_SETTING} && \
    echo 'pref("app.update.auto", false);' >> ${ZEN_SETTING} && \
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