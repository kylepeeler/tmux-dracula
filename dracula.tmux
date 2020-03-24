#!/usr/bin/env bash

# Author: Dane Williams
# a theme for tmux inspired by dracula

# source and run dracula theme

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$current_dir/scripts/dracula.sh
source "$CURRENT_DIR/scripts/helpers.sh"

spotify_artist="#($CURRENT_DIR/scripts/spotify_artist.sh)"
spotify_album="#($CURRENT_DIR/scripts/spotify_album.sh)"
spotify_track="#($CURRENT_DIR/scripts/spotify_track.sh)"
spotify_status="#($CURRENT_DIR/scripts/spotify_status.sh)"

artist_interpolation="\#{spotify_artist}"
album_interpolation="\#{spotify_album}"
track_interpolation="\#{spotify_track}"
status_interpolation="\#{spotify_status}"

do_interpolation() {
  local output="$1"
  local output="${output/$artist_interpolation/$spotify_artist}"
  local output="${output/$album_interpolation/$spotify_album}"
  local output="${output/$track_interpolation/$spotify_track}"
  local output="${output/$status_interpolation/$spotify_status}"
  echo "$output"
}

updae_tmux_uptime() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_uptime "status-right"
  update_tmux_uptime "status-left"
}
main
