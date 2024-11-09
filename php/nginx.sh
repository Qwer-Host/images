#!/bin/bash

printf "%s%s%s\n" \
	"http://nginx.org/packages/alpine/v" \
    	`egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    	"/main" \
    	| tee -a /etc/apk/repositories

curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
	openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout && \
    	mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/

apk add nginx=1.26.2-r1

chown -R container:container /srv/start.sh
chmod +x /srv/start.sh
