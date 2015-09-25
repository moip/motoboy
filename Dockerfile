# fwynyk/rpm-s3
# VERSION       1.0.0

FROM centos:latest

MAINTAINER "Moip Platform"

RUN     yum install epel-release -y && \
        yum install https://s3.amazonaws.com/rpm-s3/rpm-s3-1.0.0-0.x86_64.rpm -y

WORKDIR /rpm-s3

ENTRYPOINT ["/rpm-s3/bin/rpm-s3"]
