#!/bin/bash


#
#remove lines from config
#

. /home/curt/scripts/tealeaf-env.sh

for i in `cat $1`
do
sed -i 's/$2//g' $3
done

