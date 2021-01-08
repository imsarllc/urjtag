#!/bin/bash -ex

wd=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PY_VER=3.5 \
arch=armhf \
toolchain=arm-linux-gnueabihf \
$wd/build-arm.sh
