FROM debian:stretch

ARG EMULATOR_API_LEVEL
ARG EMULATOR_ARCH

# Install java and dependencies
# to debug missing lib issues use ldconfig -p | grep libGL
# Dev deps are taken from https://source.android.com/source/initializing#installing-required-packages-ubuntu-1404
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update --quiet --yes \
    && apt-get install --quiet --yes \
    bison \
    build-essential \
    bridge-utils \
    ccache \
    file \
    flex \
    g++-multilib \
    gcc-multilib \
    git-core \
    gnupg \
    gperf \
    lib32gcc1 \
    lib32ncurses5 \
    lib32ncurses5-dev \
    lib32z-dev \
    lib32z1 \
    libc6-dev-i386 \
    libgl1-mesa-dev \
    libglu1-mesa \
    libmagic1 \
    libpci3 \
    libpulse0 \
    libx11-dev \
    libxdamage1 \
    libxml2-utils \
    libvirt-clients \
    libvirt-daemon-system \
    locales \
    mesa-utils \
    openjdk-8-jdk-headless \
    pciutils \
    qemu-kvm \
    qemu-utils \
    unzip \
    wget \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
    && apt-get clean --quiet
# http://stackoverflow.com/a/37604675/624706

# Set the locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && /usr/sbin/locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Download and extract AndroidSDK
# Get latest version name from https://developer.android.com/studio/index.html#downloads
RUN cd /opt \
    && wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip -q android-sdk.zip -d android-sdk-linux \
    && rm -f android-sdk.zip \
    && chown -R root.root android-sdk-linux

# Add enviroment variables 
# https://developer.android.com/studio/command-line/variables#envar
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV ANDROID_SDK_HOME ${ANDROID_SDK_ROOT}/.home/
# /tools/bin - sdkmanager, avdmanager
# /platform-tools - adb
# /emulator - emulator, emulator-check 
ENV PATH ${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

# Update AndroidSDK
# Get ids from sdkmanager --list
RUN yes | sdkmanager --licenses
RUN echo "y" | sdkmanager "build-tools;28.0.3" \
    "emulator" \
    "platform-tools" \
    "platforms;android-28" \
    "system-images;android-${EMULATOR_API_LEVEL};google_apis;${EMULATOR_ARCH}" \
    "tools" >/dev/null

# Create AVD
RUN echo "no" | avdmanager --silent create avd --force --name android-emulator-$EMULATOR_API_LEVEL --device "4in WVGA (Nexus S)" --package "system-images;android-${EMULATOR_API_LEVEL};google_apis;${EMULATOR_ARCH}"

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
