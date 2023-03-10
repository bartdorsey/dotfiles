if type op > /dev/null; then
   alias 1p=op item get $(echo op item list | fzf | cut -f 1 -d " ")
fi
