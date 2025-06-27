#!/usr/bin/env bash
# Wait for Hyprland to be ready
while ! hyprctl version >/dev/null 2>&1; do
    sleep 0.1
done
sleep 1
waybar
