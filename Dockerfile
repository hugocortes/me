FROM alpine:latest

RUN apk add --no-cache \
    curl \
    git \
    openssh-client \
    rsync

ENV VERSION 0.42
ENV ARCH linux-64bit

RUN mkdir -p /usr/local/src \
    && cd /usr/local/src \
    && curl -L https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz | tar -xz \
    && mv hugo /usr/local/bin/hugo \
    && addgroup -Sg 1000 hugo \
    && adduser -SG hugo -u 1000 -h /src hugo

RUN mkdir /src/resume

# add theme
RUN mkdir -p /src/resume/themes
RUN git init
RUN git submodule add https://github.com/hugocortes/hugo-resume.git /src/resume/themes/resume

# automatically build site
COPY content/ /src/resume/content
COPY data/ /src/resume/data
COPY static /src/resume/static
COPY config.toml /src/resume

# serve site
WORKDIR /src/resume

# Expose port
EXPOSE 1313

ENV BASE_URL=$baseURL

CMD hugo server --baseURL=$BASE_URL --appendPort=false --bind=0.0.0.0
