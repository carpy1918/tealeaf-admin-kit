#!/bin/bash

#
#Set the inittab runlevel
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/hosts'
cp $CONF /tmp/hosts.bkup

prt -e "hosts-conf.sh: checking /etc/hosts configuration"

if [ -f $CONF ]; then

 for i in "${HOSTS[@]}" ; do

  while read ip name ; do
    
    if grep -E $name $CONF > /dev/null
    then 
      echo -e "$name  $ip found in $CONF"
    else
      echo -e "$name NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo -e "$ip   $name" >> $CONF
      fi
    fi
  done <<< $i  #end while
 done #end for

else
  echo -e "WARN: $CONF does not exist - `hostname`"
fi 

