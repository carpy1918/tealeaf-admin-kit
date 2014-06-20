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
      prt "PARTITIONS: $i partition found."
      found=1


      if [[ "$attr" =~ "/nosuid/" ]]; then
	prt "PARTITIONS: $mount is nosuid: $attr"
      else
	if [ "$mount" != "/usr" ]; then 
	  prt "PARTITIONS: $mount is NOT nosuid: $attr"
	fi
      fi

      if [[ "$attr" =~ "/nodev/" ]]; then
	prt "PARTITIONS: $mount is nodev: $attr"
      else
	if [ "$mount" != "/" ]; then 
	  prt "PARTITIONS: $mount is NOT nodev: $attr"
	fi
      fi

      if [ "$fsck" != "1" ]; then
  	prt "PARTITIONS: $mount is NOT fsck enabled: $fsck"
      fi
    else
      blah=1
    fi

    if [ "$dev" = "cdrom" ]; then
      prt "PARTITIONS: $dev found."
      if [ "$attr" =~ "/noexec/" && "$attr" =~ "/nodev/" && "$attr" =~ "/nosuid/" ]; then
        prt "PARTITIONS: $dev has noexec, nodev, and nosuid"
      else
        prt "PARTITIONS: $dev does NOT have noexec, nodev, and nosuid"
      fi
    fi
  done < $config

  if [ ! $found = 1 ]; then
    prt "PARTITIONS: $i partition not found"
  fi

done
