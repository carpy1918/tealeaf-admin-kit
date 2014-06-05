#!/bin/bash

#
#verify auditd is installed and running
#

INSTALLED=0

#is auditd installed
##
if [ "$UNAME" = "Debian" ];then
  value=`dpkg --get-selections | grep auditd`
  if [ "$value" = '' ]; then
    prt "AUDITD: auditd not installed"
  else
    prt "AUDITD: auditd installed"
    $INSTALLED=1
elif [ "$UNAME" = "Linux" ];then
   value=`rpm -qa | grep auditd`
  if [ "$value" = '' ]; then
    prt "AUDITD: auditd not installed"
  else
    prt "AUDITD: auditd installed"
    $INSTALLED=1
else
  prt "AUDITD: $UNAME OS not supported"  
fi

if [ "$MODE" = "EXECUTE" ] && [ $INSTALLED = 0 ] && [ "$UNAME" = "Debian" ];then
  aptitude -y install auditd
elif [ "$MODE" = "EXECUTE" ] && [ $INSTALLED = 0 ] && [ "$UNAME" = "Linux" ];then
  yum -y install auditd
fi

#is auditd running
##
RUNNING=`ps aux | grep "/sbin/auditd"`
if [ "$RUNNING" = '' ];then
  prt "AUDITD: service not running"
else
  prt "AUDITD: service is running"
fi

