#!/bin/bash

#
#tighten password policy with pam cracklib
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

for file in system-auth password-auth;do

if [ "$MODE" = "MONITOR" ]; then
  value=`grep cracklib /etc/pam.d/$file`
  if [ "$value" = "" ]; then
    prt "PAM-CRACKLIB: no entries found"
  else
    prt "PAM-CRACKLIB: $value"
  fi
else
  sed -r -i 's/password\s+requisite\s+pam_cracklib.so.*/password   requisite   pam_cracklib.so try_first_pass retry=3 minlen=12 dcredit=1 ucredit=1 ocredit=1 lcredit=1 difok=3/' /etc/pam.d/system-auth 
c  prt "PAM-CRACKLIB: modifiection complete"
  value=`grep cracklib /etc/pam.d/$file`
  prt "PAM-CRACKLIB: $value" 
fi

done
