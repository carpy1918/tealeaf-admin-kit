#!/bin/bash

#
#aide install check
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [[ `uname -v` =~ "Debian" ]]; then
  if dpkg-query -l aide | grep aide | grep "^ii" &> /dev/null; then
    prt "aide is installed"
  else
    prt "aide is NOT installed"
    if [ "$MODE" = "EXECUTE" ]; then
      apt-get -y -q install aide
      prt "Mode is EXECUTE and aide is installed"
    fi
  fi
else
  if rpm -qi aide &> /dev/null; then
    prt "aide is installed"
  else
    prt "aide is NOT installed"
    if [ "$MODE" = "EXECUTE" ]; then
      apt-get install aide
      prt "Mode is EXECUTE and aide is installed"
    fi
  fi
fi

