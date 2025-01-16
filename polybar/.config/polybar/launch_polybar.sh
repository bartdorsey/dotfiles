#!/usr/bin/env bash

# Get the primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

# Launch the primary bar on the primary monitor
if [ -n "$PRIMARY_MONITOR" ]; then
    MONITOR=$PRIMARY_MONITOR polybar --reload primary 2>~/.local/share/logs/polybar-0.log &
fi

# Launch the secondary bar on all other monitors
for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
    MONITOR=$m polybar --reload secondary 2>~/.local/share/logs/polybar-$m.log &
done


