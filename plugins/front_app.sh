#!/usr/bin/env zsh
ICON_PADDING_RIGHT=5
ICON=$($HOME/.config/sketchybar/plugins/get_app_icon.sh $INFO)
QUERY=$(yabai -m query --windows --window)
TITLE=$(echo $QUERY | jq -r ".title")

sketchybar --set $NAME icon=$ICON --set $NAME.name label="$INFO"
