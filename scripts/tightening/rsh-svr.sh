#!/bin/bash

#
#remove rsh server if installed
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

if [ "$MODE" = "EXECUTE" ]; then
  delete_pkg rsh-server
else
  if [ "$UNAME" = "Linux" ]; then
    value=`rpm -qa | grep rsh-server`
      prt "RSH-SVR: Installed: $value Should remove this."
  elif [ "$UNAME" = "Debian" ]; then
    value=`dpkg --get-selections | grep rsh`
      prt "RSH-SVR: Installed: $value Should remove this."
  fi  
fi


