#!/bin/bash
# macOS Command Line Tool
# written and maintained by Matt Jerome - August 2020
# Provides a selection menu for commonly used macOS commands


# Downloads and installs an Applications
#Check if a script is being run using sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Re-launch using the sudo command." 
   exit 1
fi

#Check if Log File exists
function LOG {
		echo "" 
		date 
		echo "--------------------------" 
		echo "Selected Command is $cat_sel. Executing"
		if [[ $? = 0 ]]; then
			echo "Command executed successfully."
		else
			echo "Command encountered an error"
		fi
}
FILE=/Library/Logs/macos_clt.log
if test -f "$FILE"; then
    echo "$FILE exists."
else
	touch $FILE
	echo "Log file created at $FILE"
fi
#trying it out using applescript dropdown
function category {
cat_sel=$(osascript -e 'choose from list {"Show Hidden Files", "Hide Hidden Files", "list folder contents", "Jamf Inventory", "Jamf Policy-Check", "Jamf Configuration Profile Check", "Run ADE" } with title "Commands" with prompt "Please choose"')
echo "The selected category is $cat_sel"
}
category

case $cat_sel in
	"Show Hidden Files")
		defaults write com.apple.finder AppleShowAllFiles -bool TRUE >> $FILE
		killall -KILL Finder >> $FILE
		;;
	"list folder contents" )
		ls
		;;
	"Hide Hidden Files")
		defaults write com.apple.finder AppleShowAllFiles -bool FALSE >> $FILE
		killall -KILL Finder >> $FILE
		;;
	"Jamf Inventory")
		sudo jamf recon >> $FILE
		;;
	"Jamf Policy-Check")
		sudo jamf policy >> $FILE
		;;
	"Jamf Configuration Profile Check")
	    sudo jamf manage >> $FILE
		;;
	"Run ADE")
		sudo profiles renew -type enrollment >> $FILE
		;;
esac

if [[ $? -gt 0 ]]; then
	echo "There was an error, check the logs"
else
	echo "Command successful"
fi



