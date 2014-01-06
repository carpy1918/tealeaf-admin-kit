#!/bin/bash

#
#OS patching
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "MONITOR" ]; then
  if [ "$UNAME" = "Linux" ]; then
    yum check-update | awk '{print $1}' > /tmp/blah.update
    while read line; do
      prt "patch found: $line"
      echo "patch found: $line"
    done < /tmp/blah.update
    rm -f /tmp/blah.update
  elif [ "$UNAME" = "Debian" ]; then
    value=`aptitude -s safe-upgrade`
    prt "$value"
  else
    prt "Unknown OS $UNAME found in os-patching" 
    echo "Unknown OS $UNAME found in os-patching" 
  fi
else
    for i in `cat $TEALEAF_HOME/config-templates/os-base-packages.txt`; do
      prt "Upgrading, or attempting to, $i"
      upgrade_pkg $i
    done
    prt "Updated basic core rpms. Printing the patches pending if not Debian."
fi

