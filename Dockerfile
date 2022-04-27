# syntax=docker/dockerfile-upstream:experimental

FROM ubuntu:latest

ENV RUST_TOOLCHAIN="1.60.0" \
    DEBIAN_FRONTEND="noninteractive" \
    TZ="UTC" \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    CARGO_TARGET_DIR=/tmp/target \
    RUSTC_FLAGS='-C target-cpu=x86-64' \
    PORTABLE=ON \
    CARGO_NET_GIT_FETCH_WITH_CLI=true

RUN apt-get update -qq && apt-get install -y \
    git \
    cmake \
    g++ \
    pkg-config \
    libssl-dev \
    curl \
    llvm \
    clang \
    binutils-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libdw-dev \
    libiberty-dev \
    gcc \
    protobuf-compiler \
    libssl-dev \
    npm \
    && npm i -g corepack \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://sh.rustup.rs -sSf | \
    sh -s -- -y --no-modify-path --default-toolchain "${RUST_TOOLCHAIN}" \
    && rustup install  nightly-2021-03-25 \
    && rustup target add wasm32-unknown-unknown

RUN mkdir /engine && cd /engine && git clone https://github.com/aurora-is-near/aurora-engine.git . && ln -s /tmp/target /engine/target && make ; make -B mainnet ; make -B testnet ; make debug ; make -B mainnet-debug ; make -B testnet-debug
RUN rm -Rf /engine /tmp/*

RUN mkdir /engine && cd /engine && git clone https://github.com/aurora-is-near/aurora-engine.git . && ln -s /tmp/target /engine/target && mkdir /output
VOLUME /output

COPY compile.sh /usr/local/bin/compile.sh
RUN chmod a+x /usr/local/bin/compile.sh

WORKDIR /engine

ENTRYPOINT ["/usr/local/bin/compile.sh"]

# docker build -t aurora-engine-build -f Dockerfile .
