#!/usr/bin/env zsh

update_space() {
    case ${INFO} in
    0)
        ICON=""
        ICON_PADDING_RIGHT=21
        ;;
    [0-9])
        ICON=""
        ICON_PADDING_RIGHT=12
        ;;
    *)
        ICON=""
        ICON_PADDING_RIGHT=6
        ;;
    esac

    sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT label="$INFO%"
}

case "$SENDER" in
"mouse.clicked")
    current=$(osascript -e 'output muted of (get volume settings)')
    if [ "$current" = true ]; then
        osascript -e 'set volume output muted false'
    else
        osascript -e 'set volume output muted true'
    fi
    ;;
"mouse.scroll")
    current=$(osascript -e 'output muted of (get volume settings)')
    if [ "$current" = true ]; then
        osascript -e 'set volume output muted false'
    else
        osascript -e 'set volume output muted true'
    fi
    ;;
*)
    update_space
    ;;
esac


