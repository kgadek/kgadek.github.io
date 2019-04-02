FROM debian:buster-slim as builder
LABEL maintainer="kgadek@gmail.com"

ARG ZOLA_VER

RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://github.com/getzola/zola/releases/download/$ZOLA_VER/zola-$ZOLA_VER-x86_64-unknown-linux-gnu.tar.gz | tar zxvf - -C /usr/local/bin


FROM debian:buster-slim
COPY --from=builder /usr/local/bin/zola /usr/local/bin/zola
