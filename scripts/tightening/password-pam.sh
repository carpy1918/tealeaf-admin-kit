#!/bin/bash

#
#Set the inittab runlevel
#
. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

CONF='/etc/pam.d/system-auth'
FAIL=0

pamunix=( remember )

prt "PASSWD-PAM: PAM password complexity and management. Password expiration handled in /etc/login.defs.";

if [ "$UNAME" = "Linux" ]; then
  cracklib=( minlen dcredit ucredit ocredit lcredit )
  CONF='/etc/pam.d/system-auth'
  cp $CONF /tmp/system-auth.bkup
elif [ "$UNAME" = "Debian" ]; then
  prt "PASSWD-PAM: Debian does not have PAM cracklib.so library installed by default, ignoring."
  pamunix=( remember minlen obscure )
  CONF='/etc/pam.d/common-password'
  cp $CONF /tmp/common-password.bkup
else
  prt "PASSWD-PAM: OS $MODE not supported"
  exit
fi

for i in "${pamunix[@]}";do
  if grep $i $CONF; then
    prt "PASSWD-PAM: $i found in $CONF"
  else
    prt "PASSWD-PAM: $i NOT found in $CONF. Line will be replaced in Execute mode."
    FAIL=1
  fi
done

if [[ "$MODE" = "EXECUTE" ]] && [[ "$UNAME" = "Linux" ]]; then
  sed -i 's/^password.*pam_unix.so.*/password    sufficient    pam_unix.so sha512 shadow try_first_pass use_authtok existing_options remember=24/' $CONF
  prt "PASSWD-PAM: $CONF pam_unix.so updated"
elif [[ "$MODE" = "EXECUTE" ]] && [[ "$UNAME" = "Debian" ]]; then
  sed -i 's/^password.*pam_unix.so.*/password        [success=1 default=ignore]      pam_unix.so minlen=12 obscure sha512/' $CONF
  prt "PASSWD-PAM: $CONF pam_unix.so updated"
else
  echo
fi

FAIL=0
for i in "${cracklib[@]}";do
  if grep $i $CONF; then
    prt "PASSWD-PAM: $i found in $CONF"
  else
    prt "PASSWD-PAM: $i NOT found in $CONF. Line will be replaced in Execute mode."
    FAIL=1
  fi
done

if [[ "$MODE" = "EXECUTE" ]] && [[ "$UNAME" = "Linux" ]]; then
  sed -i 's/^password.*pam_cracklib.so.*/password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=12 dcredit=1 ucredit=1 ocredit=1 lcredit=1/' $CONF
  prt "PASSWD-PAM: $CONF pam_cracklib.so updated"
fi

