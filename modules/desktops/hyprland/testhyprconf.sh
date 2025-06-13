#!/usr/bin/env bash

# hyprland-watch.sh
set -euo pipefail

CONFIG_NIX=./config
OUT_CONF=~/.config/hypr/hyprland.conf
LOCK=/tmp/hyprland-watch.lock

# Debounce: avoid parallel runs
exec 200> "$LOCK"
flock -n 200 || exit 0

while inotifywait -e close_write,moved_to,create "$CONFIG_NIX"; do
  echo "Detected change. Rebuilding hyprland.conf..."

  nix eval --raw --expr "
    let
      lib = import <home-manager>/lib;
      cfg = import $CONFIG_NIX {};
    in lib.generators.toINI cfg.settings
  " > "$OUT_CONF.new"

  mv "$OUT_CONF.new" "$OUT_CONF"
  echo "Reloading Hyprland..."
  hyprctl reload
done
