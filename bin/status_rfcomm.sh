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

# Check script processes currently running
printf "$newline" ;\
	printf "Processes running: " ;\
	printf "$newline" ;\
systemctl status | grep -E "rfcomm|init_|socat|test" | grep -vE "grep|status|vim|kern" ;\
\
# Check rfcomm devices currently listed in /dev/
printf "$newline" ;\
	printf "Serial devices: " ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E "rfcomm|loop_" ;\
\
# Check ser2net network ports currently listed in netstat
printf "$newline" ;\
	printf "Network ports: " ;\
	printf "$newline" ;\
netstat -ntulp | grep -E "ser2net|socat" ;\
\
# Footer
printf "$newline" ;\
