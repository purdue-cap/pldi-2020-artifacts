FROM debian:buster
COPY ./scripts /scripts
RUN /scripts/prepare.sh

COPY --chown=user ./cvc4_runscripts /home/user
COPY ./loopinvgen-lib.zip /build
COPY ./EUSolver-2018.zip /build
COPY ./benchmarks.zip /build

USER user
RUN /scripts/build_z3.sh
RUN /scripts/build_dryadsynth.sh
RUN /scripts/build_cvc4.sh
RUN /scripts/extract_loopinvgen_starexec.sh
RUN /scripts/extract_eusolver_starexec.sh
RUN /scripts/extract_benchmarks.sh
WORKDIR /home/user
CMD /bin/bash