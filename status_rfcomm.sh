#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

# Check rfcomm processes
printf "$newline" ;\
	printf "RFcomm processes:" ;\
	printf "$newline" ;\
systemctl status | grep -E rfcomm | grep -vE "grep|socat|status" ;\
\
# Check device status
printf "$newline" ;\
	printf "Device status:" ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E rfcomm ;\
\
# Footer
printf "$newline" ;\
