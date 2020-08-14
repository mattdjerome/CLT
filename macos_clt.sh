#!/bin/bash

#Check if a script is being run using sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Re-launch using the sudo command." 
   exit 1
fi

echo "Please choose a command:"
options=("Run Jamf Enrollment" "Monitor Network Traffic" "Deactivate Software Updates")
select opt in "${options[@]}" "Quit"; do
case $options in
        "Run Jamf Enrollment")
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