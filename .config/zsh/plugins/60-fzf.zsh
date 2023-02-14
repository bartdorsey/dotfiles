[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if ! type fzf > /dev/null; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi


