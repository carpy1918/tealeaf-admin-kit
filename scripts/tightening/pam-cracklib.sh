#!/bin/bash

#
#tighten password policy with pam cracklib
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "MONITOR" ]; then
  value=`grep cracklib /etc/pam.d/*`
  if [ "$value" = "" ]; then
    prt "pam-cracklib: no entries found"
  else
    prt "pam-cracklib: $value"
  fi
else
  sed -r -i 's/password\s+requisite\s+pam_cracklib.so.*/password   requisite   pam_cracklib.so try_first_pass retry=3 minlen=12 dcredit=1 ucredit=1 ocredit=1 lcredit=1 difok=3/' /etc/pam.d/system-auth 
  prt "pam-cracklib: modifiection complete"
  value=`grep cracklib /etc/pam.d/*`
  prt "pam-cracklib: $value" 
fi
