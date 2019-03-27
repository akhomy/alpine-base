#!/bin/bash
apk --no-cache update;
apk --no-cache upgrade;
apk add --update \
                coreutils \
                curl-dev \
                diffutils \
                gawk \
                git \
                grep \
                jq \
                libcurl \
                patch \
                patchutils \
                rsync \
                sed \
                ;
