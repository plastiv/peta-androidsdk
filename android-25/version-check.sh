#!/bin/bash
set -x #echo on

which adb
which android
which emulator
which avdmanager
which sdkmanager
java -Xmx32m -version
java -Xmx32m -jar $ANDROID_HOME/tools/proguard/lib/proguard.jar
sdkmanager --list