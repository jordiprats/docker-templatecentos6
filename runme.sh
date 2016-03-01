#!/bin/bash

set -x

exec > /tmp/last.puppet.run.${EYP_PUPPET_RUNID}.log 2>&1

if [ ! -z "${EYP_PUPPET_HOST_IP}" ];
then
  echo "${EYP_PUPPET_HOST_IP} ${EYP_PUPPET_HOST}" >> /etc/hosts
fi

mkdir -p ${EYP_IDDIR}
echo ${EYP_ENV} > ${EYP_IDDIR}/${EYP_IDFILE}

puppet agent --server=${EYP_PUPPET_HOST} --waitforcert=30 --no-daemonize --verbose --onetime --pluginsync --masterport=${EYP_PUPPET_PORT}

yum clean all

rm -fr /var/lib/puppet
rm -fr /var/log
