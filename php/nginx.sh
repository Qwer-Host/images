#!/bin/bash

printf "%s%s%s\n" \
	"http://nginx.org/packages/alpine/v" \
    	`egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    	"/main" \
    	| tee -a /etc/apk/repositories

curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
	openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout && \
    	mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/

ALPINE_VERSION=$(grep '^VERSION_ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$ALPINE_VERSION" == 3.16.* ]]; then
    NGINX_VERSION="1.26.1-r2"
else
    NGINX_VERSION="1.26.2-r1"
fi

apk add nginx=$NGINX_VERSION

chown -R container:container /srv/start.sh
chmod +x /srv/start.sh
