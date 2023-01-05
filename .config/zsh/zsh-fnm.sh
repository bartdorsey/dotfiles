if type fnm > /dev/null; then
    eval "$(fnm env --use-on-cd)"
else
    echo "fnm missing."
fi
