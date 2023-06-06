#!/bin/bash

##list users script


#USERS=$(awk -F':' '{ print $1,$3 }' /etc/passwd)
#echo "Users:\n $USERS" > users
#whiptail --scrolltext --textbox users 30 80
#. ./scripts/main-menu.sh


USERS=$(awk -F':' '{ if ( $7 == "/bin/bash" )print "UID " $3 " : " $1 " (bash shell user)" } { if ( $7 != "/bin/bash" )print "UID " $3 " : " $1 }' /etc/passwd)
echo "Users:\n$USERS" > users
whiptail --scrolltext --textbox users 30 80
. ./scripts/main-menu.sh
