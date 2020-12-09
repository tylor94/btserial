#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

## Check for root
#if [ "$EUID" -ne 0 ]
#	then
#		$padding
#		echo "This script requires root."
#		$padding
#	exit
#fi

# Check script status
printf "$newline" ;\
printf "Script status:" ;\
printf "$newline" ;\
systemctl status | grep -E rfcomm | grep -vE "grep|socat|status" ;\
\
# Check device status
printf "$newline" ;\
printf "Device status:" ;\
printf "$newline" ;\
ls -lah /dev/ | grep -E rfcomm ;\
\
# Footer
printf "$newline" ;\
