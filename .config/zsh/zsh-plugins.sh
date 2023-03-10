# Install zinit
if [[ ! -d "${HOME}/.local/share/zinit" ]]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    zinit self-update
fi

# Initialize zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit

BASE_SNIPPET_URL="https://raw.githubusercontent.com/bartdorsey/dotfiles/main/.config/zsh/plugins/"

function install_snippet_sync {
    zinit ice load
    zinit snippet "${BASE_SNIPPET_URL}${1}"
}

function install_snippet {
    zinit ice wait lucid
    zinit snippet "${BASE_SNIPPET_URL}${1}" 
}

function install_snippet_silent {
    zinit ice wait silent
    zinit snippet "${BASE_SNIPPET_URL}${1}"
}

install_snippet "00-nix.zsh"

# fzf-tab
zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zinit ice wait lucid
zinit load zsh-users/zsh-history-substring-search

zinit ice wait lucid
zinit load zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting

zinit ice wait lucid 
zinit load zsh-users/zsh-completions

zinit ice wait lucid
zinit load sunlei/zsh-ssh

zinit load RobSis/zsh-completion-generator

install_snippet "01-neovim.zsh"
install_snippet "01-tmux.zsh"
install_snippet_silent "10-rust.zsh"
install_snippet "20-python.zsh"
install_snippet "20-fnm.zsh"
install_snippet "20-go.zsh"
install_snippet "20-pnpm.zsh"
install_snippet "30-ssh.zsh"
install_snippet "50-wsl2.zsh"
install_snippet "60-direnv.zsh"
install_snippet "60-fzf.zsh"
install_snippet "60-zoxide.zsh"
install_snippet "80-binds.zsh"
install_snippet "95-nvim.zsh"
install_snippet "98-1password.zsh"
install_snippet "99-aliases.zsh"

# Completions

zstyle :plugin:zsh-completion-generator programs \
exa \
bat \
cargo \
rustup \
node \
rg \
fd \
