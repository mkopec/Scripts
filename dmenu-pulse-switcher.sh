#!/bin/bash
# A simple audio switcher for pulseaudio using dmenu or a dmenu-compatible menu.

prompt="pulseaudio"
menu="dmenu"
devices=$(pacmd list-sinks | grep -e index -e device.description | sed 's/index://g;s/device.description = "//g;s/\t//g;s/"//g' | paste -d" " - -)
activeindex=$(( $(echo "$devices" | grep -n "*" | cut -d : -f 1) -1))

while getopts "m:p:" options; do
	case "${options}" in
		"m")
			menu=$OPTARG;;
		"p")
			prompt=$OPTARG;;
	esac
done
shift "$((OPTIND-1))"

selected=$(echo "$devices" | $menu -p $prompt -I $activeindex | sed 's@^[^0-9]*\([0-9]\+\).*@\1@')

pactl set-default-sink $selected
