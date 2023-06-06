#!/bin/bash

##add group script

while :
do 
	GROUPNAME=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Add Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
        cut -d : -f1 /etc/group | grep $GROUPNAME &>/dev/null
        if [ $? -eq 0 ]; then
                whiptail --title "Duplicated" --msgbox "Group already exists." 8 78
                continue
        else
            	break
        fi
done
groupadd "$GROUPNAME"
whiptail --msgbox "Group $GROUPNAME created successfully!" 8 78
. ./scripts/main-menu.sh

