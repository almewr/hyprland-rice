IMG="${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png"
grim -c "${IMG}"
wl-copy < "$IMG"
notify-send "Screenshot Taken" "${IMG}"
