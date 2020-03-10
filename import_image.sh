#!/bin/bash
set -e

if command -v md5sum >/dev/null 2>&1; then
    if md5sum -c dryadsynth.tar.xz.md5; then
        xz -d -c dryadsynth.tar.xz | docker load
    else
        echo 'Checksum mismatch, file may be corrupted!'
        exit 1
    fi
else
    echo 'md5sum command not found on your system'
    echo 'Please manually check md5 of dryadsynth.tar.xz to be matching:'
    cat dryadsynth.tar.xz.md5
    echo 'Press enter to continue loading the image...'
    read
    xz -d -c dryadsynth.tar.xz | docker load
fi

