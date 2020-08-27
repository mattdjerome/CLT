#!/bin/bash

#Check if a script is being run using sudo
# if [[ $EUID -ne 0 ]]; then
#    echo "This script must be run as root. Re-launch using the sudo command." 
#    exit 1
# fi

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
cat_sel=$(osascript -e 'choose from list {"Show Hidden Files", "Hide Hidden Files", "list folder contents", "Jamf Inventory", "Jamf Policy-Check", "Jamf Configuration Profile Check", "Run ADP Enrollment" } with title "Commands" with prompt "Please choose"')
echo "The selected category is $cat_sel"
}
category

case $cat_sel in
	"Show Hidden Files")
		defaults write com.apple.finder AppleShowAllFiles -bool TRUE >> $FILE
		killall -KILL Finder >> $FILE
		LOG >> $FILE
		;;
	"list folder contents" )
		ls
		LOG >> $FILE
		;;
esac

