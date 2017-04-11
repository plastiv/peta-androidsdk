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
# If you want audio pass QEMU_AUDIO_DRV=pa -> https://www.wagner.pp.ru/fossil/vws/wiki?name=QEMU+audio
export QEMU_AUDIO_DRV=none
emulator -verbose -show-kernel -avd android-25-emulator -engine classic -no-window -no-boot-anim &
./android-wait-for-emulator
sleep 120
adb devices
adb shell pm dump com.google.android.gms | grep version
