echo "Current space container"
echo "DID > $DID"
PLUGIN_SHARED_DIR="$HOME/.config/sketchybar/plugins"
sketchybar --add item current_space left \
    --set current_space \
    background.color=0xfff5a97f \
    icon.color=0xff24273a \
    label.drawing=off \
    script="$PLUGIN_SHARED_DIR/current_space.sh" \
    --subscribe current_space space_change mouse.clicked