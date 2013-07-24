#!/bin/bash

#
#iptables check
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

value=`rpm -qa | grep iptables`
if [ ! "$value" = "" ]; then
  prt "Iptables installed: $value"
fi

value=`/etc/init.d/iptables status`
if [[ ! $value =~ "not running" ]]; then
  prt "Iptables is runnning."
else
  prt "Iptables is NOT running." 
fi


