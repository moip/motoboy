# moip/fpm-cookery-aws-cli
# VERSION	0.0.1

FROM		centos:7
MAINTAINER	"Moip Platform"

RUN		yum install -y gcc gcc-c++ make ruby-devel rubygem-bundler patch tar epel-release	&&	\
		rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/l/lbzip2-2.5-1.el7.x86_64.rpm	&&	\
		yum install -y rpm-build git libxml2-devel libxslt-devel				&&	\
		gem install --no-ri --no-rdoc fpm-cookery						&&	\
		gem install --no-ri --no-rdoc -v '< 2' aws-sdk						&&	\
		curl -O https://bootstrap.pypa.io/get-pip.py						&&	\
		python get-pip.py									&&	\
		pip install awscli

WORKDIR		/
