if  type pip > /dev/null; then
    eval "`pip completion --zsh`"
fi

# Python Virtual Environment stuff
alias python=python3
alias pip=pip3
alias venv="python -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"
