#!/bin/bash

## modify group script
#
#
# funcs-grpmod.sh contain the functions used here to modify group settings 

. ./scripts/funcs-grpmod.sh 

function modifyg() {
        eval `resize`
        MOD=$(whiptail --title "Modify options for group $GROUPNAME " --ok-button "Select" \
        --cancel-button "Exit" --menu "Choose an option" \
        $LINES $COLUMNS $(( $LINES - 8 )) \
        "Add User" "Add a user to the group." \
        "Remove User" "Remove a user from the group." \
        "Chg Members" "Change whole Memberlist of the group." \
        3>&1 1>&2 2>&3)


        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi

        case $MOD in
        "Add User")  addu; modifyg; exit ;;
        "Remove User")  rmu; modifyg; exit ;;
        "Chg Members")  chm; modifyg; exit ;;
        *) whiptail --title "Strange Error!!" --msgbox "Please Re-run the program." 8 78
        esac
}


while :
do 
        GROUPNAME=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
        cut -d : -f1 /etc/group | grep $GROUPNAME  &>/dev/null
        if [ $? -eq 0 ]; then
                modifyg
                . ./scripts/main-menu.sh
        else
                whiptail --title "NOT FOUND!!" --msgbox "There is no such Group!!\nPlease enter group name correctly." 8 78
		continue
        fi
done

