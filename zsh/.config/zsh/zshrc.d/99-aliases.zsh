# Git worktree
if type git > /dev/null; then
    alias wt="git worktree"
fi

# Misc
alias ll=ls -al

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# exa - fancy ls
if type exa > /dev/null; then
    alias ls="exa -g --icons --git -F -h --group-directories-first --octal-permissions"
fi

if type lsd > /dev/null; then
    alias ls="lsd --group-directories-first -g"
fi

# lazygit
if type lazygit > /dev/null;then
    alias lg=lazygit
fi

if type xdg-open > /dev/null; then
    alias open=xdg-open
fi

# gitignore
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}
