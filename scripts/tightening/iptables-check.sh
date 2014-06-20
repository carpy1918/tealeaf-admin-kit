#!/bin/bash

#
#iptables check
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

value=`rpm -qa | grep iptables`
if [ ! "$value" = "" ]; then
  prt "IPTABLES: iptables installed: $value"
fi

value=`/etc/init.d/iptables status`
if [[ ! $value =~ "not running" ]]; then
  prt "IPTABLES: iptables is runnning."
else
  prt "IPTABLES: iptables is NOT running." 
fi


