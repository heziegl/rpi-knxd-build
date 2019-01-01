# Pull base image
FROM resin/rpi-raspbian:stretch
MAINTAINER Heiko Ziegler <git@z5r.de>

# Install dependencies
RUN     apt-get update && \
        apt-get install -y git-core build-essential dh-systemd autoconf libtool libusb-1.0-0-dev pkg-config libsystemd-dev libev-dev cmake


ARG     VERSION

RUN	git clone https://github.com/knxd/knxd.git && \
	cd knxd && \
	git checkout ${VERSION}

RUN	cd knxd && \
	dpkg-buildpackage -b -uc


# copy results out of the container
VOLUME  /dist
CMD     if [ -d /dist ]; then cp /*.deb /dist; fi

#CMD bash

