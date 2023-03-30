function make-link ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

make-link $HOME/.dotfiles/.config/nvim $HOME/.config/nvim
make-link $HOME/.dotfiles/.config/starship.toml $HOME/.config/starship.toml
make-link $HOME/.dotfiles/Microsoft.PowerShell_profile.ps1 $PROFILE


