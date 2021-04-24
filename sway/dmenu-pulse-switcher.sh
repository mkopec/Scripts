#!/bin/bash
# A simple audio sink switcher for pulseaudio using bemenu and pactl
# dmenu also works, but it's missing the -I option for highlighting the active sink
# It'll probably fail if you have multiple sinks with the exact same descriptions

prompt="pulseaudio"
menu="bemenu"
sinks=$(pactl list sinks | grep -e "Name: " -e "Description: " | sed 's/Name: //g;s/Description: //g;s/\t//g' | paste -d"\t" - -)
activesink=$(pactl info | grep "Default Sink" | sed 's/Default Sink: //g')
index=$(( $(echo "$sinks" | grep -n $activesink | cut -d : -f 1) -1))

while getopts "m:p:" options; do
	case "${options}" in
		"m")
			menu=$OPTARG;;
		"p")
			prompt=$OPTARG;;
	esac
done
shift "$((OPTIND-1))"

selection=$(echo "$sinks" | grep "$(echo "$sinks" | cut -f 2 | $menu -p $prompt -I $index)" | cut -f 1)

pactl set-default-sink $selection
