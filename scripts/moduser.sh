#!/bin/bash

## modify user script
#
#
# funcs-usermod.sh contain the functions used here to modify user settings 

. ./scripts/funcs-usermod.sh

function modify() {
	eval `resize`
	MOD=$(whiptail --title "Modify options for user $USERNAME " --ok-button "Select" \
	--cancel-button "Exit" --menu "Choose an option" \
	$LINES $COLUMNS $(( $LINES - 8 )) \
	"UID" "The new numerical value of the user's ID." \
	"Comment" "Text string, Full Name, Email, Phone, ...etc." \
	"New Home" "The User's new login directory." \
	"Move Home" "The User's new login directory." \
	"GID" "The Group name or number of the user's new initial login group." \
	"Add Groups" "A list of supplementary groups you want the user to be a member of." \
	"Min Days" "The minimum number of days between password changes." \
        "Max Days" "The maximum number of days during which a password is valid." \
	"Expire Date" "the date on which the user acount will be disabled." \
	"Inactive" "The number of days after expiry untill the account is permanently disabled." \
	"Shell" "the path of the user's new login shell." \
	3>&1 1>&2 2>&3)

	if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi

	case $MOD in
	"UID")  uid; modify; exit ;;
	"Comment")  comment; modify; exit ;;
	"New Home")  newhome; modify; exit ;;
	"Move Home")  movehome; modify; exit ;;
	"GID")  gid; modify; exit ;;
	"Add Groups")  groups; modify; exit ;;
	"Min Days")  min; modify; exit ;;
        "Max Days")  max; modify; exit ;;
	"Expire Date")  expire; modify; exit ;;
	"Inactive")  inactive; modify; exit ;;
	"Shell")  shell; modify; exit ;;
	*) whiptail --title "Strange Error!!" --msgbox "Please Re-run the program." 8 78
	esac
}


while :
do 
   	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
        id $USERNAME &>/dev/null
        if [ $? -eq 0 ]; then
		modify
                . ./scripts/main-menu.sh
        else
            	whiptail --title "NOT FOUND!!" --msgbox "There is no such user\nPlease enter username correctly." 8 78
        fi
done

