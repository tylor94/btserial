#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

# Check for root
if [ "$EUID" -ne 0 ]
	then
		$padding
		echo "This script requires root."
		$padding
	exit
fi

# Kill rfcomm
printf "$newline" ;\
printf "Killing RFCOMM..." ;\
printf "$newline" ;\
killall rfcomm ;\
\
# Restart bluetooth to dump connections
printf "$newline" ;\
printf "Restarting bluetooth..." ;\
printf "$newline" ;\
systemctl restart bluetooth.service ;\
sleep 1 ;\
\
# Double check bluetooth came back up
printf "$newline" ;\
printf "Current bluetooth status:" ;\
printf "$newline" ;\
systemctl status bluetooth.service ;\
\
# Footer
printf "$newline" ;\
