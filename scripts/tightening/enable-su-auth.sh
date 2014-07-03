#!/bin/bash

#
#enable wheel group for su auth
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

VALUE=`grep pam_wheel /etc/pam.d/su`

if [ "$MODE" = "EXECUTE" ]; then
  sed -i 's/#auth\s+required\s+pam_wheel.so\s+use_uid/auth   required   pam_wheel.so use_uid/' /etc/pam.d/su
  prt "ENABLE-SU-AUTH: $MODE: pam_wheel.so (wheel group, dummy) is enabled"
  prt "ENABLE-SU-AUTH: $MODE: $VALUE"

  SUUSERS=`grep wheel: /etc/group`
  for i in "${SUAUTH[@]}";do
    if [[ "$SUUSERS" =~ $i ]]; then
      prt "ENABLE-SU-AUTH: $MODE: $i found in wheel group"
    else
      if [ ! `sed -i -r -e "{/wheel:x:..:$/ s/:$/:$i/}" /etc/group` ];then
 	echo "adding $i to wheel"
        sed -i -r -e "{/wheel:x:..:/ s/(.)$/\1,$i/}" /etc/group
      fi
    fi
  done
else
  prt "ENABLE-SU-AUTH: $MODE: $VALUE"
fi

