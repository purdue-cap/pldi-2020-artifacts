#!/bin/bash
set -e

export OPAM_VERSION=2.0.5

# Install opam
cd /build && curl -L -o opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)"
sudo install -m755 ./opam /usr/local/bin/opam
cd /home/user
opam init --auto-setup --disable-sandboxing --yes --compiler=$OCAML_VERSION && opam clean
# Install dependencies from opam
opam install --yes alcotest.0.8.5 \
                       core.v0.13.0 \
                       dune.2.1.2 \
                       ppx_let.v0.13.0 \
                       && opam clean --yes
# Install LoopInvGen
eval $(opam config env)
git clone https://github.com/SaswatPadhi/LoopInvGen
cd LoopInvGen && git checkout master
./scripts/build_all.sh --with-logging
mkdir -p _dep && ln -s /usr/local/bin/z3 _dep/z3

# Setup opam environment
echo 'eval $(opam config env)' >> /home/user/.bashrc


