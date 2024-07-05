current=$(osascript -e 'output muted of (get volume settings)')
echo $current
if [ "$current" = true ]; then
    echo "muted"
else
    echo "not muted"
fi