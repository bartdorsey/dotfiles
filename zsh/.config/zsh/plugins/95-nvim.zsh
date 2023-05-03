alias vi=$(which vim)

if type nvim > /dev/null;then
    alias vim=$(which nvim)
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
