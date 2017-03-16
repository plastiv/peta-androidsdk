FROM debian:jessie

# Add Zulu OpenJDK repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list

# Add 32-bit
RUN dpkg --add-architecture i386

# Install java and dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    lib32gcc1 \
    lib32ncurses5 \
    lib32z1 \
    libc6-i386 \
    libstdc++6:i386 \
    wget \
    zulu-8=8.20.0.5 \
    unzip \
    && apt-get clean

# Download and extract AndroidSDK
RUN cd /opt \
    && wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/tools_r25.2.5-linux.zip \
    && unzip android-sdk.zip -d android-sdk-linux \
    && rm -f android-sdk.zip \
    && chown -R root.root android-sdk-linux

# Add enviroment variables
ENV ANDROID_HOME /opt/android-sdk-linux
# Path to .android folder with created avd files
ENV ANDROID_SDK_HOME /opt
# /tools - emulator
# /tools/bin - avdmanager, sdkmanager
# /platform-tools - adb
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Update AndroidSDK
RUN echo "y" | sdkmanager "build-tools;25.0.2" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "platform-tools" \
    "platforms;android-25" \
    "tools"

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
