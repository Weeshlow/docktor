
FROM alpine:latest
MAINTAINER Flare flare@torworld.org

# Expose default ports
EXPOSE 9001 9030

# Expose tor fingerprints
VOLUME ["/root/.tor"]

# Get Tor Version
ARG TOR_VERSION

# Update APK and install dependencies
RUN apk --update upgrade && \
    apk add alpine-sdk libevent-dev openssl-dev

# Download Tor source
WORKDIR /tmp
ADD https://dist.torproject.org/tor-${TOR_VERSION}.tar.gz ./
RUN tar zxvf tor-${TOR_VERSION}.tar.gz

# Configure source, install and remove source
WORKDIR /tmp/tor-${TOR_VERSION}
RUN ./configure && \
    make install && \
    rm -rf /tmp/tor-${TOR_VERSION}
