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

# My custom vi plugin
run_plugin zsh-better-vi zsh-better-vi.zsh

# Auto suggestions
run_plugin zsh-autosuggestions zsh-autosuggestions.zsh

# Fast syntax highlighting
run_plugin fast-syntax-highlighting fast-syntax-highlighting.plugin.zsh

# History Substring Search
run_plugin zsh-history-substring-search zsh-history-substring-search.zsh

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
        exa \
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
