#!/bin/bash

# Pull in variable files
source $1

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

# Create logfile
touch ../var/$alias.log ;\
\
# Create pidfile
touch ../var/$alias.pid ;\
\
# Bluetooth watchdog
while true; do
	# Connect bluetooth device
	rfcomm connect $rfcomm $address $channel >> ../var/$alias.log 2>&1
	wait
	# Wait before restarting loop
	sleep 5
	wait
# Break loop into separate process
done &\
