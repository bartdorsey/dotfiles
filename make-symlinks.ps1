function New-Link ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target -Force
}

New-Link $HOME/.dotfiles/nvim/.config/nvim $HOME/.config/nvim
New-Link $HOME/.dotfiles/nvim/.config/nvim $HOME/AppData/Local/nvim
New-Link $HOME/.dotfiles/starship/.config/starship.toml $HOME/.config/starship.toml
New-Link $HOME/.dotfiles/Microsoft.PowerShell_profile.ps1 $PROFILE
New-Link $HOME/.dotfiles/ssh/.ssh/config $HOME/.ssh/config
New-Link $HOME/.dotfiles/lazygit/.config/lazygit $HOME/.config/lazygit
New-Link $HOME/.dotfiles/helix/.config/helix $env:APPDATA/helix
New-Link $HOME/.dotfiles/user.js $HOME/scoop/persist/firefix/profile/user.js

