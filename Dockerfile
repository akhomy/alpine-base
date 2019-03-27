# akhomy/alpine-base
ARG ALPINE_VER=latest
FROM alpine:${ALPINE_VER}
LABEL maintainer=andriy.khomych@gmail.com
ARG IMAGE_EXTENSIONS=minimal
ENV IMAGE_EXTENSIONS=${IMAGE_EXTENSIONS}
# Creates /temp_dir for using.
RUN mkdir /temp_docker && chmod -R +x /temp_docker && cd /temp_docker
RUN mkdir /temp_docker/extensions && chmod -R +x /temp_docker/extensions
RUN mkdir /tools && chmod -R +x /tools
# Init.
COPY tools/ /tools/
# Copies extensions.
COPY extensions/ /temp_docker/extensions
# Installs extensions.
RUN /bin/sh /tools/installer.sh ${IMAGE_EXTENSIONS} /temp_docker/extensions /temp_docker/extensions/
# Cleans.
COPY tools/clean.sh /tools
RUN /bin/sh /tools/clean.sh
