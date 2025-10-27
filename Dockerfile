FROM alpine:edge

# Install Clevis and its dependencies from edge/testing repository
# https://pkgs.alpinelinux.org/packages?name=clevis
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    clevis \
    jose \
    curl \
    jq \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /work

ENTRYPOINT ["clevis"]
CMD ["--help"]
