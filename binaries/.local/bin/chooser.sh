#!/usr/bin/env bash

URL="$1"

FIREFOX="  Firefox"
FIREFOX_PRIV="  Firefox (Private)"
CHROME="  Chrome"
CHROME_PRIV="  Chrome (Private)"
CLIPBOARD="  Clipboard"

menu() {
    echo "$FIREFOX"
    echo "$FIREFOX_PRIV"
    echo "$CHROME"
    echo "$CHROME_PRIV"
    echo "$CLIPBOARD"
}

main() {
    CHOICE=$(menu | rofi -hover-select -me-select-entry '' -me-accept-entry MousePrimary -dmenu -p "Choose Browser")

    case $CHOICE in
        "$FIREFOX")
            firefox "$URL"
            ;;
        "$FIREFOX_PRIV")
            firefox --private-window "$URL"
            ;;
        "$CHROME")
            google-chrome-stable "$URL"
            ;;
        "$CHROME_PRIV")
            google-chrome-stable --incognito "$URL"
            ;;
        "$CLIPBOARD")
            echo "$URL" | xclip
            ;;
    esac
}

main
