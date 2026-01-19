FROM tuxmake/loongarch_clang-nightly

# Package `tzdata` should be installed to make the environment variable `TZ` work
# Setting the DEBIAN_FRONTEND environment variable suppresses the prompt that lets you select the correct timezone from a menu.
ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                make tzdata \
                zlib1g-dev \
                libkmod-dev \
                libudev1 libudev-dev \
                libpci-dev \
                libpciaccess-dev \
                build-essential \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/* \
        && rm /var/log/* -r

RUN cd /tmp \
        && wget https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.6.4.tar.xz \
        && tar -xJvf pciutils-3.6.4.tar.xz \
        && cd pciutils-3.6.4 \
        && make PREFIX=/usr SHAREDIR=/usr/share/hwdata SHARED=yes \
        && make install \
        && rm -rf /tmp/pciutils-3.6.4