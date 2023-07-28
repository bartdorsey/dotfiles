# Install zinit
if [[ ! -d "${HOME}/.local/share/zinit" ]]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    zinit self-update
fi

# Initialize zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit

BASE_SNIPPET_URL="https://raw.githubusercontent.com/bartdorsey/dotfiles/main/zsh/.config/zsh/snippets/"
BASE_SCRIPT_PATH="${HOME}/.config/zsh/zshrc.d/"

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

function run_script {
    source "${BASE_SCRIPT_PATH}/${1}"
}

zinit ice wait lucid
zinit load zsh-users/zsh-history-substring-search

#zinit ice wait lucid
#zinit load zsh-users/zsh-autosuggestions
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit load zsh-users/zsh-completions

zinit ice wait lucid
zinit load sunlei/zsh-ssh

if type python3 > /dev/null;then
    zinit load RobSis/zsh-completion-generator
fi

for snippet in $ZDOTDIR/snippets/*.zsh;
do install_snippet_silent "$(basename "$snippet")"
done;

for script in $ZDOTDIR/zshrc.d/*.zsh;
do run_script "$(basename "$script")"
done;

# Completions

zstyle :plugin:zsh-completion-generator programs \
    exa \
    bat \
    cargo \
    rustup \
    node \
    rg \
    fd \
