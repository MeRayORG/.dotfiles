# Pop Shell / Cosmic style focus move behavior:
# Attempt to move focus in direction; if no window in that direction, switch workspace instead
# 
# `general:no_focus_fallback = true` must be set for this script to work

direction=$1 # l/d/r/u
changeto=$2 # See https://wiki.hypr.land/Configuring/Dispatchers/#workspaces

pre=$(hyprctl -j activewindow | jq -r '.address')
hyprctl dispatch movefocus $direction
post=$(hyprctl -j activewindow | jq -r '.address')

if [[ $post = $pre ]]; then
  hyprctl dispatch workspace $changeto
fi

exit 0