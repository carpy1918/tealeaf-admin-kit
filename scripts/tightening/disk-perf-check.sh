#!/bin/bash

#
#check the performance of disk partitions using sar
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

COUNT=0

if [ ! -f "/usr/bin/sar" ];then
  prt "DSK-PERF-CHECK: sar not installed"
  exit
fi

for i in `sar -d | awk '{print $4}'`;do

if [[ $i =~ "rdKb/s" ]] && [[ $i =~ "" ]];then
  if [ $i > 1950 ];then
    let "COUNT += 1"
    echo "read alert count: $COUNT"    
  fi
fi

if [ $COUNT -gt 20 ];then
  prt "DISK-PERF-CHECK: READ WARNING: $COUNT found"
elif [ $COUNT -gt 30 ];then
  prt "DISK-PERF-CHECK: READ ALERT: $COUNT found"
fi

done

for i in `sar -d | awk '{print $6}'`;do

if [[ $i =~ "wrKb/s" ]] && [[ $i =~ "" ]];then
  if [ $i > 1950 ];then
    let "COUNT += 1"
    echo "write alert count: $COUNT"    
  fi
fi

if [ $COUNT -gt 20 ];then
  prt "DISK-PERF-CHECK: WRITE WARNING: $COUNT found"
elif [ $COUNT -gt 30 ];then
  prt "DISK-PERF-CHECK: WRITE ALERT: $COUNT found"
fi

done

