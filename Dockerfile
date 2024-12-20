FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

ENV PROJECT=zoe-depth
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# 替换软件源为阿里云镜像源
RUN sed -i 's@/archive.ubuntu.com/@/mirrors.aliyun.com/@g' /etc/apt/sources.list && \
    sed -i 's@/security.ubuntu.com/@/mirrors.aliyun.com/@g' /etc/apt/sources.list

# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libhdf5-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    pkg-config \
    wget \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-wheel \
    python3-setuptools \
    python3-dev

# 验证pip版本
RUN pip3 --version

# 安装指定版本的pip
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip==21.2.3 && \ 
    apt-get install -y python3 

# Intall Anaconda
# COPY ./third_parth/Anaconda3-2024.10-1-Linux-x86_64.sh /app/
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

ENV PATH="/opt/conda/bin:$PATH"


# Expose jupyter notebook port
EXPOSE 8888

# 设置工作目录
RUN mkdir -p /workspace/${PROJECT}

# Copy project to workspace folder
WORKDIR /workspace/${PROJECT}
# COPY . /workspace/${PROJECT}

