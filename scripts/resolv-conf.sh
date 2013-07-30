#!/bin/bash

#
#Set the inittab runlevel
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/resolv.conf'
cp $CONF $BKPDIR.$(date +%m%d%Y)

echo "Checking DNS Client config. - resolv-conf.sh - `hostname`"

if [ -f $CONF ]; then
  for i in "${DNSDOMAIN[@]}" ; do
    if `grep $i $CONF > /dev/null`; then 
      echo "$i found"
    else
      echo "$i not found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "search $i" >> $CONF
      fi
    fi
  done
  for i in "${DNSSERVERS[@]}" ; do
    if `grep $i $CONF > /dev/null`; then 
      echo "$i found"
    else
      echo "$i not found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "nameserver $i" >> $CONF
      fi
    fi
  done
else
  echo "WARN: $CONF does not exist - resolv-conf.sh - `hostname`"
fi 

