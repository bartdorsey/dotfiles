if type npm > /dev/null;then
    npm set prefix $HOME/.npm-global
    export PATH=$HOME/.npm-global/bin:$PATH
fi

