function New-Link ($target, $link)
{
	New-Item -Path $link -ItemType SymbolicLink -Value $target -Force
}

New-Link $HOME/.dotfiles/starship/.config/starship.toml $HOME/.config/starship.toml
New-Link $HOME/.dotfiles/Microsoft.PowerShell_profile.ps1 $PROFILE
New-Link $HOME/.dotfiles/ssh/.ssh/config $HOME/.ssh/config
New-Link $HOME/.dotfiles/lazygit/.config/lazygit $HOME/.config/lazygit
New-Link $HOME/.dotfiles/helix/.config/helix $env:APPDATA/helix
New-Link $HOME/.dotfiles/firefox/user.js $HOME/scoop/persist/firefox/profile/user.js
New-Link $HOME/.dotfiles/wezterm/.config/wezterm/wezterm.lua $HOME/.wezterm.lua
New-Link $HOME/.dotfiles/oh-my-posh/.config/oh-my-posh $HOME/.config/oh-my-posh
New-Link $HOME/.dotfiles/vscode/.config/Code/User/settings.json $env:APPDATA/Code/User/settings.json
New-Link $HOME/.dotfiles/vscode/.config/Code/User/snippets $env:APPDATA/Code/User/snippets
New-Link $HOME/.dotfiles/vscode/.config/Code/User/tasks.json $env:APPDATA/Code/User/tasks.json
