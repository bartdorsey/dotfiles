#!/usr/bin/env zsh

if ! tty -s || [ ! -n "$TERM" ] || [ "$TERM" = dumb ] || (( ! $+commands[grc] ))
then
  return
fi

# Supported commands
cmds=(
  cc
  configure
  curl
  df
  diff
  dig
  docker
  docker-compose
  docker-machine
  du
  env
  free
  g++
  gcc
  getfacl
  getsebool
  gmake
  id
  ifconfig
  iostat
  ip
  iptables
  iwconfig
  journalctl
  kubectl
  last
  ld
  lsattr
  lsblk
  lsmod
  lsof
  lspci
  make
  mount
  mtr
  netstat
  nmap
  ntpdate
  ping
  ping6
  ps
  showmount
  ss
  stat
  sysctl
  systemctl
  tcpdump
  traceroute
  traceroute6
  tune2fs
  ulimit
  uptime
  vmstat
  whois
)

# Set alias for available commands.
for cmd in $cmds ; do
  if (( $+commands[$cmd] )) ; then
    $cmd() {
      grc --colour=auto ${commands[$0]} "$@"
    }
  fi
done

# Clean up variables
unset cmds cmd
