FROM debian:jessie

# Add Zulu OpenJDK repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list

# Add 32-bit
RUN dpkg --add-architecture i386

# Install java and dependencies
# debug missing lib with ldd `which emulator`
# check installed libs with ldconfig -p | grep libGL
# http://stackoverflow.com/a/37604675/624706
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    file \
    lib32gcc1 \
    lib32ncurses5 \
    lib32z1 \
    libc6-i386 \
    libglu1-mesa \
    libmagic1 \
    libpci3 \
    libpulse0 \
    libxdamage1 \
    mesa-utils \
    pciutils \
    unzip \
    wget \
    zulu-8 \
    && apt-get clean

# Download and extract AndroidSDK
RUN cd /opt \
    && wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/tools_r25.2.5-linux.zip \
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
ENV PATH ${PATH}:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Update AndroidSDK
RUN echo "y" | sdkmanager "build-tools;25.0.2" \
    "emulator" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "platform-tools" \
    "platforms;android-25" \
    "system-images;android-25;google_apis;armeabi-v7a" \
    "tools"

# Create AVD
RUN echo "no" | avdmanager --verbose create avd --force --name android-25-emulator --package "system-images;android-25;google_apis;armeabi-v7a" --tag "google_apis" --abi "armeabi-v7a"

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
