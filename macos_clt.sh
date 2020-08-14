#!/bin/bash

#Check if a script is being run using sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Re-launch using the sudo command." 
   exit 1
fi

echo "Please choose a command:"
options=("Renew Automated Device Enrollment" "Monitor Network Traffic" "Deactivate Software Updates" "Quit")
select opt in "${options[@]}"
do
case $opt in
        "Renew Automated Device Enrollment")
            /usr/bin/proflies -renew type enrollment
            ;;
        "Monitor Network Traffic")
            nettop
            ;;
        "Deactivate Software Updates")
            /usr/sbin/softwareupdate --schedule off
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done