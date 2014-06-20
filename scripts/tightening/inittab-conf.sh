#!/bin/bash

#
#Set the inittab runlevel
#

. /home/curt/scripts/tealeaf-env.sh

CONF='/etc/inittab'
cp $CONF $BKPDIR.$(date +%m%d%Y)

prt "INITTAB: Checking init runlevel - inittab-conf.sh - `hostname`";

if [ "$UNAME" = "Linux" ]; then
 if [ `grep id:5:initdefault: $CONF` ];then
   prt "INITTAB: $UNAME at runlevel 5."
   if [ "$MODE" = "EXECUTE" ]; then
     sed -i 's/id:5:initdefault:/id:3:initdefault:/' $CONF
   fi
 fi
elif [ "$UNAME" = "AIX" ]; then
 if ! `grep id:5:initdefault: $CONF`;then
   prt "INITTAB: $UNAME at runlevel 5."
   if [ "$MODE" = "EXECUTE" ]; then
     sed -i 's/id:5:initdefault:/id:3:initdefault:/' $CONF
   fi
 fi
elif [ "$UNAME" = "HP-UX" ]; then	#need to grab custom script from work
   if [ `grep id:5:initdefault: $CONF` ];then
   prt "INITTAB: $UNAME at runlevel 5."
     if [ "$MODE" = "EXECUTE" ]; then
       prt "INITTAB: HP-UX. Switching to custom regex."
       sed -i 's/id:5:initdefault:/id:3:initdefault:/' $CONF
     fi
   fi
else
  prt "INITTAB: OS not found"
fi
