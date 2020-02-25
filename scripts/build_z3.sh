#!/bin/bash
set -e

# Build Z3
cd /build && git clone https://github.com/Z3Prover/z3
cd z3 && git checkout z3-4.8.7
./configure --prefix=/usr/local --java
cd build; make -j8
# Install z3
sudo make install
