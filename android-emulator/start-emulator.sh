#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

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
emulator -verbose -avd android-emulator-${EMULATOR_SDK_VERSION} \
         -no-accel \
         -no-audio \
         -no-window \
         -no-boot-anim \
         -no-snapshot \
         -gpu swiftshader_indirect \
         -memory 2048 \
         -skin 480x800 &
./wait-for-boot-completed
adb devices
adb shell pm dump com.google.android.gms | grep version
adb emu kill
