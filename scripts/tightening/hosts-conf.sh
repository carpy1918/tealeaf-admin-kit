#!/bin/bash

#
#Set the inittab runlevel
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/hosts'
cp $CONF /tmp/hosts.bkup

prt -e "HOSTS: hosts-conf.sh: checking /etc/hosts configuration"

if [ -f $CONF ]; then

 for i in "${HOSTS[@]}" ; do

  while read ip name ; do
    
    if grep -E $name $CONF > /dev/null
    then 
      prt -e "HOSTS: $name  $ip found in $CONF"
    else
      prt -e "HOSTS: $name NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo -e "$ip   $name" >> $CONF
      fi
    fi
  done <<< $i #end while
 done #end for

else
  prt -e "HOSTS: WARN: $CONF does not exist - `hostname`"
fi 

