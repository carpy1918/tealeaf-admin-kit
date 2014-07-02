#!/bin/bash

#
#syslog config and make sure logs are getting audited
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

FLAG=0

IFS="\n"
for i in $(grep -e "@\w\+" /etc/*syslog.conf); do
  echo $i
  if [[ $i =~ \# ]]; then
    prt "SYSLOG: commented remote syslog entry found: $i"
  else
    prt "SYSLOG: remote syslog entry found: $i"
  fi
done

for i in $(grep -e "@\w\+" /etc/*syslog.d/*); do
  echo $i
  if [[ $i =~ \# ]]; then
    prt "SYSLOG: commented remote syslog entry found: $i"
  else
    prt "SYSLOG: remote syslog entry found: $i"
  fi
done

if [[ $FLAG = 0 ]]; then
  prt "SYSLOG: no remote syslog entry found"
fi


