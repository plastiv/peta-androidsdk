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
sdkmanager --list
export SHELL=/bin/bash
emulator -list-avds
emulator-check accel hyper-v cpu-info
# If you want audio pass QEMU_AUDIO_DRV=pa -> https://www.wagner.pp.ru/fossil/vws/wiki?name=QEMU+audio
export QEMU_AUDIO_DRV=none
emulator -verbose -show-kernel -avd android-28-emulator -no-accel -no-audio -no-window -no-boot-anim -gpu swiftshader_indirect -memory 2048 -skin 480x800 &
./wait-for-boot-completed
adb devices
adb shell pm dump com.google.android.gms | grep version
