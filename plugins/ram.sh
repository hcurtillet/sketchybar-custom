#!/usr/bin/env bash
#ram.sh

sketchybar -m --set "$NAME" label="$(top -l 1 | grep -E "^Phys" | awk '{ print $2}')"