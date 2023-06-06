#!/bin/bash

## add user script

while :
do 
	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Add User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
	id $USERNAME &>/dev/null
	if [ $? -eq 0 ]; then
		whiptail --title "Duplicated" --msgbox "User already exists." 8 78
		continue
	else
		break
	fi
done
PASSWORD=$(whiptail --passwordbox "Enter the password:" 8 78 --title "Add User" 3>&1 1>&2 2>&3)
useradd $USERNAME
echo $PASSWORD |passwd $USERNAME --stdin &>/dev/null
whiptail --msgbox "User $USERNAME created successfully!" 8 78
. ./scripts/main-menu.sh
