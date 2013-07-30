#!/bin/bash

#
#tealeaf env variables for exe scripts
#

UNAME=`uname`
if [[ -f /etc/debian_version ]]; then
  UNAME="Debian"
fi
TEALEAF_HOME="/home/curt/tealeaf-svn/"
MODE=`$TEALEAF_HOME/scripts/management-mode.sh`
HOST=`hostname`
BKPDIR='/tmp/tealeaf/'
DNSSERVERS=('192.168.85.2')
DNSDOMAIN='tealeaf.com'
HOSTS=('192.168.85.2\tgateway' '192.168.85.130\tmngt-svr' '192.168.85.134\tubuntu-node' '192.168.85.138\topensuse-12-node' '192.168.85.139\tcentos-6-node')
EMAIL='curtis@carpy.net'
TEALOG="/tmp/tealeaf.log"
LOGZIP='3'
LOGDEL='30'
DATE=$(date +%m%d%Y)
mkdir -p $BKPDIR
echo "Running in $MODE mode"

function prt
#print to log file funtion
{
  echo "$DATE: $HOST $1" >> $TEALOG
  logger -t "$HOST tealeaf" -- "$1"
} #end prt

function running_process
#make sure a process is started
{
  if pgrep -f $1; then
    echo "$1 is started"
    prt "$1 is started"
    return 0;
  else
    echo "$1 is NOT started"
    prt "$1 is NOT started"
    return 1;
  fi
} #end running_process

function start_process
#start a process
{
  if [ -f /etc/init.d/$1 ]; then
    /etc/init.d/$1 start
  else
    prt "$1 process not found in start_process"
    echo "$1 process not found in start_process"
  fi

  if [ "$UNAME" = "Linux" ]; then
    chkconfig $1 on
  fi
} #start_process

function stop_process
#stop a process
{
  if [ -f /etc/init.d/$1 ]; then
    /etc/init.d/$1 stop
  else
    prt "$1 process not found in stop_process"
    echo "$1 process not found in stop_process"
  fi

  if [ "$UNAME" = "Linux" ]; then
    chkconfig $1 off
  fi
} #start_process

function install_pkg
{
  if [ "$UNAME" = "Debian" ]; then
    sudo apt-get -y -q install $1
    prt "$1 installed."
  elif [ "$UNAME" = "Linux" ]; then
    sudo yum -y -q install $1
    prt "$1 installed."
  else
    prt "OS $UNAME not supported for pkg install now"
    echo "OS $UNAME not supported for pkg install now"
  fi
} #end install_package

function upgrade_pkg
{
  if [ "$UNAME" = "Debian" ]; then
    sudo apt-get -y -q upgrade $1
    prt "$1 updated."
  elif [ "$UNAME" = "Linux" ]; then
    sudo yum -y -q upgrade $1
    prt "$1 updated."
  else
    prt "OS $UNAME not supported for pkg upgrade now"
    echo "OS $UNAME not supported for pkg upgrade now"
  fi
} #end upgrade_package

function delete_pkg
{
  if [ "$UNAME" = "Debian" ]; then
    sudo apt-get -y -q remove $1
    prt "$1 and dependencies removed."
  elif [ "$UNAME" = "Linux" ]; then
    sudo yum -y -q remove $1
    prt "$1 and dependencies removed."
  else
    prt "OS $UNAME not supported for pkg removal now"
    echo "OS $UNAME not supported for pkg removal now"
  fi
} #end upgrade_package

