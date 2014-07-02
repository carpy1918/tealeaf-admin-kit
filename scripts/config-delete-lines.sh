#!/bin/bash


#
#remove lines from config
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

for i in `cat $1`
do
sed -i 's/$2//g' $3
done

