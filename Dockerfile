# akhomy/alpine-base
ARG ALPINE_VER=latest
FROM alpine:${ALPINE_VER}
LABEL maintainer=andriy.khomych@gmail.com

ARG ALPINE_DEV
RUN set -xe; \
  \
  apk add --update --no-cache \
  bash \
  ca-certificates \
  curl \
  gzip \
  tar \
  unzip \
  wget; \
  \
  if [ -n "${ALPINE_DEV}" ]; then \
    apk --no-cache update; \
    apk --no-cache upgrade; \
    apk add --update  git \
                      libcurl \
                      curl-dev \
                      coreutils \
                      jq \
                      sed \
                      gawk \
                      grep \
                      rsync \
                      patch \
                      patchutils \
                      diffutils; \
    if [  -z $(echo "$ALPINE_DEV"|sed "/cron/d") ]; then \
      apk add --update apk-cron; \
    fi; \
    if [  -z $(echo "$ALPINE_DEV"|sed "/archives/d") ]; then \
      apk add --update \
                xz \
                p7zip \
                bzip2-dev \
                zlib-dev \
                tar; \
    fi; \
    if [  -z $(echo "$ALPINE_DEV"|sed "/editors/d") ]; then \
      apk add --update nano; \
    fi; \
    if [  -z $(echo "$ALPINE_DEV"|sed "/ssh/d") ]; then \
      apk add --update \
                sshpass \
                openssh \
                sudo; \
    fi; \
    # TODO FIX Ansible
    if [  -z $(echo "$ALPINE_DEV"|sed "/ansible/d") ]; then \
      apk --update add --virtual \
            build-dependencies \
            python-dev \
            musl-dev \
            libffi-dev \
            py-pip && \
            pip install --upgrade pip && \
            pip install git+git://github.com/ansible/ansible.git@stable-2.2; \
    fi; \
    if [[ "$ALPINE_DEV" == *"ssl"* ]]; then \
      apk add --update openssl; \
    fi; \
  fi;

# Cleans trash.
RUN  rm -rf /var/lib/apt/lists/* && \
     rm -rf /var/cache/apk/*
