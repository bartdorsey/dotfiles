source $HOME/.zplug/init.zsh
if ! type zplug > /dev/null; then 
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

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
