FROM debian:jessie

# Add Zulu OpenJDK repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list

# Install java and dependencies
# to debug missing lib issues use ldconfig -p | grep libGL
# Dev deps are taken from https://source.android.com/source/initializing#installing-required-packages-ubuntu-1404
RUN dpkg --add-architecture i386
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    bison \
    build-essential \
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
    locales \
    mesa-utils \
    pciutils \
    unzip \
    wget \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
    zulu-8 \
    && apt-get clean
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
ENV ANDROID_HOME /opt/android-sdk-linux
# Path to .android folder with created avd files
ENV ANDROID_SDK_HOME /opt
# /tools - emulator (old), android, proguard
# /tools/bin - avdmanager, sdkmanager
# /platform-tools - adb
# /emulator - emulator, emulator64 
ENV PATH ${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Update AndroidSDK
# Get ids from sdkmanager --list
RUN yes | sdkmanager --licenses
RUN echo "y" | sdkmanager "build-tools;28.0.3" \
    "emulator" \
    "platform-tools" \
    "platforms;android-28" \
    "system-images;android-28;google_apis;x86" \
    "tools" >/dev/null

# Create AVD
RUN echo "no" | avdmanager create avd --force --name android-28-emulator --device "4in WVGA (Nexus S)" --package "system-images;android-28;google_apis;x86" >/dev/null

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
