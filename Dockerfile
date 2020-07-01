FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

USER root

# Set time
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Set the locale
RUN apt-get update && apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8 C.UTF-8/' /etc/locale.gen && \
    locale-gen

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
    doxygen \ 
    graphviz \
    mscgen \ 
    roffit \
    perl \
    git \
    python \
    cmake \
    gcc \
    xsltproc \
    bison \
    flex \
    gcc-multilib \
    pkg-config \ 
    libssl-dev \
    libssl-dev:i386 \
    libc6-dev:i386 \
    libusb-1.0-0-dev:i386 \
    libusb-1.0.0-dev \
    libjson-c-dev:i386 \
    openjdk-8-jre \
    curl 

