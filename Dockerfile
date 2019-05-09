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

# add 'gitpod' user and permit "sudo -u seluser". 'seluser' is the standard user from selenium.
RUN addgroup --gid 33333 gitpod \
 && useradd --no-log-init --create-home --home-dir /home/gitpod --shell /bin/bash --uid 33333 --gid 33333 gitpod \
 && echo "gitpod ALL=(seluser) NOPASSWD: ALL" >> /etc/sudoers

USER gitpod

RUN cd /home/gitpod/ \
  && wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz \
  && tar xf flutter_linux_v1.5.4-hotfix.2-stable.tar.xz \
  && rm flutter_linux_v1.5.4-hotfix.2-stable.tar.xz

ENV PATH=$PATH:/home/gitpod/flutter/bin:/home/gitpod/flutter/.pub-cache/bin:/home/gitpod/flutter/bin/cache/dart-sdk/bin