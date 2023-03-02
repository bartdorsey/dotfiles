if type git > /dev/null; then
    alias wt="git worktree"
else
    echo "git missing."
fi

# Misc 
alias ll=ls -al

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# exa - fancy ls
if ! type exa > /dev/null; then
    cargo install exa --locked
fi
alias ls="exa -g --icons --git -F -h --group-directories-first --octal-permissions -@"

# lazygit
alias lg=lazygit
