FROM ubuntu:16.04

# Register the ROCM package repository, and install rocm-dev package
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl \
  && curl -sL http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | apt-key add - \
  && printf "deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main" | tee /etc/apt/sources.list.d/rocm.list \
  && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    rocm-dev rocm-opencl-dev libnuma-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl xz-utils \
    && curl -L -O --referer https://support.amd.com https://www2.ati.com/drivers/linux/beta/ubuntu/amdgpu-pro-17.40-483984.tar.xz \
    && tar -Jxvf amdgpu-pro-17.40-483984.tar.xz \
    && rm amdgpu-pro-17.40-483984.tar.xz \
    && ./amdgpu-pro-17.40-483984/amdgpu-pro-install -y \
    && rm -r amdgpu-pro-17.40-483984 \
    && echo 'export LLVM_BIN=/opt/amdgpu-pro/bin' | tee /etc/profile.d/amdgpu-pro.sh \
    && apt-get -y remove ca-certificates curl xz-utils \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

COPY donate-level.patch /tmp

RUN apt-get update \
    && apt-get -y --no-install-recommends install ca-certificates curl build-essential cmake libuv1-dev ocl-icd-opencl-dev opencl-headers git \
    && git clone https://github.com/xmrig/xmrig-amd.git \
    && git -C xmrig-amd apply ../donate-level.patch \
    && cd xmrig-amd \
    && mkdir build \
    && cd build \
    && cmake -DOpenCL_INCLUDE_DIR=/usr/include/CL -DWITH_HTTPD=OFF .. \
    #&& cmake .. -DOpenCL_INCLUDE_DIR=/opt/rocm/opencl -DOpenCL_LIBRARY=/opt/rocm/opencl/lib/x86_64/libamdocl64.so -DWITH_HTTPD=OFF \
    && make \
    && cd ../.. \
    && mv xmrig-amd/build/xmrig-amd /usr/local/bin/xmrig-amd \
    && chmod a+x /usr/local/bin/xmrig-amd \
    && rm -r xmrig-amd \
    && apt-get -y remove ca-certificates curl build-essential cmake libuv1-dev ocl-icd-opencl-dev \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

ENTRYPOINT ["xmrig-amd"]
CMD ["-h"]
