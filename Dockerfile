FROM --platform=linux/loongarch64 ubuntu:18.04

# Package `tzdata` should be installed to make the environment variable `TZ` work.
# Setting DEBIAN_FRONTEND=noninteractive suppresses the interactive timezone prompt.
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive

# If you are building on a non-LoongArch machine, use docker buildx with --platform or enable binfmt/qemu on the host.
# Example: docker buildx build --platform=linux/loongarch64 -t myimage:loongarch .

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        tzdata \
        build-essential \
        make \
        zlib1g-dev \
        libudev1 libudev-dev \
        libpci-dev \
        libpciaccess-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/* /var/log/*
