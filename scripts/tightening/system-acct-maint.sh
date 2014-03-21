#!/bin/bash

#
#system acct main - lock system accounts and other
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

for i in `cat $TEALEAF_HOME/config-templates/system-accounts.txt`; do
  if [ "$MODE" = "EXECUTE" ]; then
    usermod -L $i
    usermod -s /sbin/nologin $i
    prt "$i system account locked"
  else
    prt "system account: $i. $MODE - no mods made."
  fi
done

for i in `awk -F: '($2 == "") {print}' /etc/shadow`; do
  prt "$i has a blank password"
  if [ "MODE" = "EXECUTE" ]; then
    usermod -L $i
  fi
done
