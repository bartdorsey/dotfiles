Import-Module "Microsoft.WinGet.CommandNotFound"
Import-Module "scoop-completion"

function Get-Disk-Free
{
	Get-PSDrive -PSProvider FileSystem
}

# Set PS to Emacs mode
Set-PSReadlineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor

# Menu Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

# Predictive text
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle InlineView

# Up arrow, Down Arrow history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Sets control-D to exit the shell
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

# Try to not show the too many items prompt
Set-PSReadLineOption -CompletionQueryItems 9999


$env:EDITOR = "code"
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:HOME = $env:USERPROFILE
$env:DEVMODE = 1
$env:VIMINIT = "source ~/.config/vim/vimrc"
# Aliases

@{
    p      = 'Get-Projects'
    open   = 'explorer.exe'
    w      = 'whoami'
    df     = 'Get-Disk-Free'
    venv   = 'Build-Python-Virtual-Environment'
    which  = 'Get-Command'
    vim    = 'nvim'
    dsetup = 'Build-Django-Project-Setup'
    lg     = 'lazygit'
    ls     = 'lsd'
}.GetEnumerator() | ForEach-Object { Set-Alias $_.Key $_.Value }

fnm env --use-on-cd --shell power-shell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
#Invoke-Expression (&starship init powershell)
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin_mocha.omp.json" | Invoke-Expression
Invoke-Expression (&scoop-search --hook)


if ($Host.Name -eq 'ConsoleHost') {
	fastfetch -l Windows
}
