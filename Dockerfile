FROM centos:centos6
MAINTAINER Jordi Prats

ENV EYP_ENV test
ENV EYP_PUPPET_HOST puppet2
ENV EYP_PUPPET_HOST_IP 1.1.1.1
ENV EYP_PUPPET_PORT 8140

ENV EYP_IDDIR /tmp
ENV EYP_IDFILE environment

COPY runme.sh /usr/local/bin/

RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install puppet -y
