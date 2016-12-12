FROM alpine:latest
MAINTAINER Flare flare@torworld.org

# Expose Nginx port
EXPOSE 80 443

# Expose tor fingerprints
VOLUME ["/root/.tor"]

# Get Tor Version
ARG TOR_VERSION

# Update APK and install dependencies
RUN apk --update upgrade && \
    apk add nginx

# Configure Nginx
WORKDIR /root
ADD https://github.com/torworld/fastexit-website-template/archive/master.zip .
RUN unzip master.zip && \
    mv fastexit-website-template-master/* /var/lib/nginx/html/ && \
    rm -rf master.zip fastexit-website-template-master

# Add Advanced Policies to torrc
WORKDIR /root
ADD https://raw.githubusercontent.com/torworld/fastexit/master/policies/exitpolicy.txt .
RUN cat exitpolicy.txt | tee -a /usr/local/etc/tor/torrc
