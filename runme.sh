#!/bin/bash

#set -x
#exec > /tmp/last.puppet.run.$(hostname -f).log 2>&1

if [ ! -z "${EYP_PUPPET_HOST_IP}" ];
then
  echo "${EYP_PUPPET_HOST_IP} ${EYP_PUPPET_HOST}" >> /etc/hosts
fi

mkdir -p ${EYP_IDDIR}
echo ${EYP_ENV} > ${EYP_IDDIR}/${EYP_IDFILE}
echo ${EYP_CUSTOMER} > ${EYP_IDDIR}/${EYP_IDCUSTOMER}
echo ${EYP_CUSTOMERHASH} > ${EYP_IDDIR}/${EYP_IDCUSTOMERHASH}

echo "=== /etc/hosts =="
cat /etc/hosts

echo "=== facts =="
facter -p

echo "=== puppet agent =="
puppet agent --server=${EYP_PUPPET_HOST} --waitforcert=30 --no-daemonize --verbose --onetime --pluginsync --masterport=${EYP_PUPPET_PORT}

echo "=== post puppet facts =="
facter -p

yum clean all

rm -fr /var/lib/puppet/ssl
rm -fr /var/lib/puppet/clientbucket
rm -fr /var/lib/postfix/master.lock
rm -fr /var/lib/puppet/concat
rm -fr /var/lib/puppet/client_data
rm -fr /var/lib/puppet/classes.txt
rm -fr /var/lib/puppet/state
rm -fr /var/log
rm -fr /var/spool/postfix/pid/master.pid
rm -fr /var/run/*pid
rm -fr /var/run/puppet/agent.pid
rm -fr /etc/mcollective/facts.yaml
mkdir -p /var/log
