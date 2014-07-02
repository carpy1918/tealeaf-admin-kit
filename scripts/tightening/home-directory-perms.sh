#!/bin/bash

#
#verify /home perms
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

if [ "$MODE" = "EXECUTE" ]; then
  chmod 750 /home/*
  prt "HOME-DIR: all /home perms changed to 750"
else
  ls -ld /home/* > /tmp/blah.home
  while read line; do
    prt "HOME-DIR: home dir: $line"
  done < /tmp/blah.home
  rm -f /tmp/blah.home
fi
