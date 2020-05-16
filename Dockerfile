#########################
# gohugo static builder #
#########################
FROM alpine:latest AS builder

ENV VERSION 0.69.0
ENV ARCH linux-64bit

ARG baseURL=https://hugocortes.dev
ENV BASE_URL=$baseURL

RUN apk add --no-cache curl git rsync

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz | tar -xz
RUN mv hugo /usr/local/bin/hugo

RUN mkdir -p /var/www/me
WORKDIR /var/www/me

# copy required contents
COPY content/ content
COPY data/ data
COPY static/ static
COPY config.toml .

# init submodule
COPY .gitmodules .
COPY .git/ .git
COPY themes/ themes
RUN git submodule init
RUN git submodule update
RUN rm -rf .git .gitmodules

# build site
RUN hugo --minify --baseURL=$BASE_URL

#########################
# nginx image server    #
#########################
FROM nginx:alpine

COPY --from=builder /var/www/me/public /usr/share/nginx/html
RUN chown -R 1000:0 /usr/share/nginx/html
RUN chmod -R g+rw /usr/share/nginx/html
