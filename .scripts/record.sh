#!/bin/env bash

wf-recorder_check() {
	if pgrep -x "wf-recorder" > /dev/null; then
			pkill -INT -x wf-recorder
			notify-send "Recording saved" "$(cat /tmp/recording.txt)"
			wl-copy < "$(cat /tmp/recording.txt)"
			exit 0
	fi
}

wf-recorder_check

SELECTION=$(echo -e "record selection (mic only)\nrecord selection (desktop only)\nexit" | fuzzel -d -p "󰄀 " -w 25 -l 3)


IMG="${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png"
VID="${HOME}/Videos/Recordings/$(date +%Y-%m-%d_%H-%m-%s).mp4"


case "$SELECTION" in
	"record selection (mic only)")
		echo "$VID" > /tmp/recording.txt
		wf-recorder -a -g "$(slurp)" -f "$VID" &>/dev/null
		;;
	"record selection (desktop only)")
		echo "$VID" > /tmp/recording.txt
		wf-recorder -a=alsa_output.pci-0000_00_1b.0.analog-stereo.2.monitor -g "$(slurp)" -f "$VID" &>/dev/null
		;;
	"exit")
		exit
		;;
*)
	;;
esac

