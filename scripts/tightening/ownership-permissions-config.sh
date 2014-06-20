#!/bin/bash

#
#ownership and perms on config files and dirs
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/boot/grub/grub.conf'
if find $CONF -user root -group root -perm 600; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root:root $CONF
    chmod 600 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/crontab'
if find $CONF -user root -group root -perm 600; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root:root $CONF
    chmod 600 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/cron.*'
if find $CONF -user root -group root -perm 700; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root $CONF
    chmod 600 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/anacrontab'
if find $CONF -user root -group root -perm 600; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root $CONF
    chmod 600 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/passwd'
if find $CONF -user root -group root -perm 644; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root:root $CONF
    chmod 644 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/group'
if find $CONF -user root -group root -perm 644; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root:root $CONF
    chmod 644 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

CONF='/etc/shadow'
if find $CONF -user root -group root -perm 400; then
  prt "OWNERSHIP-PERM-CONFIG: $CONF found, owner/group ok, perms set correctly"
else
  prt "OWNERSHIP-PERM-CONFIG: $CONF owner/group/perms is not correct"
  if [ "$MODE" = "EXECUTE" ]; then
    chown root:root $CONF
    chmod 400 $CONF
    prt "OWNERSHIP-PERM-CONFIG: $CONF is corrected"
  fi
fi

