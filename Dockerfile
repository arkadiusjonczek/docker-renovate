FROM cgr.dev/chainguard/renovate:v44.182.2 AS base

USER root

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      python3 \
      py3-pip \
      poetry \
      go \
      git \
      docker-cli

USER renovate

RUN python3 --version && go version && poetry --version && docker --version
