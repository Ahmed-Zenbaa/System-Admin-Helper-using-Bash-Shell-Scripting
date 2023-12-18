#!/bin/bash

##main script you use to run this systemadmin helper program
#
#
#make sure you  give execute permission to this script and all scripts ending with (.sh) in this directory to not have problems
#make sure you run this script with root or sudo privilege
#
#
##That's it.
##Hope you find this program helpful

if [ $(id -u) -ne 0 ]; then
	whiptail --title "Privilege Error!!" --msgbox "Please enter as root user." 8 78
	exit
fi

# installing some dependencies to run whiptail and be able to resize the window
# newt will probably be installed on your system

# Check the Linux distribution
if [ -x "$(command -v lsb_release)" ]; then
    distro=$(lsb_release -si)

    case "$distro" in
        Ubuntu)
            sudo apt-get install -y libnewt-dev &>/dev/null
            sudo apt-get install -y xterm &>/dev/null
            ;;
        CentOS)
            dnf -qy install newt &>/dev/null
            dnf -qy install xterm-resize &>/dev/null
            ;;
        *)
            exit 1
            ;;
    esac
fi

if (whiptail --title "System Admin Helper" --yesno "Start the Program?" 8 78); then
	. ./scripts/main-menu.sh
	exit
else
	whiptail --title "GoodBye!!" --msgbox "Feel free to use this simplified System Admin Helper any time.\nCreated By/ AHMED ZENBAA " 8 78
fi
