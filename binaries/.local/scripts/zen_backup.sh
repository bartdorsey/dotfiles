#!/bin/bash

# Zen Browser Profile Backup Script
# Works on both WSL (Windows) and macOS

set -e  # Exit on error

# Detect OS and set profile path
USE_CUSTOM_CONFIG=false
CUSTOM_CONFIG_DIR=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    PROFILE_BASE="$HOME/Library/Application Support/zen/Profiles"
elif [[ -d "/mnt/c/Users" ]]; then
    # WSL (Windows) - Check for Linux-style config first
    if [ -d "$HOME/.config/zen" ] && [ ! -d "$HOME/.config/zen/Profiles" ]; then
        # Custom configuration (not using Profiles directory)
        USE_CUSTOM_CONFIG=true
        CUSTOM_CONFIG_DIR="$HOME/.config/zen"
        echo "Using custom Zen configuration: $CUSTOM_CONFIG_DIR"
    elif [ -d "$HOME/.config/zen/Profiles" ]; then
        PROFILE_BASE="$HOME/.config/zen/Profiles"
        echo "Using Linux-style Zen profile: $PROFILE_BASE"
    else
        # Try Windows AppData location
        # Try multiple methods to get Windows username
        if [ -n "$WSLENV" ]; then
            # Method 1: Use PowerShell to get username
            WIN_USER=$(powershell.exe -NoProfile -Command '$env:USERNAME' 2>/dev/null | tr -d '\r\n' | xargs)
        fi

        # Fallback: Try cmd.exe
        if [ -z "$WIN_USER" ]; then
            WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n' | xargs)
        fi

        # Fallback: Parse from WSLENV or current WSL user path
        if [ -z "$WIN_USER" ]; then
            # Try to find a user directory in /mnt/c/Users (skip system directories)
            for user_dir in /mnt/c/Users/*; do
                username=$(basename "$user_dir")
                # Skip system directories and links
                if [[ "$username" != "Public" && "$username" != "Default" && "$username" != "All Users" && "$username" != "Default User" && -d "$user_dir/AppData" && ! -L "$user_dir" ]]; then
                    WIN_USER="$username"
                    break
                fi
            done
        fi

        # Check if we successfully got the username
        if [ -z "$WIN_USER" ]; then
            echo "Error: Could not determine Windows username"
            echo "Please set it manually: export WIN_USER=YourWindowsUsername"
            exit 1
        fi

        PROFILE_BASE="/mnt/c/Users/$WIN_USER/AppData/Roaming/zen/Profiles"
        echo "Detected Windows user: $WIN_USER"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if [ -d "$HOME/.config/zen" ] && [ ! -d "$HOME/.config/zen/Profiles" ]; then
        # Custom configuration (not using Profiles directory)
        USE_CUSTOM_CONFIG=true
        CUSTOM_CONFIG_DIR="$HOME/.config/zen"
    else
        PROFILE_BASE="$HOME/.config/zen/Profiles"
    fi
else
    echo "Unsupported OS"
    exit 1
fi

# Set backup destination
BACKUP_DIR="./zen-profile-backup-$(date +%Y%m%d-%H%M%S)"

if [ "$USE_CUSTOM_CONFIG" = true ]; then
    # Custom configuration - backup the entire directory
    echo "Found custom configuration: $CUSTOM_CONFIG_DIR"
    echo "Creating backup at: $BACKUP_DIR"

    # Create backup directory
    mkdir -p "$BACKUP_DIR"

    # Copy the entire config directory, following symlinks to get the actual files
    echo "Backing up custom configuration..."
    cp -rL "$CUSTOM_CONFIG_DIR" "$BACKUP_DIR/zen-config"
    echo "  ✓ Backed up custom configuration (symlinks resolved)"

else
    # Standard profile directory
    # Check if profile directory exists
    if [ ! -d "$PROFILE_BASE" ]; then
        echo "Error: Zen profile directory not found at: $PROFILE_BASE"
        exit 1
    fi

    # Find the default profile (usually ends with .default or .default-release)
    PROFILE_DIR=$(find "$PROFILE_BASE" -maxdepth 1 -type d -name "*.default*" | head -n 1)

    if [ -z "$PROFILE_DIR" ]; then
        echo "Error: No default profile found"
        echo "Available profiles:"
        ls -la "$PROFILE_BASE"
        exit 1
    fi

    echo "Found profile: $PROFILE_DIR"
    echo "Creating backup at: $BACKUP_DIR"

    # Create backup directory
    mkdir -p "$BACKUP_DIR"

    # Essential files to backup
    FILES=(
        "places.sqlite"
        "cookies.sqlite"
        "cert9.db"
        "key4.db"
        "logins.json"
        "extension-preferences.json"
        "extensions.json"
        "extension-settings.json"
        "search.json.mozlz4"
        "sessionCheckpoints.json"
        "sessionstore.jsonlz4"
        "prefs.js"
    )

    # Optional folders
    FOLDERS=(
        "extensions"
        "storage"
        "chrome"
    )

    # Copy files
    echo "Backing up files..."
    for file in "${FILES[@]}"; do
        if [ -f "$PROFILE_DIR/$file" ]; then
            cp "$PROFILE_DIR/$file" "$BACKUP_DIR/"
            echo "  ✓ $file"
        else
            echo "  ⚠ $file not found (skipping)"
        fi
    done

    # Copy folders
    echo "Backing up folders..."
    for folder in "${FOLDERS[@]}"; do
        if [ -d "$PROFILE_DIR/$folder" ]; then
            cp -r "$PROFILE_DIR/$folder" "$BACKUP_DIR/"
            echo "  ✓ $folder/"
        else
            echo "  ⚠ $folder/ not found (skipping)"
        fi
    done
fi

echo ""
echo "Creating compressed archive..."
BACKUP_ARCHIVE="${BACKUP_DIR}.tar.gz"
tar -czf "$BACKUP_ARCHIVE" -C "$(dirname "$BACKUP_DIR")" "$(basename "$BACKUP_DIR")"

if [ -f "$BACKUP_ARCHIVE" ]; then
    # Remove the uncompressed directory
    rm -rf "$BACKUP_DIR"
    BACKUP_SIZE=$(du -h "$BACKUP_ARCHIVE" | cut -f1)
    echo "  ✓ Archive created: $BACKUP_ARCHIVE ($BACKUP_SIZE)"
else
    echo "  ⚠ Failed to create archive, keeping directory backup"
fi

echo ""
echo "Backup complete!"
if [ -f "$BACKUP_ARCHIVE" ]; then
    echo "Backup location: $BACKUP_ARCHIVE"
else
    echo "Backup location: $BACKUP_DIR"
fi
echo ""
echo "To restore on another machine:"
echo "1. Install Zen Browser"
echo "2. Extract the backup: tar -xzf $(basename "$BACKUP_ARCHIVE")"
echo "3. Create a new profile (about:profiles) or locate existing profile"
echo "4. Close Zen Browser"
if [ "$USE_CUSTOM_CONFIG" = true ]; then
    echo "5. Copy contents from zen-config/ to ~/.config/zen/ (or appropriate location)"
else
    echo "5. Copy all files from the backup to the profile folder"
fi
echo "6. Restart Zen Browser"
