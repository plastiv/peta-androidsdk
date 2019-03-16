FROM plastiv/android-sdk

ARG EMULATOR_API_LEVEL
ARG EMULATOR_VARIANT
ARG EMULATOR_ARCH

# Update AndroidSDK
# Get ids from sdkmanager --list
RUN yes 'y' | sdkmanager --licenses >/dev/null \
    && yes 'y' | sdkmanager "system-images;android-${EMULATOR_API_LEVEL};${EMULATOR_VARIANT};${EMULATOR_ARCH}" >/dev/null
