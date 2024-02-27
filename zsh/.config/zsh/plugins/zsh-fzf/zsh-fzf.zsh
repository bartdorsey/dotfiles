# FZF Functions
if type fzf > /dev/null;then

    if type fzf-share > /dev/null; then
        fzf_dir_list=$(fzf-share)
    else
        fzf_dir_list=("/usr/share/fzf/" "/usr/share/doc/fzf/examples", "/opt/local/share/fzf/shell/")
    fi

    for dir in "${fzf_dir_list[@]}"; do
        if [[ -d "$dir" ]]; then
            FZF_SCRIPT_DIR="$dir"
            break
        fi
    done

    source "$FZF_SCRIPT_DIR/key-bindings.zsh"

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
fi
