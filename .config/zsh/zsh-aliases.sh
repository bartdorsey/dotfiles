if type git > /dev/null; then
    alias wt="git worktree"
else
    echo "git missing."
fi

# Misc 
alias ll=ls -al

if type fdfind > /dev/null; then
    alias fd=fdfind
else
    echo "fd-find missing."
fi

# Python Virtual Environment stuff
alias python=python3
alias pip=pip3
alias venv="python -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# neovim
if type nvim > /dev/null; then
    alias vim=nvim
    alias vi=nvim
else
    echo "neovim missing."
fi

# exa - fancy ls
if type exa > /dev/null; then
    alias ls="exa -g --icons --git -F -h -G --group-directories-first --octal-permissions -@"
else
    echo "exa missing."
fi
	
