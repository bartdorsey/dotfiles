# FZF Functions
if type fzf > /dev/null;then

    # Shell integration
    source <(fzf --zsh)


    function fzf_cd() {
        cd $(fd --type d --hidden | fzf)
    }

    function fzfz() {
        cd $(zshz | column --table --table-hide 1 | fzf)
    }

    function find_programming_files() {
        fd --hidden '.(sh|js|html|py|css|md|rs|json|yaml)$' | fzf
    }

    function find_git_repos() {
        fd --hidden '.(git|workspace)$' | sed s/.git$// | fzf
    }

    function fzf_vi() {
        file=$(find_programming_files)||return
        nvim $file
    }

    function fzf_code() {
        repo=$(find_git_repos)||return
        code $repo
    }

    function fzf_man {
        man -k . | fzf --preview 'man {}' | awk '{print $1}' | xargs -r man
    }

    function f() {

    }
fi
