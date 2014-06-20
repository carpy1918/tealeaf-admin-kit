#!/bin/bash

#
#enable single user mode passwd and grub passwd
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

SINGLE='SINGLE=/sbin/sushell'
GPASS='^password'

if [ "$UNAME" = "Linux" ]; then
  if grep -e $GPASS /etc/grub.conf; then
    prt "GRUB: /etc/grub.conf has password"
  else
    prt "GRUB: /etc/grub.conf does NOT have a password set"
  fi

  if grep -e $SINGLE /etc/sysconfig/init; then
    prt "GRUB: /etc/sysconfig/init has $SINGLE"
  else
    prt "GRUB: /etc/sysconfig/init does NOT have $SINGLE"
  fi

  if [ "$MODE" = "EXECUTE" ]; then
    prt "GRUB: No EXECUTE steps in grub-single-passwd.sh. Manually set password"
  fi
else
  prt "GRUB: grub-single-password.sh does not support $UNAME"
fi

