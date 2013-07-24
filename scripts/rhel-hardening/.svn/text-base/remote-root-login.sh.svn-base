#!/bin/bash

#
#disable remote root access
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/ssh/sshd_config'

if grep '^[P|p]ermit[R|r]oot[L|l]ogin [N|n]o' $CONF; then
  prt "Remote SSH root access is disabled"
else
  prt "Remote SSH root access is enabled"
  if [ "$MODE" = "EXECUTE" ]; then
    prt "Disabling remote root access"
    sed -r -i 's/.ermit.oot.ogin.*/PermitRootLogin no/' $CONF
  fi
fi

