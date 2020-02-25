#!/bin/bash
set -e

# Build DryadSynth
cd /home/user/ && git clone https://github.com/purdue-cap/DryadSynth
cd DryadSynth && cp -f /usr/local/lib/com.microsoft.z3.jar lib/
make
echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> /home/user/.bashrc
