FROM debian:stretch

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Download java and android (emulator) dependencies
# to debug missing lib issues use ldconfig -p | grep libGL
# Dev deps are taken from https://developer.android.com/studio/install#linux
# https://issuetracker.google.com/issues/37094469
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install --no-install-recommends \
    libglu1-mesa \
    openjdk-8-jdk-headless \
    qemu-system-x86 \
    unzip \
    wget >/dev/null \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*
# http://stackoverflow.com/a/37604675/624706

# Download basic Android command line tools
# Get latest version name from https://developer.android.com/studio/index.html#downloads
ARG SDK_ARCHIVE_VERSION=4333796
RUN cd /opt \
    && wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/sdk-tools-linux-${SDK_ARCHIVE_VERSION}.zip \
    && unzip -q android-sdk.zip -d android-sdk-linux \
    && rm -f android-sdk.zip

# Add enviroment variables 
# https://developer.android.com/studio/command-line/variables#envar
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
# /tools/bin - sdkmanager, avdmanager
# /platform-tools - adb
# /emulator - emulator, emulator-check 
ENV PATH ${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

ARG BUILD_TOOLS_VERSION=28.0.3
ARG PLATFORM_API_LEVEL=28
ARG EMULATOR_API_LEVEL=28
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

# Playstore emulator images are enforcing auth. Need to have adbkey.pub before creating emulator
# Set up insecure default adb key
COPY adb/* /root/.android/

# GO to workspace
WORKDIR /opt/workspace
