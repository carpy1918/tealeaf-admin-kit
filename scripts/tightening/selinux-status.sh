#!/bin/bash

#
#selinux status on a server
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ -f /usr/sbin/sestatus ];then
SESTATUS=`sestatus | grep status | awk '{print $3}'`
SEMODE=`sestatus | grep "Current mode" | awk '{print $3}'`
SEFILEMODE=`sestatus | grep "Mode from config file" | awk '{print $3}'`

prt "SELINUX: Running Status: $SESTATUS"
prt "SELINUX: Running Mode: $SEMODE"

if [ ! "$SEMODE" = "$SEFILEMOD" ];then
 prt "SELINUX: Running mode and config file mode mismatch"
fi

for i in `/usr/sbin/semanage login -l`;do
  if [ $i !~ "Login Name" ] || [ $i !~ "__default__" ] || [ $i !~ "root" ] || [ $i !~ "system_u" ];then
  prt "SELINUX: UNIQUE USER TO SE USER MAPPING FOUND: $i"
  fi
done

else
  prt "SELINUX: not installed"
fi
