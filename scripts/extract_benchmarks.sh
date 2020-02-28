#!/bin/bash
set -e

cd /home/user && unzip /build/benchmarks.zip
cp -f /scripts/run_benchmarks.py /home/user/
cp -f /scripts/analyze_stats.py /home/user/
