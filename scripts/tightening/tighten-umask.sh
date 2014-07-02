#!/bin/bash

#
#tighten umask for init and users
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

prt "TIGHTEN-UMASK: init process umask set by editing /etc/security/init"

if [ -f /etc/bashrc ]; then
value=`grep -i -r "^\s*umask" /etc/bashrc`
prt "TIGHTEN-UMASK: current /etc/bashrc values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/bashrc
  prt "TIGHTEN-UMASK: /etc/bashrc modified"
fi

else
  prt "TIGHTEN-UMASK: /etc/bashrc not found for umask mod"
fi


if [ -f /etc/profile ]; then
value=`grep -i -r "^\s*umask" /etc/profile`
prt "TIGHTEN-UMASK: current /etc/profile values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/profile
  prt "TIGHTEN-UMASK: /etc/profile modified"
fi

else
  prt "TIGHTEN-UMASK: /etc/profile not found for umask mod"
fi

if [ -f /etc/login.defs ]; then
value=`grep -i -r "^\s*umask" /etc/login.defs`
prt "TIGHTEN-UMASK: current /etc/login.defs values: $value"

if [ "$MODE" = "EXECUTE" ]; then
  sed -i -r 's/^\s*umask\s+\w+/umask 027/Ig' /etc/login.defs
  prt "TIGHTEN-UMASK: /etc/login.defs modified"
fi

else
  prt "TIGHTEN-UMASK: /etc/login.defs not found for umask mod"
fi
