FROM ubuntu:latest

ENV DEVMODE=1

# Update and install Ubuntu packages
RUN \
    apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y libtool autoconf automake cmake libncurses5-dev g++ pkg-config unzip git curl ninja-build gettext \
    zsh sudo stow vim fzf fd-find ripgrep software-properties-common python-is-python3 python3-full python3-pip tmux

# Install fastfetch
RUN add-apt-repository ppa:zhangsongcui3371/fastfetch

RUN apt-get install -y fastfetch 

# Build neovim
RUN \
    git clone --depth=1 --branch=stable https://github.com/neovim/neovim.git nvim && \
    cd nvim && \
    make && make install && \
    cd ../ && rm -rf nvim

# Instal lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit -D -t /usr/local/bin/

# Install Starship prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN chsh -s /bin/zsh ubuntu

USER ubuntu
WORKDIR /home/ubuntu



# Install fnm
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell -d /home/ubuntu/.local/bin

RUN /home/ubuntu/.local/bin/fnm install 22

# Turn on devmode
RUN mkdir /home/ubuntu/.config && touch /home/ubuntu/.config/devmode

# Clone dotfiles
RUN \
    git clone --depth=1 https://github.com/bartdorsey/dotfiles.git /home/ubuntu/.dotfiles

RUN cd ~/.dotfiles && ./install 2>&1


CMD ["zsh", "-l"]

