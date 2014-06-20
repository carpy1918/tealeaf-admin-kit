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
    prt "VERIFY-PKG: $1 is not installed"
  fi
elif [ "$UNAME" = "AIX" ]; then
  prt "VERIFY-PKG: $UNAME not supported"
elif [ "$UNAME" = "HP-UX" ]; then
  prt "VERIFY-PKG: $UNAME not supported"
elif [ "$UNAME" = "SunOS" ]; then
  prt "VERIFY-PKG: $UNAME not supported"
elif [ "$UNAME" = "Debian" ]; then
  if dpkg-query -l $1 | grep $1 | grep "^ii" &> /dev/null; then
    prt "VERIFY-PKG: $1 package is installed"
  else
    if [ $MODE = "EXECUTE" ];then
      prt "VERIFY-PKG: attempting install of $1";
      aptitude -y install $i
    else
      prt "VERIFY-PKG: $1 package is NOT installed"
    fi
  fi
else
  prt "OS - $UNAME - not supported"
fi
