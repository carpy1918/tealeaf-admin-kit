#!/bin/bash

#
#enable ntpd
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

  if running_process /usr/sbin/ntpd; then
    prt "ntpd is running"
    exit
  elif [ "$MODE" = "MONITOR" ]; then
    if [ -f /etc/init.d/ntpd ]; then
      prt "ntpd installed but not running"
    else
      prt "ntpd not installed"
    fi
  elif [ "$MODE" = "EXECUTE" ]; then
    if [ -f /etc/init.d/ntpd ]; then
      start_process ntpd
      prt "ntpd start executed"
    else
      prt "ntpd not found. attempting install and start"
      if [ "$UNAME" = "Linux" ]; then
        install_pkg ntpd
        start_process ntpd
      elif [ "$UNAME" = "Debian" ]; then
        install_pkg ntp
        start_process ntp
      else
        prt "OS $UNAME not supported in ntpd-server.sh"
      fi
    fi
  else
    prt "ntpd-svr.sh error"
  fi 

