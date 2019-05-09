FROM ubuntu

RUN apt-get update && apt-get install -y \
  bash \
  curl \
  git \
  unzip \
  xz-utils \
  wget \
  net-tools \
  tcpdump \
  sudo \
  lib32stdc++6 \
  libglu1-mesa

RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/gitpod

USER gitpod

RUN cd /home/gitpod/ \
  && wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz \
  && tar xf flutter_linux_v1.5.4-hotfix.2-stable.tar.xz \
  && rm flutter_linux_v1.5.4-hotfix.2-stable.tar.xz

ENV PATH=$PATH:/home/gitpod/flutter/bin:/home/gitpod/flutter/.pub-cache/bin:/home/gitpod/flutter/bin/cache/dart-sdk/bin