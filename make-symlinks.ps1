function New-Link ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target -Force
}

New-Link $HOME/.dotfiles/nvim/.config/nvim $HOME/.config/nvim
New-Link $HOME/.dotfiles/starship/.config/starship.toml $HOME/.config/starship.toml
New-Link $HOME/.dotfiles/Microsoft.PowerShell_profile.ps1 $PROFILE


