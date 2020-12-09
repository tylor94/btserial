#!/bin/bash

# Device variables
# Bluetooth address
address="7C:D9:5C:B8:5D:28"
# Service channel on bluetooth device
channel="8"
# Device pretty name
name="P3XL 5D28"
# Device machine name
# NO SPACES
alias="p3xl_5d28"
# RFcomm port
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
	printf "Starting watchdog... " ;\
\
# Create logfile if it doesn't exist already
touch $alias.log ;\
\
# Connection Loop
while true; do
	# Remove old alias from /dev/
	rm -f /dev/$alias >> $alias.log 2>&1
	# Create new alias in /dev/
	ln -s rfcomm$rfcomm /dev/$alias >> $alias.log 2>&1
	# Connect to device
	rfcomm connect $rfcomm $address $channel >> $alias.log 2>&1
	# Wait until rfcomm fails, then loop
	wait
# Break loop off into background process
done &
\
# Print DONE message
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
