#!/usr/bin/env bash

# Get the primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

# Launch the primary bar on the primary monitor
if [ -n "$PRIMARY_MONITOR" ]; then
    MONITOR=$PRIMARY_MONITOR polybar --reload primary &
fi

# Launch the secondary bar on all other monitors
for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
    MONITOR=$m polybar --reload secondary &
done


