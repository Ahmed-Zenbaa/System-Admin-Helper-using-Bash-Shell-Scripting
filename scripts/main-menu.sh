#!/bin bash

## main menu script
#
#
# contains the main menu of the project
#
#
## make sure you don't alter paths of any scripts in this program without changing their script run path here

eval `resize`
choice=$(whiptail --title "Main Menu" --ok-button "Select" \
 --cancel-button "Exit" --menu "Choose an option" \
$LINES $COLUMNS $(( $LINES - 8 )) \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"Delete User" "Delete an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"Delete Group" "Delete an existing group." \
"List Groups" "List all groups on the system." \
"Disable User" "Lock the user account." \
"Enable User" "Unlock the user account." \
"Change Password" "Change passsword of a user." \
3>&1 1>&2 2>&3)

if [ $? != 0 ]; then ./scripts/exit.sh; exit; fi

case $choice in
"Add User")  ./scripts/adduser.sh; exit ;;
"Modify User")  ./scripts/moduser.sh; exit ;;
"Delete User")  ./scripts/deluser.sh; exit ;;
"List Users")  ./scripts/lstusers.sh; exit ;;
"Add Group")  ./scripts/addgrp.sh; exit ;;
"Modify Group")  ./scripts/modgrp.sh; exit ;;
"Delete Group")  ./scripts/delgrp.sh; exit ;;
"List Groups")  ./scripts/lstgrps.sh; exit ;;
"Disable User")  ./scripts/disuser.sh; exit ;;
"Enable User")  ./scripts/enuser.sh; exit ;;
"Change Password")  ./scripts/chpass.sh; exit ;;
*) whiptail --title "Strange Error!!" --msgbox "Please Re-run the program." 8 78
esac
