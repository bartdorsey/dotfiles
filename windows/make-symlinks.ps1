function New-Link ($target, $link)
{
	New-Item -Path $link -ItemType SymbolicLink -Value $target -Force
}

New-Link $HOME/.dotfiles/windows/starship.toml $HOME/.config/starship.toml
New-Link $HOME/.dotfiles/windows/Microsoft.PowerShell_profile.ps1 $PROFILE
New-Link $HOME/.dotfiles/ssh/.ssh/config $HOME/.ssh/config
New-Link $HOME/.dotfiles/lazygit/.config/lazygit $HOME/.config/lazygit
New-Link $HOME/.dotfiles/helix/.config/helix $env:APPDATA/helix
New-Link $HOME/.dotfiles/firefox/user.js $env:APPDATA/Mozilla/Firefox/Profiles/echo/user.js
New-Link $HOME/.dotfiles/firefox/prefs.js $env:APPDATA/Mozilla/Firefox/Profiles/echo/prefs.js
New-Link $HOME/.dotfiles/firefox/chrome/userChrome.css $env:APPDATA/Mozilla/Firefox/Profiles/echo/chrome/userChrome.css
New-Link $HOME/.dotfiles/wezterm/.config/wezterm $HOME/.config/wezterm
New-Link $HOME/.dotfiles/oh-my-posh/.config/oh-my-posh $HOME/.config/oh-my-posh
New-Link $HOME/.dotfiles/vscode/.config/Code/User/settings.json $env:APPDATA/Code/User/settings.json
New-Link $HOME/.dotfiles/vscode/.config/Code/User/snippets $env:APPDATA/Code/User/snippets
New-Link $HOME/.dotfiles/vscode/.config/Code/User/tasks.json $env:APPDATA/Code/User/tasks.json
New-Link $HOME/.dotfiles/nvim/.config/nvim $HOME/.config/nvim
New-Link $HOME/.dotfiles/vim/.config/vim $HOME/.config/vim
New-Link $HOME/.dotfiles/glzr/.glzr $HOME/.glzr
New-Link $HOME/.dotfiles/flameshot/.config/flameshot/flameshot.ini $env:APPDATA/flameshot/flameshot.ini
New-Link $HOME/.dotfiles/emacs/.config/emacs $HOME/.config/emacs
New-Link $HOME/.dotfiles/resticprofile/.config/resticprofile $env:APPDATA/resticprofile
# Zen
New-Link $HOME/.dotfiles/zen/.config/zen/prefs.js $HOME/.config/zen/prefs.js
New-Link $HOME/.dotfiles/zen/.config/zen/user.js $HOME/.config/zen/user.js
New-Link $HOME/.dotfiles/zen/.config/zen/zen-keyboard-shortcuts.json $HOME/.config/zen/zen-keyboard-shortcuts.json
New-Link $HOME/.dotfiles/zen/.config/zen/zen-theme.json $HOME/.config/zen/zen-theme.json
New-Link $HOME/.dotfiles/zen/.config/zen/containers.json $HOME/.config/zen/containers.json
New-Link $HOME/.dotfiles/zen/.config/zen/chrome $HOME/.config/zen/chrome
New-Link $HOME/.dotfiles/fastfetch/.config/fastfetch $HOME/.config/fastfetch
New-Link $HOME/.dotfiles/vesktop/.config/vesktop/themes $HOME/AppData/Roaming/vesktop/themes

