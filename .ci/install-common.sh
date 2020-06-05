#!/bin/bash -e

[ "${SUDO:-}" == "sudo" ] && travis=true || travis=false

# docker container only
$travis || [ -f /usr/bin/autoreconf ] || apt install -yq autoconf autopoint libtool pkg-config
