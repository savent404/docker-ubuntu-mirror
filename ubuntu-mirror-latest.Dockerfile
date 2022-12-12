FROM ubuntu:latest

# mirror for tsinghua
RUN sed -i 's/^\(deb\|deb-src\) \([^ ]*\) \(.*\)/\1 mirrors.tuna.tsinghua.edu.cn/ubuntu-ports \3/' /etc/apt/sources.list

# update apt resource
RUN apt-get update && apt-get clean

# install some package
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git
