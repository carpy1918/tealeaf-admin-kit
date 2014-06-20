#!/bin/bash

#
#OS patching
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "MONITOR" ]; then
  if [ "$UNAME" = "Linux" ]; then
    yum check-update | awk '{print $1}' > /tmp/blah.update
    while read line; do
      prt "OS-PATCHING: patch found: $line"
    done < /tmp/blah.update
    rm -f /tmp/blah.update
  elif [ "$UNAME" = "Debian" ]; then
    value=`aptitude -s safe-upgrade`
    prt "OS-PATCHING: $value"
  else
    prt "OS-PATCHING: Unknown OS $UNAME found in os-patching" 
  fi
else
    for i in `cat $TEALEAF_HOME/config-templates/os-base-packages.txt`; do
      prt "OS-PATCHING: Upgrading, or attempting to, $i"
      upgrade_pkg $i
    done
    prt "OS-PATCHING: Updated basic core rpms. Printing the patches pending if not Debian."
fi

