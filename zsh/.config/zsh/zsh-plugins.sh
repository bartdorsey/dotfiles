BASE_SNIPPET_URL="https://raw.githubusercontent.com/bartdorsey/dotfiles/main/zsh/.config/zsh/snippets/"
BASE_SCRIPT_PATH="${HOME}/.config/zsh/zshrc.d/"

function run_plugin {
    if [[ -d "${ZDOTDIR}/plugins/${1}" ]]; then
        source "${ZDOTDIR}/plugins/${1}/${2}"
    fi
}

function run_script {
    source "${BASE_SCRIPT_PATH}/${1}"
}

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Fzf Tab completions
run_plugin fzf-tab fzf-tab.plugin.zsh

# My custom vi plugin
run_plugin zsh-better-vi zsh-better-vi.zsh

# Auto suggestions
run_plugin zsh-autosuggestions zsh-autosuggestions.zsh

# Fast syntax highlighting
run_plugin fast-syntax-highlighting fast-syntax-highlighting.plugin.zsh


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ZSH completions
run_plugin zsh-completions zsh-completions.plugin.zsh

# SSH completion
run_plugin zsh-ssh zsh-ssh.zsh

# My custom FZF plugin
run_plugin zsh-fzf zsh-fzf.zsh

if type python3 > /dev/null;then
    run_plugin zsh-completion-generator/zsh-completion-generator.plugin.zsh;
    # Completions

    zstyle :plugin:zsh-completion-generator programs \
        lsd \
        bat \
        cargo \
        rustup \
        node \
        rg \
        fd
fi

for script in $ZDOTDIR/zshrc.d/*.zsh;
do run_script "$(basename "$script")"
done;
