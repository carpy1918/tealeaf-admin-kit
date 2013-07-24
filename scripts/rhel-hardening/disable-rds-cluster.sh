#!/bin/bash

#
#disable RDS protocol used for cluster communication
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh
if [ "$MODE" = "EXECUTE" ]; then
if [ -f /etc/modprobe.conf ]; then
  if grep "install rds /bin/true" /etc/modprobe.conf
  then 
    prt "rds entry exists in /etc/modprobe.conf"
  else
    echo "install rds /bin/true" >> /etc/modprobe.conf
    prt "install rds /bin/true inserted into modprobe.conf"
  fi
  if grep "install tipc /bin/true" /etc/modprobe.conf
  then 
    prt "tipc entry exists in /etc/modprobe.conf"
  else
    echo "install tipc /bin/true" >> /etc/modprobe.conf
    prt "install tipc /bin/true inserted into modprobe.conf"
  fi
elif [ -f /etc/modprobe.d/cluster-disable.conf ]; then
    prt "modprobe.d - cluster disable in place already"
else
  if grep "install rds /bin/true" /etc/modprobe.d/*
  then
    prt "rds exists in modprobe.d/"
  else
    echo "install rds /bin/true" > /etc/modprobe.d/cluster-disable.conf
    prt "install rds /bin/true inserted into modprobe.d/cluster-disable.conf"
  fi
  if grep "install tipc /bin/true" /etc/modprobe.d/*
  then
    prt "tips exists in modprobe.d/"
  else
    echo "install tipc /bin/true" >> /etc/modprobe.d/cluster-disable.conf
    prt "install tipc /bin/true inserted into modprobe.d/cluster-disable.conf"
  fi
fi #end modprobe.conf  
else   #MONITOR MODE 
  if [ -f /etc/modprobe.conf ]; then
    if grep "install rds /bin/true" /etc/modprobe.conf
    then
      prt "rds entry exists in /etc/modprobe.conf"
    else
      prt "install rds /bin/true not in modprobe.conf" 
    fi
    if grep "install tipc /bin/true" /etc/modprobe.conf
    then
      prt "tipc entry exists in /etc/modprobe.conf"
    else
      prt "install tipc /bin/true not in modprobe.conf"
    fi
  elif [ -f /etc/modprobe.d/cluster-disable.conf ]; then
    prt "cluster disable in place already"
  else
    prt "install rds /bin/true not in place in modprobe.conf"
    prt "install tipc /bin/true not in place in modprobe.conf"
  fi
  if grep "install rds /bin/true" /etc/modprobe.d/*
  then
    prt "rds entry exists in /etc/modprobe.d/"
  else
    prt "install rds /bin/true not in modprobe.d/" 
  fi
  if grep "install tipc /bin/true" /etc/modprobe.d/*
  then
    prt "tipc entry exists in /etc/modprobe.d/"
  else
    prt "install tipc /bin/true not in modprobe.d/"
  fi
fi #end EXECUTE if
