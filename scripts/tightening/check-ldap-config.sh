#!/bin/bash

#
#check ldap config entries
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

#
#PAM LDAP Auth - check system-auth for LDAP
#
if grep -i ^auth.*ldap.* /etc/pam.d/system-auth; then
  prt "check-ldap-config.sh: $MODE: LDAP entry found in system-auth"
else
  prt "check-ldap-config.sh: $MODE: LDAP auth entry NOT found in system-auth"
fi

#
#LDAP Auth - ldap.conf - check for config and LDAPS (encryption)
#
if [ "$UNAME" = "Linux" ]; then

for i in "/etc/openldap/ldap.conf" "/etc/ldap.conf";do
if VALUE=`grep -i ^uri*ldaps* $i`; then
  prt "check-ldap-config.sh: $MODE: URI LDAPS entry found in $i"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
elif VALUE=`grep -i ^uri*ldap:* $i`; then
  prt "check-ldap-config.sh: $MODE: URI NOT ENCRYPTED LDAP entry found in $i"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
elif VALUE=`grep -i ^host* $i`; then
  prt "check-ldap-config.sh: $MODE: LDAP Host entry found. This is probably not encrypted"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
else
  prt "check-ldap-config.sh: $MODE: LDAP URI or host entry not found in $i. LDAP not configured"
fi
done

elif [ "$UNAME" = "Debian" ]; then

for i in "/etc/ldap/ldap.conf" "/etc/ldap.conf"; do
if VALUE=`grep -i ^uri*ldaps* $i`; then
  prt "check-ldap-config.sh: $MODE: URI LDAPS entry found in $i"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
elif VALUE=`grep -i ^uri*ldap:* $i`; then
  prt "check-ldap-config.sh: $MODE: URI NOT ENCRYPTED LDAP entry found in $i"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
elif VALUE=`grep -i ^host* $i`; then
  prt "check-ldap-config.sh: $MODE: LDAP Host entry found. This is probably not encrypted"
  prt "check-ldap-config.sh: $MODE: $i $VALUE"
else
  prt "check-ldap-config.sh: $MODE: LDAP URI or host entry not found in $i. LDAP not configured"
fi
done

else
  prt "check-ldap-config.sh: $MODE: $UNAME not supported"
fi

