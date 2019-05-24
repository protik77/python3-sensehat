FROM arm32v7/debian:jessie-slim
LABEL maintainer="Protik Das <protik77@gmail.com>"

# needed for automated build in docker hub.
# for details, see: https://github.com/docker/hub-feedback/issues/1261
COPY qemu-arm-static /usr/bin

# install the necessary software
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    python3-numpy \
    python3-pil

# do all the installation in /tmp directory
WORKDIR /tmp

# set the version using a variable
ARG RTIMULIB_VERSION=7.2.1-3

# get all th required libraries
RUN curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python3-sense-hat_2.2.0-1_armhf.deb

# install the required libraries
RUN dpkg -i \
    librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
    python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
    python3-sense-hat_2.2.0-1_armhf.deb

# cleanups
RUN rm -f /tmp/*.deb \
   && apt-get clean \ 
   && rm -rf /var/lib/apt/lists/*

# setup test directory and copy the test code
RUN mkdir /code
ADD test.py /code/test.py
WORKDIR /code

# command to run if no command specified
CMD ["python3", "test.py"]
