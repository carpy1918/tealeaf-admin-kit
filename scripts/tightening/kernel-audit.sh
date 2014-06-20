#!/bin/bash

#
#enable auditing at the kernel level for apps starting before auditd
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/grub.conf'

if grep "^\s*kernel.*audit" $CONF
then
  prt "KERNEL-AUDIT: audit=1 found in $CONF"
  exit
else
  prt "KERNEL-AUDIT: audit=1 not found in $CONF"
fi

if [ "$UNAME" = "Linux" ]; then
  if [ -f /etc/init.d/auditd ]; then
    if [ "$MODE" = "EXECUTE" ]; then
      cp $CONF $CONF.bkup;
      mv $CONF.bkup /tmp/ 
      sed -r -i 's/(kernel .*)/\1 audit=1/g' /etc/grub.conf
      prt "KERNEL-AUDIT: audit=1 added to kernel lines in $CONF"
    else
      prt "KERNEL-AUDIT: kernel-audit.sh: auditd installed. audit=1 not found in $CONF"
    fi
  else
    prt "KERNEL-AUDIT: kernel-audit.sh: auditd not installed. exiting"
  fi
else 
  prt "KERNEL-AUDIT: kernel-audit.sh: Not 'Linux', exiting"
fi
