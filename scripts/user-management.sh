#!/bin/bash

. ./tealeaf-env.sh
CONF='/etc/passwd'
cp $CONF $BKPDIR.$CONF.$(date +%m%d%Y)
UNAME=Linux
$USERS\=("ccarp001-921922-sysadm-.RbvunqK7vNRk-y89.7R/gQk/iY-IF3P3spCxUOyw", );

for i in "$USERS[@]" {
  
  ($USERNAME, $USERID, $GROUPID, $newpw, $aixpw, $hpuxpw)=`gawk -F '-' '{print $1, $2, $3, $4}'`

}

for
if ! id $USERNAME; then
  if [ "$UNAME" == "Linux" ]; then
    Linux $USERNAME $USERID $GROUPID $newpw
  elif [ "$UNAME" == "AIX" ]; then
    AIX $USERNAME $USERID $GROUPID $aixpw
  elif [ "$UNAME" == "HP-UX" ]; then
    HPUX $USERNAME $USERID $GROUPID $hpuxpw
  else
  echo "No Match"
  fi
fi

function Linux {
  $USERNAME = $1;
  $USERID = $2;
  $GROUPID = $3;
  $newpw = $4;

  if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo failure to create $USERNAME on `hostname` | mail curtis.carpenter@uscellular.com;
    logger failure to create $USERNAME on `hostname`;
    exit;
  fi
  chmod 600 /etc/shadow
  sed -i "s/\(ccarp001:\).*:\(.*\)\(:0:99999:7:::\)/\1$newpw:\2\3/" /etc/shadow
  chmod 400 /etc/shadow
  logger `date` $USERNAME password change complete
}

function AIX {
  $USERNAME = $1;
  $USERID = $2;
  $GROUPID = $3;
  $aixpw = $4;

 if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo failure to create $USERNAME on `hostname` | mail curtis.carpenter@uscellular.com;
    logger failure to create $USERNAME on `hostname`;
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
  logger `date` $USERNAME password change complete
}

function HPUX {
  $USERNAME = $1;
  $USERID = $2;
  $GROUPID = $3;
  $hpuxpw = $4;

 if [ ! useradd -u $USERID -g $GROUPID -c "Unix Platform Support" $USERNAME ]; then
    echo failure to create $USERNAME on `hostname` | mail curtis.carpenter@uscellular.com;
    logger failure to create $USERNAME on `hostname`;
    exit;
  fi
  chmod 600 /etc/passwd.nis
  sed "s/\(ccarp001:\).*:\(.*\)\(:0:99999:7:::\)/\1$hpuxpw:\2\3/" /etc/security/passwd
  chmod 400 /etc/passwd.nis
  logger `date` $USERNAME password change complete
}
