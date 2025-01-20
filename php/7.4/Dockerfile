FROM php:7.4.33-fpm-alpine3.16

RUN apk --update --no-cache add openssl curl ca-certificates

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions exif soap gmp pdo_odbc zip mysqli pdo_pgsql bcmath gd odbc pdo_mysql gettext bz2 pdo_dblib


RUN adduser -D -h /home/container container

COPY ../nginx.sh /tmp/nginx.sh
COPY ../start.sh /srv/start.sh
RUN sh /tmp/nginx.sh && rm -rf /tmp/nginx.sh

USER container
ENV  USER=container
ENV  HOME=/home/container

WORKDIR /home/container
COPY ../entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
