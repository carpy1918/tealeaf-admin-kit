#!/bin/bash

#
#partion config check
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh
default='rw suid dev exec auto nouser async'
partitions=(/usr /var /var/log / /home swap /var/log/audit /tmp /var/tmp /dev/shm)
config='/etc/fstab'
declare -i found=0
dump=''
fsck=''

for i in "${partitions[@]}"; do
  found=0

  while read dev mount type attr dump fsck; do
    if [ "$mount" = "$i" ]; then
      prt "$i partition found."
      found=1


      if [[ "$attr" =~ "/nosuid/" ]]; then
	prt "$mount is nosuid: $attr"
      else
	if [ "$mount" != "/usr" ]; then 
	  prt "$mount is NOT nosuid: $attr"
	fi
      fi

      if [[ "$attr" =~ "/nodev/" ]]; then
	prt "$mount is nodev: $attr"
      else
	if [ "$mount" != "/" ]; then 
	  prt "$mount is NOT nodev: $attr"
	fi
      fi

      if [ "$fsck" != "1" ]; then
  	prt "$mount is NOT fsck enabled: $fsck"
      fi
    else
      blah=1
    fi

    if [ "$dev" = "cdrom" ]; then
      prt "$dev found."
      if [ "$attr" =~ "/noexec/" && "$attr" =~ "/nodev/" && "$attr" =~ "/nosuid/" ]; then
        prt "$dev has noexec, nodev, and nosuid"
      else
        prt "$dev does NOT have noexec, nodev, and nosuid"
      fi
    fi
  done < $config

  if [ ! $found = 1 ]; then
    prt "$i partition not found"
  fi

done
