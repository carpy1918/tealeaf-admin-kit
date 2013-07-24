#!/bin/bash

#
#remove rsh server if installed
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "EXECUTE" ]; then
  delete_pkg rsh-server
else
  if [ "$UNAME" = "Linux" ]; then
    value=`rpm -qa | grep rsh-server`
      prt "Installed: $value Should remove this."
  elif [ "$UNAME" = "Debian" ]; then
    value=`dpkg --get-selections | grep rsh`
      prt "Installed: $value Should remove this."
  fi  
fi


