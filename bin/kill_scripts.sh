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

killall \
	socat \
	netcat \
	rfcomm \
	ser2net \
	# Bash last
	/bin/bash
