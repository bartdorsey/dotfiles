function Get-Disk-Free {
	Get-Volume | Sort-Object -Property DriveLetter
}

function Build-Django-Project {
  python -m venv .venv
  .\.venv\Scripts\Activate.ps1
  pip install -r requirements.txt
  python manage.py migrate
  python manage.py createsuperuser
}


function Build-Python-Virtual-Environment {
  python -m venv .venv
  .\.venv\Scripts\Activate.ps1
}

function Get-Projects {
   fd -t d -d 1 . $env:USERPROFILE\dev\bartdorsey $env:USERPROFILE\dev\galvanize $env:USERPROFILE\projects | fzf | % { code $_ }
}

# Set PS to Emacs mode
Set-PSReadlineOption -EditMode Emacs

# Sets control-D to exit the shell
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

$env:EDITOR = "code"
$env:Path += ";C:\Users\bart\scoop\persist\rustup\.cargo\bin"
$env:Path += ";C:\Users\bart\Apps"
$env:Path += ";C:\Users\bart\OneDrive\Apps"
$env:Path += ";C:\Users\bart\.local\bin"
$env:Path += ";C:\Users\bart\.cargo\bin"
$env:Path = ";$env:USERPROFILE\.gobrew\current\bin;$env:USERPROFILE\.gobrew\bin;$env:Path"
$env:GOROOT = "$env:USERPROFILE\.gobrew\current\go"
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:KOMOREBI_CONFIG_HOME = "$env:USERPROFILE\.config\komorebi"

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

function Invoke-Exa {
	exa --icons --git -F -h -G --group-directories-first $args
}
Set-Alias ls Invoke-Exa

Import-Module Terminal-Icons

Invoke-Expression (& { $hook = if ($PSVersionTable.PSVersion.Major -ge 6) { 'pwd' } else { 'prompt' } (zoxide init powershell --hook $hook | Out-String) })

macchina

fnm env --use-on-cd | Out-String | Invoke-Expression
Invoke-Expression (&starship init powershell)
Import-Module scoop-completion
Invoke-Expression (&scoop-search --hook)

# Dotfiles
$DotFilesPath = Join-Path $HOME '.dotfiles'

$DotFilesAutodetect = $false

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
