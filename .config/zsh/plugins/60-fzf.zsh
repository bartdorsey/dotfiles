

[ -f ~/.nix-profile/share/fzf/completion.zsh ] && source ~/.nix-profile/share/fzf/completion.zsh
[ -f ~/.nix-profile/share/fzf/key-bindings.zsh ] && source ~/.nix-profile/share/fzf/key-bindings.zsh

if ! type fzf > /dev/null; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi


