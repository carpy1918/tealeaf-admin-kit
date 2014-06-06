#!/bin/bash

#
#profile the server for mapping
#

WEBSVR=0
APPSVR=0
UTILSVR=0
DBSVR=0
FILESVR=0

WEB=( http nginx lighttpd cherokee savant roxen )
APP=( tomcat weblogic websphere jboss glassfish coldfusion iplanet wildfly )
UTIL=( named dhcpd ldapd )
FILE=( nfs )

for i in "${WEB[@]}";do
  if [ pgrep $i ];then
    $WEBSVR=1
    prt "SVR-TYPE: type: web server $i found"
  fi
done

for i in "${APP[@]}";do
  if [ pgrep $i ];then
    $APPSVR=1
    prt "SVR-TYPE: type: app server $i found"
  fi
done

for i in "${UTIL[@]}";do
  if [ pgrep $i ];then
    $UTILSVR=1
    prt "SVR-TYPE: type: util server $i found"
  fi
done

for i in "${FILE[@]}";do
  if [ pgrep $i ];then
    $FILESVR=1
    prt "SVR-TYPE: type: file server $i found"
  fi
done

prt "SVR-TYPE: `hostname`: WEBSVR: $WEBSVR APPSVR: $APPSVR UTILSVR: $UTILSVR DBSVR: $DBSVR FILESVR: $FILESVR"

