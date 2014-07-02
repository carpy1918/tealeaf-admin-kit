#!/bin/bash

#
#monitor tealeaf config files for changes
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh
hashfile="$TEALEAF_HOME/md5sum/config-hash.txt"
ffound=0	#file found
hfound=0	#hash found
dirty=0		#hash mismatch

for config in `ls $TEALEAF_HOME/config-templates/`; do
while read modfile hash; do
  if [ "$config" = "$modfile" ]; then
    ffound=1
    hsum=`md5sum $TEALEAF_HOME/config-templates/$config | awk '{print $1}'`;
    echo "hit $config/$modfile with $hash and $hsum"
    if [ "$hsum" = "$hash" ]; then
      echo file $modfile found and hashes match.
      hfound=1
    else
      #run config file mod command 
      echo "$config/$modfile. $hash/$hsum hashes do not match. Run file edit."
    fi
  fi
done < $hashfile

if [ "$ffound" -eq "0" ]; then
  echo new file $config adding to list
  hsum=`md5sum $TEALEAF_HOME/config-templates/$config | awk '{print $1}'`;
  echo "$config	$hsum" >> $hashfile
fi
ffound=0
done #end for
