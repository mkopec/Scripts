#!/bin/bash

menu="dmenu"
prompt="yubioath"
nkeys=$(ykman list | wc -l) 

while getopts "m:p:" options; do
	case "${options}" in
		"m")
			menu=$OPTARG;;
		"p")
			prompt=$OPTARG;;
	esac
	shift $((OPTIND-1))
done

if [ $nkeys == 0 ]
then
	echo "No YubiKey connected !" | $menu -p $prompt
	exit 1
else
	apps=$(ykman oath list | cut -d ':' -f 1)
	selected=$(echo -e "$apps" | $menu -p $prompt)
	ykman oath code -s $selected 
fi

