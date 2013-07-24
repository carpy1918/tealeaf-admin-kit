#!/bin/bash

#
#keep user account password up-to-date
#

. ./tealeaf-env.sh
USERS="(";

for server in `ls $TEALEAF_HOME/config-templates/users-by-server`
do
  for user in `ls $TEALEAF_HOME/config-templates/users-by-server/$server/`
  do
    . $TEALEAF_HOME/config-templates/users-by-server/$server/$user
    USERS="$USERS\"$USERNAME-$USERID-$GROUPID-$newpw-$aixpw-$hpuxpw\", "
  done
  USERS="$USERS);"
  echo "$server user array complete."

  echo -e "#!/bin/bash\n\n. ./tealeaf-env.sh\nCONF='/etc/passwd'" > user-management.sh
  echo -e "cp \$CONF \$BKPDIR.\$CONF.\$(date +%m%d%Y)\nUNAME=`uname`" >> user-management.sh
  echo -e "###"
  echo -e "USERS=$USERS" >> user-management.sh
  echo -e "###"
  cat user-management-functions.sh >> user-management.sh
  
  chmod 750 user-management.sh
#  scp user-management.sh $server:/tmp/
#  ssh $server /tmp/user-management.sh

done


