# JLink
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1 -SelectEmuBySN'
alias jlc='JLinkRTTClient'
alias jl91='JLinkExe -if SWD -speed 4000 -device NRF9160_XXAA -autoconnect 1'
export JLINK_TARGET=682486629

# NRF Connect SDK
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH="/opt/gcc-arm-none-eabi-9-2019-q4-major"

# Flutter
export PATH=~/work/android/flutter/bin:$PATH
export PATH=~/work/android/cmdline-tools/latest/bin:$PATH
export ANDROID_SDK_ROOT=~/work/android
export CHROME_EXECUTABLE=/opt/google/chrome/chrome
