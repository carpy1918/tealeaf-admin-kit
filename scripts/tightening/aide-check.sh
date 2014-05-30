#!/bin/bash

#
#aide install check and config file check
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

AIDE="/etc/aide.conf"

#
#verify aide is installed
#
if [[ `uname -v` =~ "Debian" ]]; then
  if dpkg-query -l aide | grep aide | grep "^ii" &> /dev/null; then
    prt "AIDE: $MODE: aide is installed"
  else
    prt "AIDE: $MODE: aide is NOT installed"
    if [ "$MODE" = "EXECUTE" ]; then
      apt-get -y -q install aide
      prt "AIDE: $MODE: Mode is EXECUTE and aide is installed"
    fi
  fi
else
  if rpm -qi aide &> /dev/null; then
    prt "AIDE: $MODE: aide is installed"
  else
    prt "AIDE: $MODE: aide is NOT installed"
    if [ "$MODE" = "EXECUTE" ]; then
      yum install aide
      prt "AIDE: $MODE: Mode is EXECUTE and aide has been installed"
    fi
  fi
fi

#
#verify /etc/aide.conf is in place, grab md5sum
#
if [ -f $AIDE ];then
  VALUE=`md5sum $AIDE`
  prt "AIDE: $MODE: $AIDE is present";
  prt "AIDE: $MODE: $VALUE";
else
  if [ "$MODE" = "EXECUTE" ]; then
    cp $TEALEAF_HOME/config-templates/aide.conf /etc/
    VALUE=`md5sum $AIDE`
    prt "AIDE: $MODE: $VALUE";
  else
    prt "AIDE: $MODE: $AIDE is not present";
  fi
fi
