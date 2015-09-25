# moip/motoboy
# VERSION       1.0.0

FROM centos:latest

MAINTAINER "Moip Platform"

WORKDIR /

RUN     yum install epel-release -y                                     &&      \
        yum install createrepo python-boto python-createrepo_c git -y   &&      \
        git clone https://github.com/moip/motoboy --recurse-submodules


WORKDIR /motoboy

CMD     ["/motoboy/run.sh"]
