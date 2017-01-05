#!/bin/bash
. /etc/profile


if [ ! -e bin ]; then
    cd ..;
fi

KELUMACKIT=$(pwd)
NOWTIME=$(date)
BASEPATH="$KELUMACKIT/Download"
DOWNLOAD="$KELUMACKIT/Download"
RESOURCE="$KELUMACKIT/Resource"
USER=`whoami`

if [ ! -e Download ]; then
  mkdir Download
fi

# profile
#sudo $KELUMACKIT/bin/profile.sh;
#
#. $KELUMACKIT/bin/maximum-awesome.sh;
