#!/bin/bash

#
#remove not needed suid perms
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

for i in `cat $TEALEAF_HOME/config-templates/suid-removal.txt`; do

 value=`find $i -type f -perm -u=s`
 if [ ! "$value" = "" ]; then
   prt "SUID-REMOVAL: $i owner is suid"

   if [ "$MODE" = "EXECUTE" ]; then
     prt "SUID-REMOVAL: Removing SUID on $i"
     chmod -s $i
   fi
 else
   prt "SUID-REMOVAL: $i owner is NOT SUID"
 fi 
 value=`find $i -type f -perm -g=s`
 if [ ! "$value" = "" ]; then
   prt "SUID-REMOVAL: $i group is suid"

   if [ "$MODE" = "EXECUTE" ]; then
     prt "SUID-REMOVAL: MODE = EXECUTE. Removing SUID on $i"
     chmod -s $i
   fi
 else
   prt "SUID-REMOVAL: $i group is NOT SUID"
 fi 
 value=""
done

