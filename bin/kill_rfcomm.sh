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
killall rfcomm ;\
\
## Turn bluetooth power off
bluetoothctl power off ;\
\
# Stop bluetooth service
systemctl stop bluetooth.service ;\
\
# Restart bluetooth service
systemctl restart bluetooth.service ;\
\
## Turn bluetooth power on
bluetoothctl power on
