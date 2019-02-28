#!/bin/bash

which sdkmanager
which avdmanager
which emulator
which adb
ldd `which emulator`
java -Xmx32m -version
sdkmanager --list
emulator -list-avds
emulator-check accel hyper-v cpu-info
# https://developer.android.com/studio/run/emulator-commandline#startup-options
emulator -verbose -avd android-emulator-${EMULATOR_API_LEVEL} \
         -no-accel \
         -no-audio \
         -no-window \
         -no-boot-anim \
         -no-snapshot \
         -camera-back none \
         -camera-front none \
         -gpu swiftshader_indirect \
         -memory 2048 \
         -skin 480x800 &
./wait-for-boot-completed
adb devices
adb shell pm dump com.google.android.gms | grep version
sleep 1 
adb emu kill
