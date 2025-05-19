FROM centos:7

# Install dependencies
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y \
    git \
    tbb-devel \
    boost-devel \
    pkgconfig \
    cmake \
    mysql-devel \
    gcc-c++ \
    && yum clean all

RUN yum install -y make \
    && yum clean all

WORKDIR /usr/src/app

RUN git clone https://github.com/Percona-Lab/query-playback.git && \
    cd query-playback && \
    mkdir -p build_dir && cd build_dir && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && make && \
    cd build_dir && make install

ENTRYPOINT ["percona-playback"]
