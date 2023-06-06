#!/bin/bash

##list groups script


G=$(awk -F':' '{ print $1,", ID: ",$3 }' /etc/group )
echo "Groups:\n$G " > grps
whiptail --scrolltext --textbox grps 30 80
. ./scripts/main-menu.sh


