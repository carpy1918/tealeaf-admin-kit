#!/bin/bash

#
#Set the inittab runlevel
#
. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/resolv.conf'
cp $CONF /tmp/resolv.conf.bkup

prt "$CONF configuration check"

if [ -f $CONF ]; then

    if grep $DNSDOMAIN $CONF > /dev/null
    then 
      prt "DNS Domain: $DNSDOMAIN found in $CONF"
    else
      prt "DNS Domain: $DNSDOMAIN NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "search $DNSDOMAIN" >> $CONF
      fi
    fi
  for i in "${DNSSERVERS[@]}" ; do
    if grep $i $CONF > /dev/null
    then 
      prt "$i found in $CONF"
    else
      prt "$i NOT found in $CONF"
      if [ "$MODE" = "EXECUTE" ]; then
        echo "nameserver $i" >> $CONF
      fi
    fi
  done #end for

else
  prt "WARN: $CONF does not exist - resolv-conf.sh."
fi 

