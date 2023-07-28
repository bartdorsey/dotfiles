if type pip3 > /dev/null; then
    eval "`pip3 completion --zsh`"
fi

if type python3 > /dev/null; then
    # Python Virtual Environment stuff
    alias python=python3
    alias pip=pip3
    alias venv="python -m venv .venv && source .venv/bin/activate"
    alias activate="source .venv/bin/activate"
fi
