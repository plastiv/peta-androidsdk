#!/bin/bash

yes 'n' | avdmanager --silent create avd \
    --name android-emulator-${EMULATOR_API_LEVEL} \
    --device "4in WVGA (Nexus S)" \
    --package "system-images;android-${EMULATOR_API_LEVEL};${EMULATOR_VARIANT};${EMULATOR_ARCH}" \
    --sdcard 64M
