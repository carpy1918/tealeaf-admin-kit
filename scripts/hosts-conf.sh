#!/bin/bash

#
#Set the inittab runlevel
#
. /home/curt/scripts/tealeaf-env.sh
CONF='/etc/hosts'
cp $CONF $BKPDIR.$(date +%m%d%Y)

echo -e "Checking hosts config. - hosts-conf.sh - `hostname`"

if [ -f $CONF ]; then
 for i in "${HOSTS[@]}" ; do
    if `grep -E $i $CONF > /dev/null`; then 
      echo -e "$i found"
    else
      echo -e "$i not found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo -e "nameserver $i" >> $CONF
      fi
    fi
  done
else
  echo -e "WARN: $CONF does not exist - `hostname`"
fi 

