if ! type rustup > /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [[ ! -d "$CARGO_HOME" ]]; then
    rustup default stable
fi
