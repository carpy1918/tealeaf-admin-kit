#!/bin/bash

#
#find password hash used
#

. /home/curt/tealeaf-svn/scripts/tealeaf-env.sh

value=`grep ^ENCRYPT_METHOD /etc/login.defs`
prt "password hash is $value. this is modified by configure-templates/login.defs-mod"

