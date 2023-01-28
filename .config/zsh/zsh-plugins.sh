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
zinit for wait lucid \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting \
    agkozak/zsh-z \
    zsh-users/zsh-completions \
    sunlei/zsh-ssh \
    jeffreytse/zsh-vi-mode


# Custom scripts
zinit ice multisrc".config/zsh/plugins/*.zsh"
zinit load bartdorsey/dotfiles
