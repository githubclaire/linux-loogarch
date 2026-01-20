# 使用龙芯旧世界官方基础镜像（Kylin V10 SP1 兼容）
FROM cr.loongnix.cn/library/debian:buster
 
# 设置环境变量及工具链
ENV LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        gcc \
        make \
        binutils \
        linux-headers-$(uname -r) \
        # 安装 libpci 依赖 
        libkmod-dev \
        zlib1g-dev
 
# 固定安装 libpci 3.6.4 
RUN wget https://mirrors.edge.kernel.org/pub/software/utils/pciutils/pciutils-3.6.4.tar.gz  && \
    tar -xzf pciutils-3.6.4.tar.gz && \
    cd pciutils-3.6.4 && \
    make PREFIX=/usr SHAREDIR=/usr/share/hwdata install install-lib && \
    cd .. && \
    rm -rf pciutils*
 
# 编译安装 glibc 2.28
RUN wget https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz  && \
    tar -xzf glibc-2.28.tar.gz && \
    mkdir glibc-build && cd glibc-build && \
    ../glibc-2.28/configure \
        --prefix=/usr \
        --disable-profile \
        --enable-add-ons \
        --with-headers=/usr/include \
        --without-selinux \
        --disable-werror && \  
    make -j$(nproc) && \
    make install && \
    ldconfig && \  
    cd .. && \
    rm -rf glibc-*
 
# 验证安装 
RUN strings /lib/mips64el-linux-gnuabi64/libc.so.6 | grep GLIBC_2.28 && \
    lspci --version | grep "3.6.4"
