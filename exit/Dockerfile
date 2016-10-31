FROM alpine:latest
MAINTAINER Flare flare@torworld.org

# Update APK and install dependencies
RUN apk --update upgrade \
    && apk add alpine-sdk libevent-dev openssl-dev nginx curl

# Download source
WORKDIR /tmp/
ADD https://dist.torproject.org/tor-0.2.8.9.tar.gz ./
RUN tar zxvf tor-0.2.8.9.tar.gz

# Configure source and make install
WORKDIR /tmp/tor-0.2.8.9/
RUN ./configure \
    && make install

# Configure TOR instance
WORKDIR /root/
ARG UPDATEENTRYPOINT
ADD entrypoint.sh ./

# Expose default ports
EXPOSE 9001 9030 80

ENTRYPOINT ["./entrypoint.sh"]
