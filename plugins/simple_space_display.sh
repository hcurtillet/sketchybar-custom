#!/usr/bin/env zsh
source $HOME/.config/sketchybar/plugins/colors.sh

QUERY=$(yabai -m query --spaces --space $SID)
DISPLAY=$(echo $QUERY | jq -r '."display"')
if [[ $DISPLAY ]]; then
    IS_VISIBLE=$(echo $QUERY | jq -r '."is-visible"')
    HAS_FOCUS=$(echo $QUERY | jq -r '."has-focus"')
    LAST_ITEM=$(yabai -m query --displays --display $DISPLAY | jq -r '.spaces' | jq -r 'length')
    BACKGROUND_COLOR=0xff24273a
    PADDING_RIGHT=4
    PADDING_LEFT=4
    if [[ $SID = 1 ]]; then
        PADDING_LEFT=8
    fi
    if [[ $HAS_FOCUS = true ]]; then
        BACKGROUND_COLOR=$BLUE
    elif [[ $IS_VISIBLE = true ]]; then
        BACKGROUND_COLOR=0xff555555
    fi
    if [[ $SID = $LAST_ITEM ]]; then
        PADDING_RIGHT=10
    fi
    sketchybar --animate linear 10 \
        --set $NAME \
        background.color=$BACKGROUND_COLOR \
        background.padding_right=$PADDING_RIGHT \
        background.padding_left=$PADDING_LEFT \
        associated_display=$DISPLAY \
        drawing=yes
else 
    sketchybar --set $NAME \
        drawing=no
fi
