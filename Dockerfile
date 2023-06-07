FROM python:3.11-slim-bullseye

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /app

RUN \
    set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libuv1 \
        openssl \
        zlib1g \
        libjson-c5 \
        libnl-3-200 \
        libnl-route-3-200 \
        unzip \
        libcairo2 \
        gdb \
        git \
    && apt-get purge -y --auto-remove \
    && rm -rf \
        /var/lib/apt/lists/* \
        /usr/src/*

# get the code from python-matter-server
RUN git init . && git remote add origin https://github.com/home-assistant-libs/python-matter-server.git && git pull origin main

COPY . ./

# hadolint ignore=DL3013
RUN \
    pip3 install -U pip && \
    pip3 install --no-cache-dir .[server]

VOLUME ["/data"]
EXPOSE 5580

ENTRYPOINT ["./docker-entrypoint.sh"]
