#!/bin/bash

#
#enable wheel group for su auth
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

if [ "$MODE" = "EXECUTE" ]; then
  sed -i 's/#auth\s+required\s+pam_wheel.so\s+use_uid/auth   required   pam_wheel.so use_uid/' /etc/pam.d/su
fi

value=`grep pam_wheel.so /etc/pam.d/su`
prt "enable-su-auth.sh: $value"
