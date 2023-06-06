#!/bin/bash

##delete user script

while :
do 
	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Delete User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
        id $USERNAME &>/dev/null
        if [ $? -eq 0 ]; then
		val `resize`
		option=$(whiptail --title "Deletion Option of user $USERNAME" --ok-button "Select" \
		--cancel-button "Exit" --menu "Choose an option:" \
		$LINES $COLUMNS $(( $LINES - 8 )) \
		"Remove" "Remove user & Home directory of user"  \
                "Force Remove" "Force remove User & Home directory of user"  3>&1 1>&2 2>&3)

		if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi

		case $option in
		"Remove") userdel -r "$USERNAME" &>/dev/null ;;
		"Force Remove") userdel -f  "$USERNAME" &>/dev/null ;;
		esac
		whiptail --msgbox "User $USERNAME was deleted successfully!" 8 78
		. ./scripts/main-menu.sh
        else
            	whiptail --title "NOT FOUND!!" --msgbox "There is no such user\nPlease enter username correctly." 8 78
        fi
done

