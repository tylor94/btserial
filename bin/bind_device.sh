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
touch ../log/device_$alias.log ;\
\
# Create pidfile (currently unused)
touch ../var/device_$alias.pid ;\
\
# Bind rfcomm
rfcomm bind $rfcomm $address $channel & >> ../log/device_$alias.log 2>&1
