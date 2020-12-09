#!/bin/bash

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

# Connection watchdog
printf "$newline" ;\
	printf "Starting watchdog... " ;\
\
# Create logfile if it doesn't exist already
touch $alias.log ;\
\
# Connection loop
while true; do
	# I put the remove/create lines within the loop to break and re-make connections
	# as bluetooth tries and retries to connect. Otherwise an alias may stay up 
	# and hold an old connection open even when there's no underlying rfcomm port
	# Remove old alias from /dev/
	rm -f /dev/$alias >> $alias.log 2>&1
	# Create new alias in /dev/
	ln -s rfcomm$rfcomm /dev/$alias >> $alias.log 2>&1
	# Connect to device
	rfcomm connect $rfcomm $address $channel >> $alias.log 2>&1
	# Wait until rfcomm fails, then loop
	wait
	# Slow the loop down to repeating no more than once every 5 seconds
	# Otherwise it would spam a reconnection as fast as possible when disconnected
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
