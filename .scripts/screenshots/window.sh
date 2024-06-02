active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
active_window_file="${active_window_class}_$(date +%Y-%m-%d_%H-%m-%s).png"
active_window_path="/home/almor/Pictures/Screenshots/${active_window_file}"

hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "${active_window_path}"
wl-copy < "${active_window_path}"
notify-send "Screenshot Taken" "${active_window_path}"
