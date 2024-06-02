#!/bin/env bash

SELECTION=$(echo -e "screenshot selection\nfull screenshot\nactive window\nexit" | fuzzel -d -p ">" -w 25 -l 4)


IMG="${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png"
VID="${HOME}/Videos/Recordings/$(date +%Y-%m-%d_%H-%m-%s).mp4"


case "$SELECTION" in
	"screenshot selection")
		grim -g "$(slurp)" "${IMG}"
		wl-copy < "$IMG"
		notify-send "Screenshot Taken" "${IMG}"
		;;
	"full screenshot")
		grim -c "$IMG"
		wl-copy < "${IMG}"
		notify-send "Screenshot Taken" "${IMG}"
		;;
	"active window")
	    active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
		active_window_file="${active_window_class}_$(date +%Y-%m-%d_%H-%m-%s).png"
		active_window_path="/home/almor/Pictures/Screenshots/${active_window_file}"
		hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "${active_window_path}"
		wl-copy < "${active_window_path}"
		notify-send "Screenshot Taken" "${active_window_path}"
		;;
	"exit")
		exit
		;;
*)
	;;
esac
