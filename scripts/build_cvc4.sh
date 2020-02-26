#!/bin/bash
set -e

# Build CVC4
cd /build && git clone https://github.com/CVC4/CVC4
cd CVC4 && git checkout 596fe8c7
./contrib/get-antlr-3.4
./configure.sh --prefix=/usr/local
cd build && make -j8
# Install CVC4
sudo make install
