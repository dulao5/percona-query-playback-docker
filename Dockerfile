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

# Set the working directory
WORKDIR /usr/src/app

# Copy the source code into the container
COPY . .

# Run cmake and make to build the project
RUN mkdir -p build_dir && cd build_dir && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && make
RUN cd build_dir && make install

# Define the entrypoint if needed (optional)
ENTRYPOINT ["percona-playback"]
