#!/bin/bash

#
#verify a package is installed on a server
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ $UNAME = "Linux" ]; then
  RESULT=`rpm -qa | grep $1`
  if [ $RESULT = '' && "$MODE" = "EXECUTE" ]; then
    yum -y -q install $1
  elif [ $RESULT = '' ]; then
    prt "$1 is not installed"
  fi
elif [ "$UNAME" = "AIX" ]; then
  echo "$UNAME not supported"
elif [ "$UNAME" = "HP-UX" ]; then
  echo "$UNAME not supported"
elif [ "$UNAME" = "SunOS" ]; then
  echo "$UNAME not supported"
elif [ "$UNAME" = "Debian" ]; then
  if dpkg-query -l $1 | grep $1 | grep "^ii" &> /dev/null; then
    prt "$1 package is installed"
    echo "$1 package is installed"
  else
    prt "$1 package is NOT installed"
    echo "$1 package is NOT installed"
  fi
else
  echo "OS - $UNAME - not supported"
fi
