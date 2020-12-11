#!/bin/bash

# Network address
netaddress="$2"

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
	# Cat serial loop to kill it if we're restarting rfcomm
	# Breaks off into own loop and dies if rfcomm is dead, which
	# it probably is because the loop is restarting
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
## Start ser2net port
#ser2net -C ipv4,$netaddress,$netport:raw:0:/dev/rfcomm$rfcomm:9600 -C 8DATABITS -C NONE -C 1STOPBIT -C max-connections=10 >> ../var/$alias.log 2>&1 ;\
\
# Start ser2net service instead of running single line config
systemctl start ser2net >> ../var/$alias.log 2>&1 ;\
\
# Socat watchdog
while true; do
	# Start serial loopback
	socat pty,link=/dev/rfloop$rfcomm,raw tcp:$netaddress:$netport >> ../var/$alias.log 2>&1
	wait
	# Wait before restarting loop
	sleep 7
	wait
# Break loop into separate process
done &\
