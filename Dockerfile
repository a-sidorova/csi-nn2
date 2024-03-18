FROM ubuntu:22.04
USER root
WORKDIR /

# Install Packages
RUN apt update && apt upgrade -y && apt install -y \
    apt-utils autoconf automake build-essential curl nano fdupes wget \
    git ca-certificates crossbuild-essential-riscv64 cmake make && \
    rm -rf /var/lib/apt/lists/*

# Install cmake
RUN git clone https://github.com/a-sidorova/csi-nn2 -b feature/c920_rvv_for_c910
RUN wget https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1663142514282/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1-20220906.tar.gz && \
    tar xf Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1-20220906.tar.gz

RUN export PATH=/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1/bin:$PATH && cd csi-nn2 && make nn2_rvv
RUN cd example && export PATH=/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1/bin:$PATH && make rvv
