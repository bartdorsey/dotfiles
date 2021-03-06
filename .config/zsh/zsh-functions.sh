function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
	      echo "Activating Python Virtual Environment: $(basename $(pwd))/.venv"
        source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
	      echo "Deactivating Python Virtual Environment $(basename $parentdir)/.venv"
        deactivate
      fi
  fi
}

function zsh_config_run(){
  zsh_config_run_file="$1"
  zsh_config_run_file_path="$ZDOTDIR/$zsh_config_run_file"
  if [ -f "$zsh_config_run_file_path" ]; then
    source "$zsh_config_run_file_path"
  fi
}

function zsh_configure_completion() {
  # Configure completion for zsh
  autoload -U compinit
  zstyle ':completion:*' menu select
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*' file-list all
  zstyle ':completion:*' format '%F{yellow}-- %d --%f'
  zstyle ':completion:*' complete-options true
  zmodload zsh/complist
  compinit
  _comp_options+=(globdots)
  unsetopt listambiguous
  setopt AUTO_LIST
  LISTMAX=-1
  # bun completions
  [ -s "/home/echo/.bun/_bun" ] && source "/home/echo/.bun/_bun"
}

function fzf_cd() {
	cd $(fdfind --type d --hidden | fzf)
}

function find_programming_files() {
	fdfind --hidden '.(sh|js|html|py|css|md|rs|json|yaml)$' | fzf
}

function find_git_repos() {
	fdfind --hidden '.(git|workspace)$' | sed s/.git$// | fzf
}

function fzf_vi() {
	file=$(find_programming_files)||return
	nvim $file
}

function fzf_code() {
	repo=$(find_git_repos)||return
	code $repo
}

