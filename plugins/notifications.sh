#!/usr/bin/env zsh

IS_OPEN=true
update_space() {
    if [ $IS_OPEN = true ]; then
        sketchybar --set $NAME icon.padding_right=0 icon=
    else
        sketchybar --set $NAME icon.padding_right=0 icon=
    fi
}

case "$SENDER" in
"mouse.clicked")
    # Press ctrl+cmd+n to test
    if [ $IS_OPEN = true ]; then
        IS_OPEN=false
    else
        IS_OPEN=true
    fi
    update_space
    osascript -e 'display notification "Hello world!" with title "Sketchybar"'
    ;;
*)
    update_space
    ;;
esac