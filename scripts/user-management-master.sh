#!/bin/bash

#
#keep user account password up-to-date
#

. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh

USERS=()	#declare array

for server in `ls $TEALEAF_HOME/users-by-server`
do

  echo "Hit server for loop with $server : $HOST"
  if [[ $server =~ $HOST ]]; then

    for user in `ls $TEALEAF_HOME/users-by-server/$server/`;do
      echo "Hit server for loop with $user"
      . $TEALEAF_HOME/users-by-server/$server/$user
      USERS+=("\". $TEALEAF_HOME/users-by-server/$server/$user\"")
    done

    echo -e "#!/bin/bash\n\n. /home/tealeaf/tealeaf-admin-kit/scripts/tealeaf-env.sh\nCONF='/etc/passwd'" > user-management.sh
    echo -e "cp \$CONF \$CONF.bkup\nmv \$CONF.bkup /tmp/\nUNAME=`uname`" >> user-management.sh
    echo -e "###" >> user-management.sh
    echo >> user-management.sh
    echo -e "USERS=(${USERS[@]})" >> user-management.sh
    echo -e "###" >> user-management.sh
    echo >> user-management.sh
    cat user-management-functions.sh >> user-management.sh
  
    chmod 750 user-management.sh

  fi

done
