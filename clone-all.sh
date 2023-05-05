#!/bin/sh
grm repos sync remote --provider github --access --token-command "pass show github_token" --root ~/github --worktree --force-ssh
grm repos sync remote --provider gitlab --access --token-command "pass show gitlab_token" --root ~/gitlab --worktree --force-ssh
