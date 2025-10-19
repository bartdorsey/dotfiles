#!/bin/bash

# Zen Browser Profile Restore Script
# Works on both WSL (Windows), macOS, and Linux

set -e  # Exit on error

# Check if backup file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <backup-archive.tar.gz>"
    echo ""
    echo "Available backups:"
    ls -lh ./zen-profile-backup-*.tar.gz 2>/dev/null || echo "  No backups found in current directory"
    exit 1
fi

BACKUP_ARCHIVE="$1"

# Check if backup file exists
if [ ! -f "$BACKUP_ARCHIVE" ]; then
    echo "Error: Backup file not found: $BACKUP_ARCHIVE"
    exit 1
fi

echo "Zen Browser Profile Restore"
echo "============================"
echo "Backup file: $BACKUP_ARCHIVE"
echo ""

# Create temporary extraction directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Extract the backup
echo "Extracting backup..."
tar -xzf "$BACKUP_ARCHIVE" -C "$TEMP_DIR"

# Find the backup directory (should be the only directory in temp)
BACKUP_DIR=$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)

if [ -z "$BACKUP_DIR" ]; then
    echo "Error: Could not find backup data in archive"
    exit 1
fi

echo "  ✓ Backup extracted"

# Detect if this is a custom config or standard profile backup
if [ -d "$BACKUP_DIR/zen-config" ]; then
    # Custom configuration backup
    echo ""
    echo "Detected custom configuration backup"
    echo ""

    # Determine target directory based on OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        TARGET_DIR="$HOME/Library/Application Support/zen"
    else
        TARGET_DIR="$HOME/.config/zen"
    fi

    echo "Target directory: $TARGET_DIR"
    echo ""
    echo "Warning: This will overwrite existing Zen configuration!"
    echo "Press Enter to continue, or Ctrl+C to cancel..."
    read -r

    # Backup existing config if it exists
    if [ -d "$TARGET_DIR" ]; then
        BACKUP_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
        BACKUP_OLD="$TARGET_DIR.backup-$BACKUP_TIMESTAMP"
        echo "Backing up existing config to: $BACKUP_OLD"
        mv "$TARGET_DIR" "$BACKUP_OLD"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$TARGET_DIR")"

    # Copy the config
    echo "Restoring configuration..."
    cp -r "$BACKUP_DIR/zen-config" "$TARGET_DIR"
    echo "  ✓ Configuration restored"

else
    # Standard profile backup
    echo ""
    echo "Detected standard profile backup"
    echo ""

    # Detect OS and set profile path
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        PROFILE_BASE="$HOME/Library/Application Support/zen/Profiles"
    elif [[ -d "/mnt/c/Users" ]]; then
        # WSL (Windows)
        # Try multiple methods to get Windows username
        if [ -n "$WSLENV" ]; then
            WIN_USER=$(powershell.exe -NoProfile -Command '$env:USERNAME' 2>/dev/null | tr -d '\r\n' | xargs)
        fi

        if [ -z "$WIN_USER" ]; then
            WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n' | xargs)
        fi

        if [ -z "$WIN_USER" ]; then
            for user_dir in /mnt/c/Users/*; do
                username=$(basename "$user_dir")
                if [[ "$username" != "Public" && "$username" != "Default" && "$username" != "All Users" && "$username" != "Default User" && -d "$user_dir/AppData" && ! -L "$user_dir" ]]; then
                    WIN_USER="$username"
                    break
                fi
            done
        fi

        if [ -z "$WIN_USER" ]; then
            echo "Error: Could not determine Windows username"
            echo "Please set it manually: export WIN_USER=YourWindowsUsername"
            exit 1
        fi

        PROFILE_BASE="/mnt/c/Users/$WIN_USER/AppData/Roaming/zen/Profiles"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        PROFILE_BASE="$HOME/.zen/Profiles"
    else
        echo "Unsupported OS"
        exit 1
    fi

    # Check if Zen is installed
    if [ ! -d "$PROFILE_BASE" ]; then
        echo "Error: Zen profile directory not found at: $PROFILE_BASE"
        echo "Please install Zen Browser first and run it at least once to create a profile"
        exit 1
    fi

    # Find default profile
    PROFILE_DIR=$(find "$PROFILE_BASE" -maxdepth 1 -type d -name "*.default*" | head -n 1)

    if [ -z "$PROFILE_DIR" ]; then
        echo "Error: No default profile found"
        echo "Please run Zen Browser at least once to create a profile"
        exit 1
    fi

    echo "Target profile: $PROFILE_DIR"
    echo ""
    echo "Warning: This will overwrite existing profile data!"
    echo "Press Enter to continue, or Ctrl+C to cancel..."
    read -r

    # Copy all files from backup to profile
    echo "Restoring profile..."
    cp -r "$BACKUP_DIR"/* "$PROFILE_DIR/"
    echo "  ✓ Profile restored"
fi

echo ""
echo "Restore complete!"
echo ""
echo "Next steps:"
echo "1. Start Zen Browser"
echo "2. Verify your settings, bookmarks, and extensions"
echo ""
