#!/bin/bash

#
#check to see if gcc is installed
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ -f /usr/bin/gcc ]; then
  prt "/usr/bin/gcc is installed."
else
  prt "/usr/bin/gcc is NOT installed."
fi

if [ -d /usr/lib/gcc ]; then
  prt "/usr/lib/gcc directory found."
else
  prt "/usr/lib/gcc directory NOT found."
fi

if [ "$UNAME" = "Linux" ]; then
  value=`rpm -qa | egrep -i "(glibc-devel|glibc-headers|kernel-devel|kernel-headers)"`
  if [ ! "$value" = "" ]; then
    prt "Installed packages: $value"
  fi
fi

if [ "$MODE" = "EXECUTE" ]; then
  yum -y -q remove gcc
  prt "removed gcc package"
fi

