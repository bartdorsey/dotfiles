# Install zinit
if [[ ! -d "${HOME}/.local/share/zinit" ]]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    zinit self-update
fi

# Initialize zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit
# plugins
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

# Custom scripts
zinit ice wait lucid multisrc".config/zsh/plugins/*.zsh"
zinit load bartdorsey/dotfiles

