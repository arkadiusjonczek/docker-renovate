FROM cgr.dev/chainguard/wolfi-base:latest AS builder

RUN apk update && \
    apk add --no-cache \
        nodejs-26 \
        npm

WORKDIR /app

RUN npm install -g renovate

FROM cgr.dev/chainguard/wolfi-base:latest

ENV RENOVATE_BINARY_SOURCE=global

WORKDIR /usr/src/app

RUN apk update && \
    apk add --no-cache \
        ca-certificates \
        curl \
        nodejs-26 \
        git \
        openssh-client \
        go-1.27 \
        python-3.15 \
        py3.15-pip \
        openjdk-27-jre \
        maven \
        gradle \
        docker

COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules
COPY --from=builder /usr/local/bin/renovate /usr/local/bin/renovate

ENTRYPOINT ["/usr/bin/renovate"]
