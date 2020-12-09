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
	printf "Killing RFCOMM... " ;\
killall rfcomm &&\
\
# Restart bluetooth to dump connections
printf "$newline" ;\
	printf "Restarting bluetooth... " ;\
systemctl restart bluetooth.service &&\
\
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
