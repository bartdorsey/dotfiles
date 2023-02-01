if type git > /dev/null; then
    alias wt="git worktree"
else
    echo "git missing."
fi

# Misc 
alias ll=ls -al

# Python Virtual Environment stuff
alias python=python3
alias pip=pip3
alias venv="python -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# exa - fancy ls
if ! type exa > /dev/null; then
    cargo install exa --locked
fi
alias ls="exa -g --icons --git -F -h --group-directories-first --octal-permissions -@"
	
