#!/bin/bash
# A script to close/lock a sway session using dmenu or a dmenu-compatible menu.

menu="dmenu"
prompt="power"

while getopts "m:p:" opts; do
	case "${opts}" in
		"m")
			menu=$OPTARG;;
		"p")
			prompt=$OPTARG;;
	esac
done
shift "$((OPTIND-1))"

options="Lock screen\nShut down\nSuspend\nReboot\nLog out\nReboot into Windows"

option=$(echo -e $options | $menu -p $prompt)

case $option in
	"Lock screen")
		swaylock -f;;
	"Shut down")
		systemctl poweroff;;
	"Suspend")
		systemctl suspend;;
	"Reboot")
		systemctl reboot;;
	"Log out")
		swaymsg exit;;
	"Reboot into Windows")
		systemctl reboot --boot-loader-entry=auto-windows;;
esac
