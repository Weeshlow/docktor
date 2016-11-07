FROM alpine:latest
MAINTAINER Flare flare@torworld.org

# Expose default ports
EXPOSE 9001 9030 80

# Expose tor fingerprints
VOLUME ["/root/.tor"]

# Update APK and install dependencies
RUN apk --update upgrade && \
    apk add alpine-sdk libevent-dev openssl-dev nginx

# Configure Nginx
WORKDIR /root
ADD https://github.com/torworld/fastexit-website-template/archive/master.zip .
RUN unzip master.zip && \
    mv fastexit-website-template-master/* /var/lib/nginx/html/ && \
    rm -rf master.zip fastexit-website-template-master

# Download Tor source
WORKDIR /tmp
ADD https://dist.torproject.org/tor-0.2.8.9.tar.gz ./
RUN tar zxvf tor-0.2.8.9.tar.gz

# Configure source, install and remove source
WORKDIR /tmp/tor-0.2.8.9
RUN ./configure && \
    make install && \
    rm -rf /tmp/tor-0.2.8.9

# Add Advanced Policies to torrc
WORKDIR /root
ADD https://raw.githubusercontent.com/torworld/fastexit/master/exitpolicy.txt .
RUN cat exitpolicy.txt | tee -a /usr/local/etc/tor/torrc

# Add entrypoint
ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
