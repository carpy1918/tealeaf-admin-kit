#!/bin/bash

#
#Set the inittab runlevel
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

CONF='/etc/hosts'
cp $CONF /tmp/hosts.bkup

prt "HOSTS: hosts-conf.sh: checking /etc/hosts configuration"

if [ -f $CONF ]; then

 for i in "${HOSTS[@]}" ; do

  while read ip name ; do
    
    if grep -E $name $CONF > /dev/null
    then 
      prt "HOSTS: $name  $ip found in $CONF"
    else
      prt "HOSTS: $name NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo -e "$ip   $name" >> $CONF
      fi
    fi
  done <<< $i #end while
 done #end for

else
  prt "HOSTS: WARN: $CONF does not exist - `hostname`"
fi 

