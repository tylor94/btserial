#!/bin/bash

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

# Pull in variable files
source $1

# Create logfile
touch ../log/ser2net_$alias.log ;\
\
# Create pidfile (currently unused)
touch ../var/ser2net_$alias.pid ;\
\
# Ser2net watchdog
while true; do
	# Start ser2net
	ser2net -n -c $2 >> ../log/ser2net_$alias.log 2>&1
	wait
	# Wait before restarting loop
	sleep 5
	wait
# Break loop into separate process
done &\
