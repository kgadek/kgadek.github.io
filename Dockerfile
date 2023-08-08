FROM debian:bullseye-slim as builder
LABEL maintainer="kgadek@gmail.com"

ARG ZOLA_VER=0.17.2

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://github.com/getzola/zola/releases/download/$ZOLA_VER/zola-$ZOLA_VER-x86_64-unknown-linux-gnu.tar.gz | tar zxvf - -C /usr/local/bin


FROM debian:bullseye-slim
COPY --from=builder /usr/local/bin/zola /usr/local/bin/zola
