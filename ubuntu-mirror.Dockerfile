ARG VERSION=latest
FROM ubuntu:${VERSION}

# mirror for aliyun
RUN sed -i 's/^\(deb\|deb-src\) \([^ ]*\) \(.*\)/\1 http:\/\/mirrors.aliyun.com\/ubuntu \3/' /etc/apt/sources.list

# update apt resource
RUN apt-get update && apt-get clean

# install some package
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git
