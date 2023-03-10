FROM python:3.10-slim-bullseye

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
        unzip \
        libcairo2 \
        gdb \
        git \
    && git clone --depth 1 -b master \
        https://github.com/project-chip/connectedhomeip \
    && cp -r connectedhomeip/credentials /app/credentials \
    && mv /app/credentials/production/paa-root-certs/* \
          /app/credentials/development/paa-root-certs/ \
    && rm -rf connectedhomeip \
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
