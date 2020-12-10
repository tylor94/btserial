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
touch $alias.log ;\
\
# Start ser2net port
ser2net -C ipv4,$netaddress,$netport:raw:0:/dev/rfcomm$rfcomm:9600 -C 8DATABITS -C NONE -C 1STOPBIT -C max-connections=10 ;\
\
# Loop network port back to serial device alias
# This is so a program accessing a serial device doesn't stop it from being reconnected
# Also break off into background process
#socat pty,link=/dev/$alias,raw tcp:$netaddress:$netport &\
\
# Connection watchdog
printf "$newline" ;\
	printf "Starting watchdog... " ;\
\
# Bluetooth loop
while true; do
	# Connect to device
	rfcomm connect $rfcomm $address $channel >> $alias.log 2>&1
	# Wait until rfcomm fails, then loop
	wait
	sleep 5
# Break loop off into background process
done &
\
# Socat loop
while true; do
	# Loop network port from ser2net
	socat pty,link=/dev/$alias,raw tcp:$netaddress:$netport
	# Wait until socat fails, then loop
	wait
	sleep 5
# Break loop off into background process
done &
\
# Print DONE message
	printf "DONE." ;\
	printf "$newline" ;\
\
# Footer
printf "$newline" ;\
