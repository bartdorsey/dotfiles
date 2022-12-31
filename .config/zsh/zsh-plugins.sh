source $HOME/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-completions"
zplug "sunlei/zsh-ssh"
#zplug "MikeDacre/tmux-zsh-vim-titles"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
