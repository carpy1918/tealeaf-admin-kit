#!/bin/bash

#
#verify /home perms
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "EXECUTE" ]; then
  chmod 750 /home/*
  prt "all /home perms changed to 750"
else
  ls -ld /home/* > /tmp/blah.home
  while read line; do
    prt "Home dir: $line"
  done < /tmp/blah.home
  rm -f /tmp/blah.home
fi
