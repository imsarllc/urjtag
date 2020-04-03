#!/bin/bash -ex

[ "${SUDO:-}" == "sudo" ] && travis=true || travis=false

wd=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

build=x86_64

# docker container only
$travis || ($wd/install-$build.sh && $wd/clean.sh)

pushd urjtag

! $travis || sed --in-place -e '/GETTEXT_VERSION/s/0.19/0.18/' configure.ac

# `export` required for setup.py
export CC=gcc
prefix=$wd/usr
PYTHON=/usr/bin/python3.5 ./autogen.sh \
 --enable-svf \
 --enable-bsdl \
 --enable-stapl \
 --enable-relocatable --prefix=$prefix
make -j$(nproc)
! $travis || git checkout HEAD $(git rev-parse --show-toplevel)/urjtag/configure.ac
find . -name "*urjtag*.so*"

make install

$wd/package.sh \
 amd64 \
 $prefix/bin/jtag \
 $prefix/share/urjtag \
 src/.libs/liburjtag.so.0.0.0 \
 bindings/python/build/lib.linux-$build-3.5/urjtag.cpython-35m-$build-linux-gnu.so

popd # urjtag
