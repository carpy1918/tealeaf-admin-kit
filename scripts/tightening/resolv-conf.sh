#!/bin/bash

#
#Set the inittab runlevel
#
. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

CONF='/etc/resolv.conf'
cp $CONF /tmp/resolv.conf.bkup

prt "RESOLV: $CONF configuration check"

if [ -f $CONF ]; then

    if grep $DNSDOMAIN $CONF > /dev/null
    then 
      prt "RESOLV: DNS Domain: $DNSDOMAIN found in $CONF"
    else
      prt "RESOLV: DNS Domain: $DNSDOMAIN NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "search $DNSDOMAIN" >> $CONF
      fi
    fi
  for i in "${DNSSERVERS[@]}" ; do
    if grep $i $CONF > /dev/null
    then 
      prt "RESOLV: $i found in $CONF"
    else
      prt "RESOLV: $i NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "nameserver $i" >> $CONF
      fi
    fi
  done #end for

else
  prt "RESOLV: WARN: $CONF does not exist - resolv-conf.sh."
fi 

