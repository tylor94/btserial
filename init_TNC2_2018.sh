#!/bin/bash

# Device variables
# Bluetooth address
address="20:19:04:03:20:18"
# Service channel on bluetooth device
channel="1"
# Device pretty name
name="TNC2 2018"
# Device machine name
# NO SPACES
alias="tnc2_2018"
# RFcomm port
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
