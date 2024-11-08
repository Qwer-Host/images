FROM alpine:latest

RUN apk --update --no-cache add openssl curl ca-certificates

RUN printf "%s%s%s\n" \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories

RUN curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
    openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout && \
    mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/

RUN apk add nginx=1.26.2-r1

RUN adduser -D -h /home/container container

RUN mkdir -p /home/container/nginx && cp /etc/nginx/nginx.conf /home/container/nginx/.
RUN chown -R container:container /home/container/*

USER container
ENV  USER=container
ENV  HOME=/home/container

WORKDIR /home/container
