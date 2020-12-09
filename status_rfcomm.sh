#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

# Check script processes currently running
printf "$newline" ;\
	printf "Processes running:" ;\
	printf "$newline" ;\
systemctl status | grep -E "rfcomm|init_" | grep -vE "grep|socat|status|vim" ;\
\
# Check rfcomm devices currently listed in /dev/
printf "$newline" ;\
	printf "Devices listed:" ;\
	printf "$newline" ;\
#ls -lah /dev/ | grep -E rfcomm ;\
ls /dev/ | grep -E "rfcomm" ;\
\
# Footer
printf "$newline" ;\
