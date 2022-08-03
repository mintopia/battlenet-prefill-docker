FROM alpine:3 AS download
ARG PREFILL_VERSION=1.3.0

RUN \
    cd /tmp && \
    wget -O BattleNetPrefill.zip https://github.com/tpill90/battlenet-lancache-prefill/releases/download/v${PREFILL_VERSION}/linux-x64.zip && \
    unzip BattleNetPrefill && \
    ls -alh && \
    chmod +x BattleNetPrefill-linux-x64\\BattleNetPrefill


FROM ubuntu:22.04
LABEL maintainer="jess@mintopia.net"
ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
RUN \
    apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /app

COPY --from=download /tmp/BattleNetPrefill-linux-x64\\BattleNetPrefill /app/BattleNetPrefill

WORKDIR /app
ENTRYPOINT [ "/app/BattleNetPrefill" ]
