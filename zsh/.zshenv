export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
#export XDG_RUNTIME_DIR="$HOME/.local/run"
ZDOTDIR=$HOME/.config/zsh
skip_global_compinit=1
source $ZDOTDIR/env.zsh
. "/home/echo/.local/share/cargo/env"
