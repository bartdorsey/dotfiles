if type pnpm > /dev/null;then
    # pnpm
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
    # pnpm end%
fi
