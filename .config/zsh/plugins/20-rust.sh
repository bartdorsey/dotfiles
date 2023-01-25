if [[ -d "${HOME}/.cargo" ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
  export PATH=$PATH:$HOME/.cargo/bin
fi

