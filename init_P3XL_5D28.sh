#!/bin/bash

# Device variables
address="7C:D9:5C:B8:5D:28"
channel="8"
name="P3XL 5D28"
alias="p3xl_5d28_rfcomm128"
rfcomm="128"

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

# Connection watchdog
printf "$newline" ;\
	printf "Starting watchdog..." ;\
#	printf "$newline" ;\
while true; do
	rfcomm connect $rfcomm $address $channel >> watchdog.log 2>&1 
	wait
done &
#	sleep 5 ;\
## Connect device
#printf "$newline" ;\
#	printf "Connecting to $name..." ;\
#	printf "$newline" ;\
#rfcomm connect $rfcomm $address $channel &\
#	sleep 5 ;\
#\
# Remove old alias from /dev/
printf "$newline" ;\
	printf "Removing old alias..." ;\
#	printf "$newline" ;\
rm -f /dev/$alias ;\
	sleep 0.5 ;\
\
# Create new alias in /dev/
#printf "$newline" ;\
	printf "$newline" ;\
	printf "Creating new alias..." ;\
#	printf "$newline" ;\
ln -s rfcomm$rfcomm /dev/$alias ;\
	sleep 0.5 ;\
\
## Check this rfcomm device listed in /dev/
#printf "$newline" ;\
#	printf "Device listed:" ;\
#	printf "$newline" ;\
#ls -lah /dev/ | grep -E rfcomm$rfcomm ;\
#\
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
