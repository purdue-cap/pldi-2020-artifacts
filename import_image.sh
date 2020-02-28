#!/bin/bash
set -e

if md5sum -c dryadsynth.tar.xz.md5; then
    xz -d -c dryadsynth.tar.xz | docker load
else
    echo 'Checksum mismatch, file may be corrupted!'
    exit 1
fi