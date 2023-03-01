#!/usr/bin/env sh
SSH_HOST=$(grep -P "^Host ([^*]+)$" $HOME/.ssh/config | sed 's/Host //' | fzf-tmux)
tmux new-session -d -s "ssh $SSH_HOST" ssh $SSH_HOST
tmux switch-client -t "ssh $SSH_HOST"


