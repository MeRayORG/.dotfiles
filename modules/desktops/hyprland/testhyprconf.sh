#!/usr/bin/env bash

# hyprland-watch.sh
set -euo pipefail

ENTRY_FILE=./config
WATCH_DIR=./config
OUT_CONF=~/.config/hypr/hyprland.conf
CHECK_INTERVAL=1

# Build an associative array of file mtimes
declare -A file_times

function record_times() {
  for f in "$ENTRY_FILE" "$WATCH_DIR"**/*; do
    [[ -f "$f" ]] || continue
    file_times["$f"]=$(stat -c %Y "$f")
  done
}

function changed() {
  local found_change=1
  for f in "$ENTRY_FILE" "$WATCH_DIR"**/*; do
    [[ -f "$f" ]] || continue
    new_time=$(stat -c %Y "$f")
    old_time="${file_times["$f"]-}"
    if [[ "$new_time" != "$old_time" ]]; then
      found_change=0
    fi
    file_times["$f"]="$new_time"
  done
  return $found_change
}
record_times

while true; do
  sleep "$CHECK_INTERVAL"
  if changed; then
    echo "Change detected. Rebuilding..."

    nix eval --impure --raw --expr "
      let
        lib = import <nixpkgs/lib>;
        attrs = import ${ENTRY_FILE} {inherit lib;};
        homer = fetchTarball \"https://github.com/nix-community/home-manager/archive/master.tar.gz\";
        homerlib = (import \"\${homer}/modules/lib\") {inherit lib;};
      in homerlib.generators.toHyprconf {inherit attrs;}
    " > "$OUT_CONF.new" && mv "$OUT_CONF.new" "$OUT_CONF"

    echo "Reloading Hyprland..."
    hyprctl reload

    record_times  # update timestamps
  fi
done