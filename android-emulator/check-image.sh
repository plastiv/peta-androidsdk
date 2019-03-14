#!/bin/bash

java -Xmx32m -version
sdkmanager --list
avdmanager list avd
emulator-check accel hyper-v cpu-info window-mgr desktop-env
./start-emulator.sh &
./wait-for-boot-completed
adb devices -l
adb shell pm dump com.google.android.gms | grep version
sleep 2
adb emu kill
