#!/bin/bash

##user modify functions
#
#
## this script is run sourced in moduser.sh

function uid {
while :
do 
   	ID=$(whiptail --inputbox "Enter the new UID:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        cut -d : -f3 /etc/passwd | grep -w $ID &>/dev/null
        if [ $? -eq 0 ]; then
                whiptail --title "Duplicated" --msgbox "This UID already exists." 8 78
                continue
        elif [ $(($ID)) -lt 1000 ]; then
		whiptail --title "Not Viable" --msgbox "This UID can't be assigned to a user.\nMust be >= 1000" 8 78
		continue
	else
            	usermod -u $ID $USERNAME
		whiptail --msgbox "User ID of user $USERNAME was changed successfully." 8 78
		break
        fi
done
}


function comment {
while :
do
	comm=$(whiptail --inputbox "Enter the comment you want:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	if [ -z $comm ]; then
		whiptail --msgbox "No input was registered! & No modification was done to the user $USERNAME.\nTry Again!!" 8 78
		continue
	else
		usermod -c $comm $USERNAME
		whiptail --msgbox "The comment of user $USERNAME was added successfully." 8 78
		break
	fi
done
}


function newhome {
while :
do
	home=$(whiptail --inputbox "Enter the new home directory:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	case $home in
	/*)
	usermod -d $home $USERNAME &>/dev/null
	whiptail --msgbox "Home directory of user $USERNAME was changed successfully." 8 78
	break ;;
	*)
	whiptail --msgbox "This is not a valid path.\nIt must start with (/)." 8 78
	continue  ;;
	esac
done
}


function movehome {
while :
do
  	home=$(whiptail --inputbox "Enter the new home directory:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        case $home in
        /*)
	usermod -m -d $home $USERNAME &>/dev/null
        whiptail --msgbox "Home directory of user $USERNAME was changed successfully." 8 78
        break ;;
        *)
        whiptail --msgbox "This is not a valid path.\nIt must start with (/)." 8 78  
        continue  ;;
        esac
done
}


function gid {
while :
do 
   	GROUPNAME=$(whiptail --inputbox "Enter the new initial login group name or number:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
        cut -d : -f1,3 /etc/group | grep -w $GROUPNAME &>/dev/null
        if [ $? -eq 0 ]; then
		usermod -g $GROUPNAME $USERNAME
#		x=$(cat /etc/group | grep -w $GROUPNAME | cut -d : -f3 /etc/group)
#		if [ cat /etc/passwd | grep -w $USERNAME | cut -d : -f4 | grep -w  ]
                whiptail --msgbox "initial group of user $USERNAME was changed successfully." 8 78
                break
        else
            	whiptail --title "NOT FOUND!!" --msgbox "There is no such Group\nPlease enter Group name or number correctly." 8 78
		continue
        fi
done
}


function groups {
while :
do 
        GROUPs=$(whiptail --inputbox "Enter the supplementary groups' names or IDs (comma seperated):" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
	usermod -aG $GROUPs $USERNAME &>/dev/null
        if [ $? -eq 0 ]; then
                whiptail --msgbox "user $USERNAME was added to the supplementary groups successfully." 8 78
                break
        else
                whiptail --title "Error!!" --msgbox "There must be a group incorrectly written\nPlease enter groups correctly." 8 78
                continue
        fi
done
}


function min {
while :
do
  	mn=$(whiptail --inputbox "Enter the minimum number of days:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        if [[ $mn ]] && [ $mn -eq $mn 2>/dev/null ]; then
                chage -m $mn $USERNAME
                whiptail --msgbox "Min number of days between password changes for user $USERNAME was changed successfully." 8 78
                break
        else
                whiptail --msgbox "Your input is not a number or not entirely a number!!\nPlease enter a valid number." 8 78
                continue
        fi
done
}


function max {
while :
do
  	mx=$(whiptail --inputbox "Enter the maximum number of days:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        if [[ $mx ]] && [ $mx -eq $mx 2>/dev/null ]; then
                chage -M $mx $USERNAME
                whiptail --msgbox "Max number of days during which a password is valided for user $USERNAME was changed successfully." 8 78
                break
        else
                whiptail --msgbox "Your input is not a number or not entirely a number!!\nPlease enter a valid number." 8 78
                continue
        fi
done
}


function expire {
while :
do
        xpr=$(whiptail --inputbox "Enter the expiry date in format (YYYY-MM-DD):" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
	date "+%Y-%m-%d" -d "$xpr" > /dev/null  2>&1
	if [ $? != 0 ]; then
		whiptail --msgbox "Date $xpr is not a valid YYYY-MM-DD date." 8 78
    		continue
	else
		chage -E $xpr $USERNAME &>/dev/null
		if [ $? != 0 ]; then
			whiptail --msgbox "Date $xpr is not a valid YYY-MM-DD date." 8 78
			continue
		else
			whiptail --msgbox "Expiry date of user $USERNAME was changed successfully." 8 78
			break
		fi
	fi
done
}


function inactive {
while :
do
        inactv=$(whiptail --inputbox "Enter number of days after expiry for account to be permanently disabled:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
	if [[ $inactv ]] && [ $inactv -eq $inactv 2>/dev/null ]; then
     		chage -I $inactv $USERNAME
        	whiptail --msgbox "inactive period of user $USERNAME was changed successfully." 8 78
                break
  	else
		whiptail --msgbox "Your input is not a number or not entirely a number!!\nPlease enter a valid number." 8 78
                continue
  	fi
done
}


function shell {
while :
do
        shl=$(whiptail --inputbox "Enter the new shell:\n(Make sure it's installed and executable)!!" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        case $shl in
        /*)
        usermod -s $shl $USERNAME &>/dev/null
        whiptail --msgbox "Shell of user $USERNAME was changed successfully." 8 78
	break ;;
        *)
	whiptail --msgbox "This is not a valid shell.\nIt must start with (/), installed and be executable." 8 78
        continue  ;;
        esac
done
}

