#!/bin/bash

##delete group script

while :
do 
	GROUPNAME=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Delete Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
	cut -d : -f1 /etc/group | grep $GROUPNAME &>/dev/null
        if [ $? -eq 0 ]; then
		groupdel "$GROUPNAME"
		whiptail --msgbox "Group $GROUPNAME deleted successfully!" 8 78
                . ./scripts/main-menu.sh
        else
            	whiptail --title "NOT FOUND!!" --msgbox "There is no such Group\nPlease enter Group name correctly." 8 78
        fi
done

