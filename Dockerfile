FROM alpine:latest

ENV VERSION 0.42
ENV ARCH linux-64bit

ARG baseURL=http://localhost
ARG port=1313
ARG appendPort=true

ENV BASE_URL=$baseURL
ENV APPEND_PORT=$appendPort
ENV PORT=$port

RUN apk add --no-cache curl git rsync

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz | tar -xz
RUN mv hugo /usr/local/bin/hugo
RUN addgroup -Sg 1000 hugo
RUN adduser -SG hugo -u 1000 -h /src hugo

RUN mkdir /src/me

# add theme
RUN mkdir -p /src/me/themes
RUN git init
RUN git submodule add https://github.com/hugocortes/hugo-resume.git /src/me/themes/resume

# automatically build site
COPY content/ /src/me/content
COPY data/ /src/me/data
COPY static /src/me/static
COPY config.toml /src/me

# serve site
WORKDIR /src/me

EXPOSE 1313

CMD hugo server --baseURL=$BASE_URL --appendPort=$APPEND_PORT --port=$PORT --bind=0.0.0.0
