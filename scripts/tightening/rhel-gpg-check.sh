#!/bin/bash

#
#verify gpg cert is installed
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

CONF='/etc/yum.conf'
PKGSIG='^gpgcheck\s*=\s*1'
CONFDIR=( $(ls /etc/yum.repos.d) )

if [ "$UNAME" = "Linux" ]; then

  if rpm -qi gpg-pubkey &> /dev/null; then
    prt "RHEL-GPG-CHECK: RHEL GPG key found."
  else
    prt "RHEL-GPG-CHECK: RHEL GPG key NOT found."
  fi 

  if [ "$MODE" = "EXECUTE" ]; then
    yum -y -q install gpg-pubkey
  fi

  if ! grep -e $PKGSIG $CONF &> /dev/null; then
    prt "RHEL-GPG-CHECK: RHEL gpgcheck not found in $CONF."
    if [ "$MODE" = "EXECUTE" ]; then
      echo $PKGSIG >> $CONF
    fi
  else
    prt "RHEL-GPG-CHECK: RHEL gpgcheck found in $CONF."
  fi

  for i in "${CONFDIR[@]}"; do
    if ! grep -e $PKGSIG $CONFDIR/$i &> /dev/null; then
      prt "RHEL-GPG-CHECK: RHEL gpgcheck not found in $CONFDIR/$i."
    if [ "$MODE" = "EXECUTE" ]; then
      echo $PKGSIG >> $CONFDIR/$i
    fi
    else
      prt "RHEL-GPG-CHECK: RHEL gpgcheck found in $CONFDIR/$i."
    fi
  done

else
  prt "RHEL-GPG-CHECK: OS is $UNAME. Not covered by rhel-gpg-check.sh" 
fi


