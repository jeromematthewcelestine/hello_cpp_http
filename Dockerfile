# Get the base Ubuntu image from Docker Hub 
FROM ubuntu:latest 

# Update required apps on the base image 
RUN apt-get -y update && apt-get install -y 

# Set up pkg config on the container
RUN apt-get -y update
RUN apt-get -y install software-properties-common

# Add Pistache dependency PPA repo

RUN add-apt-repository ppa:pistache+team/unstable

# Update repos and install required dependencies
RUN apt-get -y update
RUN apt-get -y install g++ cmake pkg-config libpistache-dev

# Copy the current folder which contains C++ source code to the Docker image 
COPY . . 

# Specify the working directory 
WORKDIR . 

# Create build dir, configure CMake and run build 
RUN mkdir build 
RUN cmake -B/build -S/ 
RUN cmake --build /build

EXPOSE 9080

# Run the built application 
CMD ./build/httpserver_run