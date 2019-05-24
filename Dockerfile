FROM arm32v7/ubuntu
MAINTAINER dima@us.ibm.com

ARG RTIMULIB_VERSION=7.2.1-4

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    apt-utils \
    ca-certificates \
    curl \
    python3-numpy \
    python3-pil

WORKDIR /tmp

RUN curl -LO  https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib//librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python3-sense-hat_2.2.0-1_armhf.deb
 
 
RUN dpkg -i \
    librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
    python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
    python3-sense-hat_2.2.0-1_armhf.deb


RUN rm -f /tmp/*.deb \
   && apt-get clean \ 
   && rm -rf /var/lib/apt/lists/*

RUN mkdir /code
ADD test.py /code/test.py
WORKDIR /code

CMD ["python3", "test.py"]
