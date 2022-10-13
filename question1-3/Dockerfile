ARG ENERGI_VERSION

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y sudo systemctl jq logrotate wget curl coreutils gnupg

ADD energi-linux-installer-with-docker.sh /

ENV GIT_VERSION_NUM=3.1.2
RUN chmod 755 /energi-linux-installer-with-docker.sh

RUN bash -c "/energi-linux-installer-with-docker.sh -c"

USER nrgstaker

EXPOSE 39797

ENTRYPOINT sudo systemctl start energi3 && /bin/bash
