#!/usr/bin/env sh
SSH_HOSTS=$(grep -P "^Host ([^*]+)$" /home/echo/.ssh/config | sed 's/Host //')
SSH_HOST=$(echo $SSH_HOSTS | fzf-tmux)
tmux new-session ssh $SSH_HOST


