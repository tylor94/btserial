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
