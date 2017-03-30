#!/bin/bash
set -x #echo on

which adb
which emulator
ldd `which emulator`
which emulator64-arm
ldd `which emulator64-arm`
which avdmanager
which sdkmanager
java -Xmx32m -version
java -Xmx32m -jar $ANDROID_HOME/tools/proguard/lib/proguard.jar
sdkmanager --list
emulator -list-avds
emulator-check accel hyper-v cpu-info
export SHELL=/bin/bash
emulator -verbose -show-kernel -avd android-25-emulator -no-audio -no-window -wipe-data -gpu off -qemu -smp 1 &
adb devices
./android-wait-for-emulator
adb devices
adb shell pm dump com.google.android.gms | grep version
