#!/usr/bin/env zsh

MAIN_DISPLAY=$(system_profiler SPDisplaysDataType | grep -B 3 'Main Display:' | awk '/Display Type/ {print $3}')
update_space() {
    SPACE_ID=$(yabai -m query --spaces --space | jq -r '.index')


    if [[ $MAIN_DISPLAY = "Built-in" ]]; then
    case $SPACE_ID in
        1)
            ICON=
            ICON_PADDING_LEFT=7
            ICON_PADDING_RIGHT=7
            ;;
        *)
            ICON=$SPACE_ID
            ICON_PADDING_LEFT=9
            ICON_PADDING_RIGHT=10
            ;;
        esac
    else
        case $SPACE_ID in
        1)
            ICON=
            ICON_PADDING_LEFT=7
            ICON_PADDING_RIGHT=7
            ;;

        2)
            ICON=
            ICON_PADDING_LEFT=7
            ICON_PADDING_RIGHT=7
            ;;
        3)
            ICON=󰖟
            ICON_PADDING_LEFT=9
            ICON_PADDING_RIGHT=10
            ;;
        4)
            ICON=
            ICON_PADDING_LEFT=9
            ICON_PADDING_RIGHT=10
            ;;
        *)
            ICON=$SPACE_ID
            ICON_PADDING_LEFT=9
            ICON_PADDING_RIGHT=10
            ;;
        esac
    fi


    sketchybar --set $NAME \
        icon=$ICON \
        icon.padding_left=$ICON_PADDING_LEFT \
        icon.padding_right=$ICON_PADDING_RIGHT \
}

case "$SENDER" in
"mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    ;;
esac
