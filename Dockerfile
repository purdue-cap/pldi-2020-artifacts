FROM debian:buster
COPY ./scripts /scripts
RUN /scripts/prepare.sh

USER user
RUN /scripts/build_z3.sh
RUN /scripts/build_dryadsynth.sh
WORKDIR /home/user
CMD /bin/bash