#lordius/alpine-base:v3.4
FROM alpine:3.4
MAINTAINER lordius<andriy.khomych@gmail.com>

#Update indexed
RUN apk update \
    apk upgrade 
    
#install aditional software, for me nano editor
RUN apk add --no-cache autoconf postfix icu-dev\
    apk-cron ca-certificates curl \
    bash build-base diffutils  git rsync \
    imagemagick imap less libtool linux-headers musl \
    nano openssl-dev patch patchutils gcc g++ make \
    perl pcre-dev jpeg-dev libmcrypt-dev bzip2-dev fcgi-dev \
    tar wget xz zlib-dev imagemagick-dev sed re2c m4 acl-dev \
    libpng-dev libxslt-dev postgresql-dev perl-dev file libedit-dev \
    libxml2-dev imap-dev cyrus-sasl-dev
    
#install ssh
RUN apk add --update openssh
		
# Configure git
RUN git config --global user.name "Lordius Base" && \
    git config --global user.email "admin@lordius.com" && \
    git config --global push.default current
    
#Clean trash
RUN  rm -rf /var/lib/apt/lists/* && \
     rm -rf /var/cache/apk/* && \
     rm -rf /var/www/localhost/htdocs/*
