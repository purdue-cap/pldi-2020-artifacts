#!/bin/bash
set -e

cd /home/user && unzip /build/benchmarks.zip
cp -f /build/run_benchmarks.py /home/user/
