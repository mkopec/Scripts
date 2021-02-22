#!/bin/bash
# This script attempts to recreate Ryzen Mobile APU settings applied
# by the power slider in Windows on the Lenovo ThinkPad T14.
# Values were dumped using Renoir Mobile Tuning on Windows 10.
# The script depends on RyzenAdj with tskin support patched in.

loop=false
while getopts "l" options; do
	case "${options}" in
		"l")
			loop=true
			;;
	esac
	shift $((OPTIND-1))
done


while true; do
	case $1 in
	low | l)
		/home/michal/Scripts/ryzenadj --fast-limit=11000 --slow-limit=11000 --stapm-limit=11000 --tctl-temp=70 --tskin-temp=11520
		sleep 0.1
		;;
	medium | m)
		/home/michal/Scripts/ryzenadj --fast-limit=20000 --slow-limit=15000 --stapm-limit=15000 --tctl-temp=86 --tskin-temp=11520
		sleep 0.1
		;;
	high | h)
		/home/michal/Scripts/ryzenadj --fast-limit=25000 --slow-limit=23000 --stapm-limit=23000 --tctl-temp=96 --tskin-temp=13568
		sleep 0.1
		;;
	ultra | u)
		/home/michal/Scripts/ryzenadj --fast-limit=27000 --slow-limit=27000 --stapm-limit=27000 --tctl-temp=96 --tskin-temp=13568
		sleep 0.1
		;;
	*)
		echo "Incorrect mode specified"
		break
		;;
	esac

	if [ $loop == false ]; then
		break
	fi
done
