#!/bin/bash

#
#remove telnet server if installed
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [[ "$MODE" = "EXECUTE" && -f /usr/sbin/in.telnetd ]]; then
  prt "deleting telnet-server"
  delete_pkg telnet-server
else
  if [ "$UNAME" = "Linux" ]; then
    value=`rpm -qa | grep telnet-server`
    if [ "$value" = '' ]; then
      prt "telnet-server not installed"
    else
      prt "Installed: $value Should remove this."
    fi
  elif [ "$UNAME" = "Debian" ]; then
    value=`dpkg --get-selections | grep telnet-server`
    if [ "$value" = '' ]; then
      prt "telnet-server not installed"
    else
      prt "Installed: $value Should remove this."
    fi
  fi  
fi
