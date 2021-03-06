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

# Create logfile
touch ../log/socat_$2.log ;\
\
# Create pidfile (currently unused)
touch ../var/socat_$2.pid ;\
\
# Socat watchdog
while true; do
	# Restart xastir
	kill -SIGHUP `cat ~/.xastir/xastir.pid` >> ../log/socat_$2.log 2>&1

	# Start socat
	# Variables are net address and net port and are fed in when executing script
	# Break off into own process

	# Non-sloppy
	#socat pty,link=/dev/socat$2,raw tcp:$1:$2 >> ../log/socat_$2.log 2>&1

	# Sloppy
	socat -s pty,link=/dev/socat$2,raw tcp:$1:$2 >> ../log/socat_$2.log 2>&1
	
	wait
	# Wait before restarting loop
	sleep 5
	wait
# Break loop into separate process
done &\
