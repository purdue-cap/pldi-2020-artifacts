#!/bin/bash
set -e

cd /home/user && unzip /build/EUSolver-2018.zip
mv EUSolver-2018 EUSolver

chmod +x EUSolver/thirdparty/Python-3.5.1/python3
cat > EUSolver/bin/eusolver.sh << 'EOF'
#!/bin/bash
BASE=$(dirname $0)
BENCH=$(realpath $1)
cd $BASE && exec ./starexec_run_python3 $BENCH
EOF

chmod +x EUSolver/bin/eusolver.sh