#!/usr/bin/env bash
# Checks if a newer kernel is installed than the one currently running.
# Supports apt/dpkg and pacman based distros. Silent on unsupported systems.

running=$(uname -r)
latest=""

# Apt/dpkg based distros: kernels named /boot/vmlinuz-<version>
if command -v dpkg &>/dev/null; then
    latest=$(ls /boot/vmlinuz-* 2>/dev/null \
        | grep -v '\.old$' \
        | sed 's|/boot/vmlinuz-||' \
        | sort -V | tail -1)

# Pacman based distros: version embedded in kernel binary
elif command -v pacman &>/dev/null; then
    latest=$(file /boot/vmlinuz-linux 2>/dev/null \
        | grep -oP 'version \K\S+')
fi

# No kernel found (WSL, container, or unsupported distro) - output nothing
[ -z "$latest" ] && exit 0

if [ "$latest" = "$running" ]; then
    echo "Up to date"
else
    echo "Pending reboot: $running -> $latest"
fi
