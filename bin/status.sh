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
printf " ---------- ---------- ----------" ;\
	printf "$newline" ;\
printf "Processes running: " ;\
	printf "$newline" ;\
printf "$newline" ;\
printf "Device & init:" ;\
	printf "$newline" ;\
systemctl status | grep -E "_device|init_|launch_xastir" | grep -vE "grep|vim" ;\
	printf "$newline" ;\
printf "RFcomm:" ;\
	printf "$newline" ;\
systemctl status | grep -E "rfcomm" | grep -vE "grep|vim" ;\
	printf "$newline" ;\
printf "Ser2net:" ;\
	printf "$newline" ;\
systemctl status | grep -E "ser2net" | grep -vE "grep|vim|bin" ;\
	printf "$newline" ;\
printf "Everything else:" ;\
	printf "$newline" ;\
systemctl status | grep -E "socat|netcat|aprx|gps|ntp|xastir" | grep -vE "grep|vim|bin" ;\
	printf "$newline" ;\
\
# Check rfcomm devices currently listed in /dev/
printf " ---------- ---------- ----------" ;\
	printf "$newline" ;\
printf "Serial devices: " ;\
	printf "$newline" ;\
printf "$newline" ;\
ls -lah /dev/ | grep -E "AMA|USB" ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E "rfcomm" ;\
	printf "$newline" ;\
ls -lah /dev/ | grep -E "loop_|rfloop|socat" ;\
	printf "$newline" ;\
\
# Check ser2net network ports currently listed in netstat
printf " ---------- ---------- ----------" ;\
	printf "$newline" ;\
printf "Network ports: " ;\
	printf "$newline" ;\
printf "$newline" ;\
netstat -ntulp | grep -E "ser2net|socat|gps|init" ;\
	printf "$newline" ;\
\
# Check systemctl services status
printf " ---------- ---------- ----------" ;\
	printf "$newline" ;\
printf "Systemctl service status: " ;\
	printf "$newline" ;\
printf "$newline" ;\
printf "Ser2net: " ;\
	printf "$newline" ;\
systemctl status ser2net | grep -E "Active:" ;\
printf "$newline" ;\
printf "APRX: " ;\
	printf "$newline" ;\
systemctl status aprx | grep -E "Active:" ;\
printf "$newline" ;\
printf "GPSd Socket: " ;\
	printf "$newline" ;\
systemctl status gpsd.socket | grep -E "Active:" ;\
printf "$newline" ;\
printf "GPSd Service: " ;\
	printf "$newline" ;\
systemctl status gpsd.service | grep -E "Active:" ;\
printf "$newline" ;\
printf "NTP: " ;\
	printf "$newline" ;\
systemctl status ntp | grep -E "Active:" ;\
