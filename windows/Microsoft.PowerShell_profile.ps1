$env:PATH = @(
    "C:\Users\bart\scoop\apps\mise\current\bin"
    
    # Windows essentials
    "C:\Windows\system32"
    "C:\Windows"
    "C:\Windows\System32\Wbem"
    "C:\Windows\System32\WindowsPowerShell\v1.0\"
    "C:\Windows\System32\OpenSSH\"
    
    # Scoop (ONCE - remove duplicate!)
    "C:\Users\bart\scoop\shims"
    
    # Development tools
    "C:\Program Files\PowerShell\7"
    "C:\Program Files\Git\cmd"
    "C:\Program Files\Docker\Docker\resources\bin"
    "C:\Program Files\dotnet\"
    "C:\Program Files\WezTerm"
    
    # Other tools
    "C:\Users\bart\.local\bin"
    "C:\Users\bart\scoop\apps\rustup\current\.cargo\bin"
    "C:\Users\bart\scoop\apps\gpg4win\current\GnuPG\bin"
    "C:\Users\bart\AppData\Local\Programs\Microsoft VS Code\bin"
    "C:\Users\bart\AppData\Local\Microsoft\WindowsApps\"
    "C:\Users\bart\scoop\apps\gnupg\current\bin"
    "C:\Users\bart\AppData\Local\Microsoft\WinGet\Links"
    "C:\Program Files\Tailscale\"
    
) -join ';'

mise activate --shims pwsh | Out-String | Invoke-Expression

Import-Module "Microsoft.WinGet.CommandNotFound"
Import-Module "scoop-completion"

function Get-Disk-Free
{
	Get-PSDrive -PSProvider FileSystem
}

# Set PS to vim mode
Set-PSReadlineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor

# Menu Completion
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Predictive text
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
# Set-PSReadLineOption -PredictionViewStyle InlineView

# Sets control-D to exit the shell
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

$env:EDITOR = "code"
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:HOME = $env:USERPROFILE
# $env:DEVMODE = 1
$env:VIMINIT = "source ~/.config/vim/vimrc"

# Aliases

@{
    p      = 'Get-Projects'
    open   = 'explorer.exe'
    w      = 'whoami'
    df     = 'Get-Disk-Free'
    venv   = 'Build-Python-Virtual-Environment'
    vim    = 'nvim'
    dsetup = 'Build-Django-Project-Setup'
    lg     = 'lazygit'
    ls     = 'lsd'
}.GetEnumerator() | ForEach-Object { Set-Alias $_.Key $_.Value }

#fnm env --use-on-cd --shell power-shell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
Invoke-Expression (&starship init powershell)
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression
Invoke-Expression (&scoop-search --hook)


if ($Host.Name -eq 'ConsoleHost') {
	fastfetch -l Windows
}

Import-Module -Name Microsoft.WinGet.CommandNotFound

function which ($command) {
    $cmd = Get-Command -Name $command -ErrorAction SilentlyContinue
    if ($cmd) {
        if ($cmd.Path) { $cmd.Path }
        else { "$($cmd.CommandType): $($cmd.Name)" }
    }
}

