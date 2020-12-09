#!/bin/bash

# Device variables
address="20:19:04:03:20:18"
channel="1"
name="TNC2 2018"
alias="tnc2_2018"
rfcomm="118"

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

# Print WAIT message
printf "$newline" ;\
	printf "WAIT until script says DONE." ;\
	printf "$newline" ;\
\
# Connect device
printf "$newline" ;\
	printf "Connecting to $name..." ;\
	printf "$newline" ;\
rfcomm connect $rfcomm $address $channel &\
	sleep 5 ;\
\
# Remove old alias from /dev/
printf "$newline" ;\
	printf "Removing old alias..." ;\
	printf "$newline" ;\
rm -f /dev/$alias ;\
	sleep 1 ;\
\
# Create new alias in /dev/
printf "$newline" ;\
	printf "Creating new alias..." ;\
	printf "$newline" ;\
ln -s /dev/rfcomm$rfcomm /dev/$alias ;\
	sleep 1 ;\
\
# Check this rfcomm device listed in /dev/
printf "$newline" ;\
	printf "Device listed:" ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E rfcomm$rfcomm ;\
\
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
