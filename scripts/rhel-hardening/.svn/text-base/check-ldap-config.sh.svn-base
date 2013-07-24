#!/bin/bash

#
#check ldap config
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if grep -i ^auth.*ldap.* /etc/pam.d/system-auth; then
  prt "LDAP entry found in system-auth"
else
  prt "LDAP auth entry NOT found in system-auth"
fi

if [ "$UNAME" = "Linux" ]; then

for i in "/etc/openldap/ldap.conf" "/etc/ldap.conf";do
if grep -i ^uri*ldaps* $i; then
  prt "URI LDAPS entry found in $i"
elif grep -i ^uri*ldap:* $i; then
  prt "URI NOT ENCRYPTED LDAP entry found in $i"
elif grep -i ^host* $i; then
  prt "LDAP Host entry found. This is probably not encrypted."
else
  prt "LDAP entry not found in $i"
fi
done

elif [ "$UNAME" = "Debian" ]; then

for i in "/etc/ldap/ldap.conf" "/etc/ldap.conf"; do
if grep -i ^uri*ldaps* $i; then
  prt "URI LDAPS entry found in $i"
elif grep -i ^uri*ldap:* $i; then
  prt "URI NOT ENCRYPTED LDAP entry found in $i"
elif grep -i ^host* $i; then
  prt "LDAP Host entry found. This is probably not encrypted."
else
  prt "LDAP entry not found in $i"
fi
done

else
  prt "OS - $UNAME not supported by ldap-config.sh"
fi

