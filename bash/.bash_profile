export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export LC_ALL="C.UTF-8"

# Source common shell files
source $HOME/.config/common/env.sh
source $HOME/.config/common/utils.sh
source $HOME/.config/common/aliases.sh
source $HOME/.config/common/path.sh

# GRC
source $HOME/.config/bash/grc.sh

# Devtools
if [[ $DEVMODE ]]; then
    source $HOME/.config/common/devtools.sh
fi

# Fzf
source $HOME/.config/common/fzf.sh

if type starship > /dev/null; then
    eval "$(starship init bash)"
fi

source $HOME/.config/common/fetch.sh
