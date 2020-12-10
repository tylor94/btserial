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
# Device watchdog
while true; do
	# Connect to bluetooth device
	rfcomm connect $rfcomm $address $channel >> ../var/$alias.log 2>&1
	# Wait until fail, then loop
	wait
	sleep 5
# Break loop into separate process
done &
\
## Start ser2net port
#ser2net -C ipv4:$netaddress:$netport:raw:0:/dev/rfcomm$rfcomm:9600 -8DATABITS -NONE -1STOPBIT -max-connections=10 &&\ #>> ../var/$alias.log 2>&1 &&\
\
# Socat watchdog
while true; do
	# Start socat serial loopback
	socat pty,link=/dev/rfloop$rfcomm,raw tcp:$netaddress:$netport >> ../var/$alias.log 2>&1
	# Wait until fail, then loop
	wait
	sleep 7
# Break loop into separate process
done &
\
# Print DONE message
printf "$newline" ;\
	printf "DONE." ;\
	printf "$newline" ;\
