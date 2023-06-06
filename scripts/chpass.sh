#!/bin/bash

##change password of user script

while :
do 
	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
        id $USERNAME &>/dev/null
        if [ $? -eq 0 ]; then
		PASSWORD=$(whiptail --passwordbox "Enter the new password:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
		echo $PASSWORD |passwd $USERNAME --stdin &>/dev/null
		whiptail --msgbox "Password of user $USERNAME was modified successfully!" 8 78
                . ./scripts/main-menu.sh
        else
            	whiptail --title "NOT FOUND!!" --msgbox "There is no such user\nPlease enter username correctly." 8 78
        fi
done

