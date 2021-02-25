#!/bin/bash
# A simple script to keep the fan in a ThinkPad running at max speed.

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

stty -echo
trap restore INT

function restore() {
	echo "Restoring automatic control";
	tee /proc/acpi/ibm/fan <<< "level auto" >> /dev/null;
	exit;
}

echo "Disengaging fan watchdog, press Ctrl+C to stop"
while true
do               
	tee /proc/acpi/ibm/fan <<< "level disengaged" >> /dev/null;
	sleep 2;
done

