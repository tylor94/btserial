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

# Variables are net address and net port fed when executing script
socat pty,link=/dev/socat,raw tcp:$1:$2
