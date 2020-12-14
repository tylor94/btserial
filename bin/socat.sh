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

# Variables are net address and net port and are fed in when executing script
# Break off into own process
socat pty,link=/dev/socat$2,raw tcp:$1:$2 &
