#!/bin/bash

# This pulls in the variables file specified at runtime to fill out script appropriately
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

# Create logfile if it doesn't exist already
touch ../var/$alias.log ;\
\
# Start bluetooth connection and socat loop watchdog
while true; do
	# Connect to bluetooth device
	rfcomm connect $rfcomm $address $channel >> ../var/$alias.log 2>&1

	# Start socat loop from ser2net back to serial device
	socat pty,link=/dev/loop_$alias,raw tcp:$netaddress:$netport >> ../var/$alias.log 2>&1

	# Wait until fail, then sleep and loop
	# I'm not sure if it loops on rfcomm failure or socat failure, or both,
	# or neither actually.
	wait
	sleep 5
done &
\
# Start ser2net port
ser2net -C ipv4,$netaddress,$netport:raw:0:/dev/rfcomm$rfcomm:9600 -C 8DATABITS -C NONE -C 1STOPBIT -C max-connections=10 >> ../var/$alias.log 2>&1 &&\
\
# Print DONE message
printf "DONE." ;\
	printf "$newline" ;\
