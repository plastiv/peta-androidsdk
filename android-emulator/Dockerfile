FROM debian:stretch-slim

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Download java and android (emulator) dependencies
# man1mkdir workaround for installing java (triggered by using slim base image)
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1 \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install --no-install-recommends \
# Needed for install
    unzip \
    wget \
# Emulator & video bridge dependencies
# to debug missing lib issues use ldconfig -p | grep libGL
# Dev deps are taken from https://android.googlesource.com/platform/external/adt-infra/+/refs/heads/emu-master-dev/emu-image/external/emu_templates.py
    libc6 libdbus-1-3 libfontconfig1 libgcc1 \
    libpulse0 libtinfo5 libx11-6 libxcb1 libxdamage1 \
    libxext6 libxfixes3 zlib1g libgl1 pulseaudio socat \
# Java
    openjdk-8-jdk-headless >/dev/null \
    && apt-get -qq clean
# http://stackoverflow.com/a/37604675/624706

# Download basic Android command line tools
# Get latest version name from https://developer.android.com/studio/index.html#downloads
ARG SDK_ARCHIVE_VERSION=4333796
RUN cd /opt \
    && wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/sdk-tools-linux-${SDK_ARCHIVE_VERSION}.zip \
    && unzip -q android-sdk.zip -d android-sdk-linux \
    && rm -f android-sdk.zip

# Add enviroment variables
ENV ANDROID_HOME /opt/android-sdk-linux
# Path to .android folder with created avd files
ENV ANDROID_SDK_HOME /opt
# /tools - emulator (old), android, proguard
# /tools/bin - avdmanager, sdkmanager
# /platform-tools - adb
# /emulator - emulator, emulator64
ENV PATH ${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Set up insecure default adb key
COPY adb/* /root/.android/

ARG BUILD_TOOLS_VERSION=29.0.2
ARG PLATFORM_API_LEVEL=29
ARG EMULATOR_API_LEVEL=29
ARG EMULATOR_VARIANT=google_apis
ARG EMULATOR_ARCH=x86_64

# Update AndroidSDK
# Get ids from sdkmanager --list
RUN yes 'y' | sdkmanager --licenses >/dev/null \
    && yes 'y' | sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" \
    "emulator" \
    "platform-tools" \
    "platforms;android-${PLATFORM_API_LEVEL}" \
    "system-images;android-${EMULATOR_API_LEVEL};${EMULATOR_VARIANT};${EMULATOR_ARCH}" \
    "tools" >/dev/null

# GO to workspace
WORKDIR /opt/workspace
