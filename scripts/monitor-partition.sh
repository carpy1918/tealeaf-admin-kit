#!/bin/bash

#
#disk usage monitor
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh
HOSTNAME=`hostname`

while read percent partition; do
  p="${percent%?}"
  if [ $p -gt 85 ]; then
    echo $partition-alert-$percent | mail $EMAIL
    echo $partition-alert-$percent
#    if [ ! $partition eq "/" ]; then
#      ./clean-partition.sh $partition
#    fi
  fi
done < `df -kP | grep % | awk '{print $5, $6}'`
