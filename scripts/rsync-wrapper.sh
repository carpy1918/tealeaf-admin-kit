#!/bin/bash

. ./tealeaf-env.sh
declare -i LOOP=3
declare -i COUNT=0
declare -i SUCCESS=0
COMMAND="rsync -a $1 $2:$3"

while [ $COUNT -lt $LOOP ]
do

 if [ $SUCCESS -eq 0 ]
  then
   logger "$2:$3 attempting sync..."
   if $COMMAND
   then
   SUCCESS=$SUCCESS+1
   logger "successful command value: $SUCCESS"
   COUNT=$COUNT+1
   else
   logger "$2:$3 failed sync attempt with error: $?. sleeping 2 seconds and then trying again..."
   COUNT=$COUNT+1
   sleep 2
     if [ $COUNT -eq 3 ]
     then
     logger "$2:$3 sync failed 3 times...emailing admin group..."
     echo $2:$3 sync failed on `hostname` with error $? | mail curtis.carpenter@uscellular.com
     fi #end COUNT if
   fi #end COMMAND if
 else
 COUNT=$COUNT+1
 fi #end SUCCESS if
done

