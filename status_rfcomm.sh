#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

# Check rfcomm processes currently running
printf "$newline" ;\
	printf "Processes running:" ;\
	printf "$newline" ;\
systemctl status | grep -E rfcomm | grep -vE "grep|socat|status" ;\
\
# Check rfcomm devices currently listed in /dev/
printf "$newline" ;\
	printf "Devices listed:" ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E rfcomm ;\
\
# Footer
printf "$newline" ;\
