#!/bin/bash

#
#find unlabed (selinux label) devices
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

ls -ZR / | grep unlabeled > /tmp/blah.selinux
while read line; do
  if [[ $line =~ unlabeled$ || $line =~ unlabelednet.if || $line =~ unlabelednet.pp.bz2 || $line =~ unlabelednet.pp || $line = "" ]]; then
    echo
  else
    prt "Unlabed SELinux device: $line"
  fi
done < /tmp/blah.selinux 


#for i in `ls -ZR / | grep unlabeled`; do
#  if [[ $i =~ unlabeled$ || $i =~ unlabelednet.if || $i =~ unlabelednet.pp.bz2 ]]; then
#    echo
#  else
#    prt "Unlabed SELinux device: $i"
#  fi
#done

