#!/bin/bash

mkdir -p ${EYP_IDDIR}
echo ${EYP_ENV} > ${EYP_IDDIR}/${EYP_IDFILE}

puppet agent --server=${EYP_PUPPET_HOST} --waitforcert=30 --no-daemonize --verbose --onetime --pluginsync --masterport=${EYP_PUPPET_PORT}
