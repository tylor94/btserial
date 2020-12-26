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
	printf "Processes running: " ;\
	printf "$newline" ;\
systemctl status | grep -E "init_device|init_nonet_device|rfcomm|socat|ser2net|aprx|gps" | grep -vE "grep|status|vim" ;\
	printf "$newline" ;\
\
# Check rfcomm devices currently listed in /dev/
	printf "Serial devices: " ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E "rfcomm|loop_|rfloop|socat" ;\
	printf "$newline" ;\
\
# Check ser2net network ports currently listed in netstat
	printf "Network ports: " ;\
	printf "$newline" ;\
netstat -ntulp | grep -E "ser2net|socat|gps" ;\
	printf "$newline" ;\
\
# Check systemctl services status
printf "Systemctl service status: " ;\
	printf "$newline" ;\
printf "Ser2net: " ;\
	printf "$newline" ;\
systemctl status ser2net | grep -E ".status|Active:" ;\
printf "Aprx: " ;\
	printf "$newline" ;\
systemctl status aprx | grep -E ".status|Active:" ;\
printf "GPSd: " ;\
	printf "$newline" ;\
systemctl status gpsd | grep -E ".status|Active:" ;\
printf "NTP: " ;\
	printf "$newline" ;\
systemctl status ntp | grep -E ".status|Active:" ;\