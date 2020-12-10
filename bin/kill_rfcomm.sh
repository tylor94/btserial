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
	printf "Killing rfcomm... " ;\
killall rfcomm >/dev/null 2>&1 &&\
\
# Turn bluetooth power off
printf "$newline" ;\
printf "$newline" ;\
	printf "Turning bluetooth power off... " ;\
bluetoothctl power off >/dev/null 2>&1 &&\
\
# Stop bluetooth service
printf "$newline" ;\
	printf "Stopping bluetooth service... " ;\
systemctl stop bluetooth.service 2>&1 &&\
\
# Restart bluetooth service
printf "$newline" ;\
	printf "Restarting bluetooth service... " ;\
systemctl restart bluetooth.service 2>&1 &&\
\
# Turn bluetooth power on
printf "$newline" ;\
	printf "Turning bluetooth power on... " ;\
# For some reason this command populates a bunch of uuids on screen each time it runs
# Its output is sent to /dev/null to keep it quiet for now
bluetoothctl power on >/dev/null 2>&1 &&\
\
# Print DONE message
printf "$newline" ;\
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\