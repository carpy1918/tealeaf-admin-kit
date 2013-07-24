#!/bin/bash

#
#cleanup of games dir
#
. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

for i in `ls /usr/games/`; do
  prt "Game found: /usr/games/$i"

if [ "$MODE" = "EXECUTE" ]; then
  rm -f /usr/games/$i
  prt "Game $i removed."
fi
done

