#!/bin/bash

# Pull in variable files
source $1

# Network address
netaddress="$2"

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
	# Cat serial loop to kill it if we're restarting rfcomm
	# Breaks off into own loop and dies if rfcomm is dead,
	# which rfcomm probably is because the loop is restarting
	cat /dev/rfloop$rfcomm >> ../var/$alias.log 2>&1 &
	wait
	sleep 1
	wait
	# Connect bluetooth device
	rfcomm connect $rfcomm $address $channel >> ../var/$alias.log 2>&1
	wait
	# Wait before restarting loop
	sleep 5
	wait
# Break loop into separate process
done &\
\
# Ser2net watchdog
while true; do
	# Start ser2net
	ser2net -n -c ser2net_$1 >> ../var/$alias.log 2>&1
	wait
	# Wait before restarting loop
	sleep 5
	wait
# Break loop into separate process
done &\
