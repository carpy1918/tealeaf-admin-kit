#!/bin/bash

#
#disable RDS protocol used for cluster communication
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

function chk_modprobe
{
  FLAG=0

  if [ -f /etc/modprobe.conf ]; then
    if grep "install $1 /bin/true" /etc/modprobe.conf
    then
      prt "disable-kernel-mods: $MODE: $1 entry exists in /etc/modprobe.conf"
      FLAG=1
    else
      prt "disable-kernel-mods: $MODE: install $1 /bin/true not in modprobe.conf"
    fi
  fi

  if grep "install $1 /bin/true" /etc/modprobe.d/*
  then
    prt "disable-kernel-mods: $MODE: $1 entry exists in /etc/modprobe.d/"
    FLAG=1
  else
    prt "disable-kernel-mods: $MODE: install $1 /bin/true not in modprobe.d/"
  fi

    if [[ "$FLAG" = "0" && "$MODE" = "EXECUTE" ]]; then
      echo "install $1 /bin/true" >> /etc/modprobe.d/fs-disable.conf
    fi
} #end chk_modprobe

if [ -f /etc/modprobe.d/fs-disable.conf ]; then
  prt "disable-kernel-mods: $MODE: fs-disable.conf already in place"
  exit
fi

for i in cramfs freevxfs hfs hfsplus jffs2 squashfs udf ipv6 sctp rds tipc; do
  chk_modprobe $i
done


