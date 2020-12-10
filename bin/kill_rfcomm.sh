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
killall rfcomm > /dev/null 2>&1 &&\
\
# Turn bluetooth power off
bluetoothctl power off > /dev/null 2>&1 &&\
\
# Stop bluetooth service
systemctl stop bluetooth.service > /dev/null 2>&1 &&\
\
# Restart bluetooth service
systemctl restart bluetooth.service > /dev/null 2>&1 &&\
\
# Turn bluetooth power on
bluetoothctl power on > /dev/null 2>&1 &&\
