#!/usr/bin/env python3
"""
Zen Browser profile backup script
Zips important profile data for migration to another computer.
Skips cache, temp files, and symlinks managed by dotfiles.

Usage:
    python backup-profile.py [output.zip]
"""

import os
import sys
import zipfile
from datetime import datetime
from pathlib import Path

PROFILE_DIR = Path(__file__).parent.resolve()

# Files/dirs to include. Symlinks are skipped automatically.
ITEMS = [
    # Bookmarks & History
    "places.sqlite",
    "places.sqlite-shm",
    "places.sqlite-wal",
    "bookmarkbackups",
    # Passwords & Security
    "key4.db",
    "cert9.db",
    "cert_override.txt",
    "pkcs11.txt",
    "logins.json",
    "logins-backup.json",
    "logins.db",
    # Cookies & Permissions
    "cookies.sqlite",
    "cookies.sqlite-shm",
    "cookies.sqlite-wal",
    "permissions.sqlite",
    "content-prefs.sqlite",
    # Extensions
    "extensions.json",
    "extensions",
    "browser-extension-data",
    "extension-preferences.json",
    "extension-settings.json",
    "extension-store",
    "extension-store-menus",
    "extension-store-userscripts",
    "extension-dnr",
    "addonStartup.json.lz4",
    # Storage & Form Data
    "formhistory.sqlite",
    "autofill-profiles.json",
    "storage.sqlite",
    "storage",
    "storage-sync-v2.sqlite",
    "storage-sync-v2.sqlite-shm",
    "storage-sync-v2.sqlite-wal",
    "webappsstore.sqlite",
    "webappsstore.sqlite-shm",
    "webappsstore.sqlite-wal",
    # Preferences & UI
    "prefs.js",
    "xulstore.json",
    "containers.json",
    "handlers.json",
    "search.json.mozlz4",
    "notificationstore.json",
    "broadcast-listeners.json",
    "shield-preference-experiments.json",
    "enumerate_devices.txt",
    "serviceworker.txt",
    "signedInUser.json",
    "settings",
    # Zen-specific
    "zen-sessions.jsonlz4",
    "zen-sessions-backup",
    "zen-themes.json",
    "zen-live-folders.jsonlz4",
    "tabnotes.sqlite",
    "tabnotes.sqlite-shm",
    "tabnotes.sqlite-wal",
    # Session backups
    "sessionstore-backups",
    # Favicons
    "favicons.sqlite",
    "favicons.sqlite-shm",
    "favicons.sqlite-wal",
]

DOTFILE_SYMLINKS = [
    "chrome",
    "user.js",
    "zen-keyboard-shortcuts.json",
    "zen-theme.json",
]


def add_to_zip(zf: zipfile.ZipFile, path: Path, base: Path):
    if path.is_dir():
        for child in sorted(path.rglob("*")):
            if child.is_symlink():
                continue
            if child.is_file():
                zf.write(child, child.relative_to(base))
    elif path.is_file():
        zf.write(path, path.relative_to(base))


def main():
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    default_output = Path.home() / f"zen-profile-backup-{timestamp}.zip"
    output = Path(sys.argv[1]) if len(sys.argv) > 1 else default_output

    print(f"Backing up Zen profile from: {PROFILE_DIR}")
    print(f"Output: {output}\n")

    added = 0
    skipped_symlinks = 0
    missing = 0

    with zipfile.ZipFile(output, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6) as zf:
        for item_name in ITEMS:
            path = PROFILE_DIR / item_name
            if path.is_symlink():
                print(f"  [skip symlink] {item_name}")
                skipped_symlinks += 1
            elif path.exists():
                print(f"  [adding]       {item_name}")
                add_to_zip(zf, path, PROFILE_DIR)
                added += 1
            else:
                print(f"  [missing]      {item_name}")
                missing += 1

    size_mb = output.stat().st_size / (1024 * 1024)
    print(f"\nDone. {added} items added, {missing} missing, {skipped_symlinks} symlinks skipped.")
    print(f"Archive size: {size_mb:.1f} MB")
    print(f"Saved to: {output}")
    print()
    print("NOTE: The following are managed by your dotfiles and were NOT included:")
    for name in DOTFILE_SYMLINKS:
        print(f"  {name}")
    print("Restore those from your dotfiles repo on the new machine.")


if __name__ == "__main__":
    main()
