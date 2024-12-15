#!/usr/bin/env zsh
source $HOME/.config/sketchybar/plugins/colors.sh
IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)

LOCATION="$(echo $LOCATION_JSON | jq '.city' | tr -d '"')"
REGION="$(echo $LOCATION_JSON | jq '.region' | tr -d '"')"
COUNTRY="$(echo $LOCATION_JSON | jq '.country' | tr -d '"')"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")

# Fallback if empty
if [ -z $WEATHER_JSON ]; then
    sketchybar --set $NAME icon=

    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | tr '[:upper:]' '[:lower:]')

ICON=""
ICON_COLOR=$YELLOW
if [[ $WEATHER_DESCRIPTION == *"rain"* ]]; then
    ICON="󰙾"
    ICON_COLOR=$BLUE
fi
if [[ $WEATHER_DESCRIPTION == *"snow"* ]]; then
    ICON="󰙿"
    ICON_COLOR=$WHITE
fi
if [[ $WEATHER_DESCRIPTION == *"cloud"* ]]; then
    ICON="󰅟"
    ICON_COLOR=$GRAY
fi
if [[ $WEATHER_DESCRIPTION == *"clear"* ]]; then
    ICON=""
    ICON_COLOR=$YELLOW
fi
sketchybar --set $NAME label="$TEMPERATURE℃" icon=$ICON icon.color=$ICON_COLOR
