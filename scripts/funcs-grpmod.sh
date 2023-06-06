#!/bin/bash

##group modify functions
#
#
## this script is run sourced in modgrp.sh

function addu
{
while :
do 
        user=$(whiptail --inputbox "Enter the user name you want to add to group:" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        id $user &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "The User you entered ($user) does not exist!!" 8 78
                continue
        else
            	gpasswd $GROUPNAME -a $user &>/dev/null
                if [ $? != 0 ]; then
                        whiptail --title "Error" --msgbox "The User you entered ($user) can't be added!!\nNote it must be one user at a time!!" 8 78
                        continue
                else
                    	whiptail --msgbox "User ($user) was added to group ($GROUPNAME) successfully." 8 78
                        break
                fi
        fi
done
}


function rmu
{
while :
do 
        user=$(whiptail --inputbox "Enter the user name you want to remove from group:" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
    	id $user &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "The User you entered ($user) does not exist!!" 8 78
                continue
        else
            	gpasswd $GROUPNAME -d $user &>/dev/null
		if [ $? != 0 ]; then
			whiptail --title "Error" --msgbox "The User you entered ($user) is not a member of this group ($GROUPNAME)!!" 8 78
                	continue
		else
			whiptail --msgbox "User ($user) was removed from group ($GROUPNAME) successfully." 8 78
                        break
		fi
        fi
done

}


function chm
{
while :
do 
        members=$(whiptail --inputbox "Enter the new list of members of group $GROUPNAME (comma seperated):" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        gpasswd $GROUPNAME -M $members &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "Make sure user/users you entered all exist!!\nMake sure users are comma seperated!!" 8 78
                continue
        else
                whiptail --msgbox "Memberlist of group ($GROUPNAME) was changed successfully to ($members)." 8 78
                break
        fi
done
}

