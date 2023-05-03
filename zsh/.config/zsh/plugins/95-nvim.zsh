if type nvim > /dev/null;then
    alias vi=$(which vim)
    alias vim=$(which nvim)
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
