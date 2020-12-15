#!/bin/bash

# $1 = rfcomm port
# $2 = local port to send on

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

# Variables are net address and net port and are fed in when executing script
# Break off into own process
cat /dev/rfcomm$1 | netcat -lp $2
# This will cat /def/rfcomm of choice to the network port of choice
# Any resonses back in from the network currently go to stdout
# This acts like a 1-way-read-serial adapter, in which nothing travels back to the tnc
# But the tnc server can still log stout to see what was sent to it
