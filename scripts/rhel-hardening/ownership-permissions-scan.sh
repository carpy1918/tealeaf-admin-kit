#!/bin/bash

#
#check ownership and permissions
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

#find all world writable files and dirs
for i in `find -H / -type d -perm /o+w`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -ld $i`
    prt "$v"
  fi
done

for i in `find -H / -type f -perm /o+w`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -la $i`
    prt "$v"
  fi
done 

#find all setuid and setgid
for i in `find / -perm -4000`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -la $i`
    prt "$v"
  fi
done 

for i in `find / -perm -2000`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -la $i`
    prt "$v"
  fi
done 

#find unknown uid and gid's on system
for i in `find / -nogroup`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -la $i`
    prt "$v"
  fi
done 

for i in `find / -nouser`; do
  if [[ $i =~ /dev/* || $i =~ /proc/* || $i =~ /sys/* || $i =~ /tmp/* || $i =~ /dev/shm ]]; then
    blah=1
  else
    v=`ls -la $i`
    prt "$v"
  fi
done 
