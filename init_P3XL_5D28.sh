#!/bin/bash

# Device variables
address="7C:D9:5C:B8:5D:28"
channel="8"
name="P3XL 5D28"
alias="p3xl_5d28"
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

# Connect device
printf "$newline" ;\
printf "Connecting to $name..." ;\
printf "$newline" ;\
rfcomm connect $rfcomm $address $channel &\
sleep 5 ;\
\
# Remove old alias
printf "$newline" ;\
printf "Removing old alias..." ;\
printf "$newline" ;\
rm -f /dev/$alias ;\
sleep 1 ;\
\
# Create new alias
printf "$newline" ;\
printf "Creating new alias..." ;\
printf "$newline" ;\
ln -s /dev/rfcomm$rfcomm /dev/$alias ;\
sleep 1 ;\
\
# Check device status
printf "$newline" ;\
printf "Device status:" ;\
printf "$newline" ;\
printf "$(ls -lah /dev/ | grep -E rfcomm$rfcomm)" ;\
printf "$newline" ;\
\
# Print device description
printf "$newline" ;\
printf "Device description:" ;\
printf "$newline" ;\
printf "$name: rfcomm$rfcomm $alias" ;\
printf "$newline" ;\
\
# Footer
printf "$newline" ;\
