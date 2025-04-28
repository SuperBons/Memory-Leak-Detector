# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set the environment variables to avoid interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install dependencies
RUN apt-get update && \
    apt-get install -y cmake g++ doxygen git zlib1g-dev libunwind-dev libsnappy-dev liblz4-dev \
    build-essential curl wget python3 \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /root

# Clone the DynamoRIO repository
RUN git clone --recurse-submodules -j4 https://github.com/DynamoRIO/dynamorio.git

# Build DynamoRIO from source
WORKDIR /root/dynamorio
RUN mkdir build && cd build && cmake .. && make -j

# Set up environment variables for DynamoRIO
ENV DYNAMORIO_HOME=/root/dynamorio/build

# Set the entry point for the container
CMD ["bash"]