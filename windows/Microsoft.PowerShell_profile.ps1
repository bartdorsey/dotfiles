function Get-Disk-Free
{
	Get-PSDrive -PSProvider FileSystem
}

function Build-Django-Project
{
	python -m venv .venv
	.\.venv\Scripts\Activate.ps1
	pip install -r requirements.txt
	python manage.py migrate
	python manage.py createsuperuser
}


function Build-Python-Virtual-Environment
{
	python -m venv .venv
	.\.venv\Scripts\Activate.ps1
}

function Get-Projects
{
	fd -t d -d 1 . $env:USERPROFILE\dev\bartdorsey $env:USERPROFILE\dev\galvanize $env:USERPROFILE\projects | fzf | % { code $_ }
}

# Set PS to Emacs mode
Set-PSReadlineOption -EditMode Emacs

# Sets control-D to exit the shell
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

$env:EDITOR = "code"
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:HOME = $env:USERPROFILE
$env:DEVMODE = 1
$env:VIMINIT = "source ~/.config/vim/vimrc"
# Aliases
Set-Alias p Get-Projects
Set-Alias open explorer.exe
Set-Alias w whoami
Set-Alias df Get-Disk-Free
Set-Alias venv Build-Python-Virtual-Environment
Set-Alias which Get-Command
Set-Alias vim nvim
Set-Alias dsetup Build-Django-Project-Setup
Set-Alias lg lazygit
Set-Alias ls lsd
#Set-Alias docker podman

function Invoke-Exa
{
	eza --icons --git -F -h -G --group-directories-first $args
}
# Set-Alias ls Invoke-Exa

Import-Module Terminal-Icons

fnm env --use-on-cd --shell power-shell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })


Invoke-Expression (&starship init powershell)
#oh-my-posh init pwsh --config $env:USERPROFILE/.config/oh-my-posh/themes/rose-pine.omp.json | Invoke-Expression
Import-Module scoop-completion
Invoke-Expression (&scoop-search --hook)

# Dotfiles
$DotFilesPath = Join-Path $HOME '.dotfiles'

$DotFilesAutodetect = $true

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
	Import-Module "$ChocolateyProfile"
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

fastfetch --disk-show-external false
