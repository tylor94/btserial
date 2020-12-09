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

# Connection watchdog
printf "$newline" ;\
	printf "Starting watchdog..." ;\
while true; do
	# Remove old alias from /dev/
	rm -f /dev/$alias >> watchdog.log 2>&1
	# Create new alias in /dev/
	ln -s rfcomm$rfcomm /dev/$alias >> watchdog.log 2>&1
	# Connecting to device
	rfcomm connect $rfcomm $address $channel >> watchdog.log 2>&1
	# Wait until rfcomm above fails, then loop
	wait
# Break loop off into background process
done &
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
