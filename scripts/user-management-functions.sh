function Linux {

  if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo "Failure to create $USERNAME on $HOST" | mail $EMAIL;
    prt "Failure to create $USERNAME on $HOST"
    exit;
  fi
  chmod 600 /etc/shadow
  sed -i "s/\(ccarp001:\).*:\(.*\)\(:0:99999:7:::\)/\1$newpw:\2\3/" /etc/shadow
  chmod 400 /etc/shadow
  prt "user-management-functions.sh: $USERNAME password change complete"
}

function AIX {

 if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo failure to create $USERNAME on $HOST | mail $EMAIL;
    prt "user-management-functions.sh: failure to create $USERNAME on $HOST";
    exit;
  fi
  cp /etc/security/passwd /etc/security.bkp
  chmod 600 /etc/security/passwd
  sed "/ccarp001:/ {
        N
        s/password = .*/password = $aixpw/
        }" /etc/security/passwd.bkp > /etc/security/passwd
  chmod 400 /etc/security/passwd
  rm /etc/security/passwd.bkp
  prt "user-management-functions.sh: $USERNAME password change complete"
}

function HPUX {

 if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo "failure to create $USERNAME on $HOST" | mail $EMAIL;
    prt "failure to create $USERNAME on $HOST";
    exit;
  fi
  chmod 600 /etc/passwd.nis
  sed "s/\(ccarp001:\).*:\(.*\)\(:0:99999:7:::\)/\1$hpuxpw:\2\3/" /etc/security/passwd
  chmod 400 /etc/passwd.nis
  prt  "$USERNAME password change complete"
}

for user in "${USERS[@]}"; do
    $user
    echo "Hit user loop with: $USERNAME : $USERID : $GROUPID : $newpw"
    if ! id $USERNAME 
    then
      if [ "$UNAME" = "Linux" ]; then
        Linux
      elif [ "$UNAME" = "AIX" ]; then
        AIX
      elif [ "$UNAME" = "HP-UX" ]; then
        HPUX
      else
        prt "user-management-functions.sh: operating system not supported: $UNAME"
      fi
    fi
done

