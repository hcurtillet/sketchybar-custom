#!/usr/bin/env zsh
source $HOME/.config/sketchybar/plugins/colors.sh

QUERY=$(yabai -m query --spaces --space $SID)
DISPLAY=$(echo $QUERY | jq -r '."display"')
if [[ $DISPLAY ]]; then
    IS_VISIBLE=$(echo $QUERY | jq -r '."is-visible"')
    HAS_FOCUS=$(echo $QUERY | jq -r '."has-focus"')
    LAST_ITEM=$(yabai -m query --displays --display $DISPLAY | jq -r '.spaces' | jq -r 'length')
    APPS=$(yabai -m query --windows --space $SID | jq '.[].app')
    LABEL=''
    COLOR=0xffcad3f5
    if grep -q "\"" <<< $APPS;
    then
        APPS_ARR=()
        while read -r line; do APPS_ARR+=("$line"); done <<< "$APPS"
        for APP in $APPS_ARR; do
            APP_NAME=$(echo $APP | sed 's/"//g')
            ICON=$($HOME/.config/sketchybar/plugins/get_app_icon.sh $APP_NAME)
            LABEL+="$ICON "
        done
    else
        LABEL+="_"
    fi
    BACKGROUND_COLOR=0xff24273a
    PADDING_RIGHT=2
    PADDING_LEFT=2
    if [[ $SID = 1 ]]; then
        PADDING_LEFT=0
    fi
    if [[ $HAS_FOCUS = true ]]; then
        BACKGROUND_COLOR=$BLUE
        COLOR=0xff000000
    elif [[ $IS_VISIBLE = true ]]; then
        BACKGROUND_COLOR=0xff444444
    fi
    if [[ $SID = $LAST_ITEM ]]; then
        PADDING_RIGHT=0
    fi
    sketchybar --animate linear 10 \
        --set $NAME \
        background.padding_left=$PADDING_LEFT \
        background.color=$BACKGROUND_COLOR \
        background.padding_right=$PADDING_RIGHT \
        associated_display=$DISPLAY \
        icon=$SID \
        label=$LABEL \
        label.color=$COLOR \
        icon.color=$COLOR \
        drawing=yes
else 
    sketchybar --set $NAME \
        drawing=no
fi
