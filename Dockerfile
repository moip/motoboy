# moip/rpm-s3
# VERSION       1.0.0

FROM centos:latest

MAINTAINER "Moip Platform"

WORKDIR /

RUN     yum install epel-release -y 					&&	\
	yum install createrepo python-boto python-createrepo_c git	&& 	\
	git clone https://github.com/moip/rpm-s3 --recurse-submodules
 

WORKDIR /rpm-s3

ENTRYPOINT ["/rpm-s3/bin/rpm-s3"]
