#!/bin/bash

#
#tighten umask for init and users
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

prt "init process umask set by editing /etc/security/init"

if [ -f /etc/bashrc ]; then
value=`grep -i -r "^\s*umask" /etc/bashrc`
prt "current /etc/bashrc values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/bashrc
  prt "/etc/bashrc modified"
fi

else
  prt "/etc/bashrc not found for umask mod"
fi


if [ -f /etc/profile ]; then
value=`grep -i -r "^\s*umask" /etc/profile`
prt "current /etc/profile values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/profile
  prt "/etc/profile modified"
fi

else
  prt "/etc/profile not found for umask mod"
fi

if [ -f /etc/login.defs ]; then
value=`grep -i -r "^\s*umask" /etc/login.defs`
prt "current /etc/login.defs values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/login.defs
  prt "/etc/login.defs modified"
fi

else
  prt "/etc/login.defs not found for umask mod"
fi
