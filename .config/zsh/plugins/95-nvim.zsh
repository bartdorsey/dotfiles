if ! type nvim > /dev/null; then
  TEMP_DEB="$(mktemp)" &&
  wget -O "$TEMP_DEB" "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb" &&
  sudo dpkg -i "$TEMP_DEB"
  rm -f "$TEMP_DEB"
fi

alias vi=nvim
alias vim=nvim

