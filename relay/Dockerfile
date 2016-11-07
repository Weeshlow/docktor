FROM alpine:latest
MAINTAINER Flare flare@torworld.org

# Expose default ports
EXPOSE 9001 9030

# Expose tor fingerprints
VOLUME ["/root/.tor"]

# Update APK and install dependencies
RUN apk --update upgrade && \
    apk add alpine-sdk libevent-dev openssl-dev

# Download Tor source
WORKDIR /tmp
ADD https://dist.torproject.org/tor-0.2.8.9.tar.gz ./
RUN tar zxvf tor-0.2.8.9.tar.gz

# Configure source, install and remove source
WORKDIR /tmp/tor-0.2.8.9
RUN ./configure && \
    make install && \
    rm -rf /tmp/tor-0.2.8.9

# Add entrypoint
WORKDIR /root/
ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
