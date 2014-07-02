#!/bin/bash

#
#remove telnet server if installed
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

if [[ "$MODE" = "EXECUTE" && -f /usr/sbin/in.telnetd ]]; then
  prt "TELNET-SVR: deleting telnet-server"
  delete_pkg telnet-server
else
  if [ "$UNAME" = "Linux" ]; then
    value=`rpm -qa | grep telnet-server`
    if [ "$value" = '' ]; then
      prt "TELNET-SVR: telnet-server not installed"
    else
      prt "TELNET-SVR: Installed: $value Should remove this."
    fi
  elif [ "$UNAME" = "Debian" ]; then
    value=`dpkg --get-selections | grep telnet-server`
    if [ "$value" = '' ]; then
      prt "TELNET-SVR: telnet-server not installed"
    else
      prt "TELNET-SVR: Installed: $value Should remove this."
    fi
  fi  
fi
