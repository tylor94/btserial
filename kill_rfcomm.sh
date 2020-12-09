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
# Turn bluetooth power off
printf "$newline" ;\
	printf "Turning bluetooth off... " ;\
bluetoothctl power off &&\
	sleep 1 ;\
\
# Stop bluetooth to dump connections
printf "$newline" ;\
	printf "Stopping bluetooth... " ;\
systemctl stop bluetooth.service &&\
\
# Restart bluetooth
printf "$newline" ;\
	printf "Restarting bluetooth... " ;\
systemctl restart bluetooth.service &&\
\
# Turn bluetooth power on
printf "$newline" ;\
	printf "Turning bluetooth on... " ;\
# For some reason this command populates a bunch of uuids on screen each time it runs
# Its output is sent to /dev/null to keep it quiet for now
bluetoothctl power on >/dev/null 2>&1 &&\
	sleep 1 ;\
\
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
