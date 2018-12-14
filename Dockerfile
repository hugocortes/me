FROM alpine:latest AS builder

ENV VERSION 0.42
ENV ARCH linux-64bit

ARG baseURL=https://resume.hugocortes.me
ENV BASE_URL=$baseURL

RUN apk add --no-cache curl git rsync

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz | tar -xz
RUN mv hugo /usr/local/bin/hugo
RUN addgroup -Sg 1000 hugo

RUN mkdir -p /var/www/me
RUN adduser -SG hugo -u 1000 -h /var/www/me hugo

# add theme
RUN mkdir -p /var/www/me/themes
RUN git init
RUN git submodule add https://github.com/hugocortes/hugo-resume.git /var/www/me/themes/resume

# automatically build site
COPY content/ /var/www/me/content
COPY data/ /var/www/me/data
COPY static /var/www/me/static
COPY config.toml /var/www/me

# serve site
WORKDIR /var/www/me

RUN hugo --baseURL=$BASE_URL

FROM nginx
COPY --from=builder /var/www/me/public /usr/share/nginx/html
