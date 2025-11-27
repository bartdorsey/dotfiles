#!/usr/bin/env bash

SERVICE_NAME="wg-quick-protonvpn"
STATUS_CONNECTED_STR='{"text":"Connected","class":"connected","alt":"connected"}'
STATUS_DISCONNECTED_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'

function status_wireguard() {
  systemctl is-active $SERVICE_NAME >/dev/null 2>&1
  return $?
}

function toggle_wireguard() {
    echo "attempting to toggle_wireguard"
  status_wireguard && \
      wezterm start --class TUI.float sudo -A systemctl stop $SERVICE_NAME || \
      wezterm start --class TUI.float sudo -A systemctl start $SERVICE_NAME
}

case $1 in
  -s | --status)
    status_wireguard && echo $STATUS_CONNECTED_STR || echo $STATUS_DISCONNECTED_STR
    ;;
  *)
    toggle_wireguard
    ;;
esac
