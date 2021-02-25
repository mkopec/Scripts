#!/bin/bash
# This script attempts to recreate Ryzen Mobile APU settings applied
# by the power slider in Windows on the Lenovo ThinkPad T14.
# Values were dumped using Renoir Mobile Tuning on Windows 10.
# Depends on ryzenadj with tskin support (supported since commit e3cb962)

loop=false
while getopts "l" options; do
	case "${options}" in
		"l")
			loop=true
			;;
	esac
done
shift $((OPTIND-1))

while true; do
	case $1 in
	low | l)
		ryzenadj --fast-limit=11000 --slow-limit=11000 --stapm-limit=11000 --tctl-temp=70 --apu-skin-temp=45
		sleep 0.1
		;;
	medium | m)
		ryzenadj --fast-limit=20000 --slow-limit=15000 --stapm-limit=15000 --tctl-temp=86 --apu-skin-temp=45
		sleep 0.1
		;;
	high | h)
		ryzenadj --fast-limit=25000 --slow-limit=23000 --stapm-limit=23000 --tctl-temp=96 --apu-skin-temp=53
		sleep 0.1
		;;
	ultra | u)
		ryzenadj --fast-limit=27000 --slow-limit=27000 --stapm-limit=27000 --tctl-temp=96 --apu-skin-temp=70
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
