#!/usr/bin/env zsh

IS_VISIBLE=$(yabai -m query --spaces --space $SID| jq -r '."is-visible"')
DISPLAY=$(yabai -m query --spaces --space $SID| jq -r '."display"')
HAS_FOCUS=$(yabai -m query --spaces --space $SID| jq -r '."has-focus"')
LAST_ITEM=$(yabai -m query --displays --display $DISPLAY | jq -r '.spaces' | jq -r 'length')
BACKGROUND_COLOR=0xff24273a
PADDING_RIGHT=4
if [[ $HAS_FOCUS = true ]]; then
    BACKGROUND_COLOR=0xfff5a97f
elif [[ $IS_VISIBLE = true ]]; then
    BACKGROUND_COLOR=0xff555555
fi
if [[ $SID = $LAST_ITEM ]]; then
    PADDING_RIGHT=10
fi
if [[ $DISPLAY ]]; then
    sketchybar --set $NAME \
        background.color=$BACKGROUND_COLOR \
        background.padding_right=$PADDING_RIGHT \
        associated_display=$DISPLAY \
        drawing=yes
else 
    echo $SID $IS_VISIBLE $DISPLAY $HAS_FOCUS $LAST_ITEM
    sketchybar --set $NAME \
        drawing=no
fi
