#!/bin/bash

#
#enable wheel group for su auth
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

VALUE=`grep pam_wheel /etc/pam.d/su`

if [ "$MODE" = "EXECUTE" ]; then
  sed -i 's/#auth\s+required\s+pam_wheel.so\s+use_uid/auth   required   pam_wheel.so use_uid/' /etc/pam.d/su
  prt "enable-su-auth: $MODE: pam_wheel.so (wheel group, dummy) is enabled"
  prt "enable-su-auth: $MODE: $VALUE"

  SUUSERS=`grep wheel: /etc/group`
  for i in "${SUAUTH[@]}";do
    if [[ "$SUUSERS" =~ $i ]]; then
      prt "enable-su-auth: $MODE: $i found in wheel group"
    else
      if [ ! `sed -i -r -e "{/wheel:x:..:$/ s/:$/:$i/}" /etc/group` ];then
 	echo "adding $i to wheel"
        sed -i -r -e "{/wheel:x:..:/ s/(.)$/\1,$i/}" /etc/group
      fi
    fi
  done
else
  prt "enable-su-auth: $MODE: $VALUE"
fi

