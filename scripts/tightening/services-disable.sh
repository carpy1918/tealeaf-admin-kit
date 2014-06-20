#!/bin/bash

#
#disable services listed in services-disable.txt
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF="$TEALEAF_HOME/config-templates/services-disable.txt"
RUNLEVEL=`runlevel | awk '{print $2}'`

while read svc; do
  if [ "$MODE" = "EXECUTE" ]; then
    stop_process $svc
    prt "SERVICES-DISABLE: $svc is turned off"
    if [ $UNAME = "Linux" ]; then
      chkconfig $svc off
    else
      mv /etc/init.d/$svc /tmp/
    fi
    running_process $svc
  else
    running_process $svc
  fi
done < $CONF

