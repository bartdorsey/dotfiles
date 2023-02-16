if type grc-rs > /dev/null; then
    eval $(grc-rs --aliases)
else
    echo "grc-rs missing."
fi
