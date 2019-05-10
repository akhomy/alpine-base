#!/bin/bash
set -xe \
&& \
apk add --no-cache --purge -uU \
                                ca-certificates \
                                curl \
                                openssh-client \
                                sudo \
                                && \
                                apk --update add --virtual \
                                .build-dependencies \
                                build-base \
                                libffi-dev \
                                py-pip \
                                python-dev \
&& \
pip install --upgrade pip \
&& \
pip install --no-cache --upgrade ansible \
&& \
apk del --purge .build-dependencies \
&& \
mkdir -p /etc/ansible \
&& \
echo 'localhost' > /etc/ansible/hosts
# pip install --no-cache --upgrade git+git://github.com/ansible/ansible.git@stable-2.2
