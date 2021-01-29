#!/bin/bash -ex

wd=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PY_VER=3.6.9 \
arch=arm64 \
toolchain=aarch64-linux-gnu \
$wd/install-arm.sh
