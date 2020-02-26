FROM debian:buster
COPY ./scripts /scripts
RUN /scripts/prepare.sh

COPY --chown=user ./cvc4_runscripts /home/user

USER user
RUN /scripts/build_z3.sh
RUN /scripts/build_dryadsynth.sh
RUN /scripts/build_cvc4.sh
RUN /scripts/build_loopinvgen.sh
WORKDIR /home/user
CMD /bin/bash