# shell helper functions
# mostly written by Nathaniel Maia, some pilfered from around the web

# reloads the shell
function reload
    exec $SHELL $SHELL_ARGS "$argv"
end

function fe --description 'Open files selected with fzf'
    set -l files (fd --type file --hidden --exclude .git | fzf --multi --query "$argv" --select-1 --exit-0 --preview 'bat --color=always --style=plain {} 2>/dev/null; or head -200 {}')
    test (count $files) -gt 0; and $EDITOR $files
end

function fkill --argument-names signal --description 'Kill processes selected with fzf'
    set -q signal; or set signal TERM
    set -l pids (ps -ef | sed 1d | fzf --multi | awk '{print $2}')
    test (count $pids) -gt 0; and kill -$signal $pids
end

function fbr --description 'Check out a branch selected with fzf'
    set -l branch (git branch --all --format='%(refname:short)' | string match -rv HEAD | fzf --height=50% --border)
    test -n "$branch"; and git checkout (string replace -r '^remotes/[^/]+/' '' $branch)
end

function fco --description 'Check out a branch or tag selected with fzf'
    set -l ref (git for-each-ref --format='%(refname:short)' refs/heads refs/remotes refs/tags | string match -rv HEAD | sort -u | fzf --height=50% --border)
    test -n "$ref"; and git checkout (string replace -r '^remotes/[^/]+/' '' $ref)
end

function fcoc --description 'Check out a commit selected with fzf'
    set -l commit (git log --oneline --color=always | fzf --ansi --no-sort --height=50% --border)
    test -n "$commit"; and git checkout (string split ' ' $commit)[1]
end

function fshow --description 'Browse commits with fzf'
    set -l commit (git log --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' | fzf --ansi --no-sort --reverse --preview 'git show --color=always {1}')
    test -n "$commit"; and git show --color=always (string match -r '[a-f0-9]{7,}' $commit)[1]
end

function fcs --description 'Print a commit hash selected with fzf'
    git log --oneline --color=always | fzf --ansi --no-sort | string replace -r ' .*' ''
end

function fstash --description 'Show a stash selected with fzf'
    set -l stash (git stash list | fzf --height=50% --border)
    test -n "$stash"; and git stash show --patch (string replace -r ': .*' '' $stash)
end

function ftpane --description 'Switch tmux pane with fzf'
    set -l pane (tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_path} #{pane_current_command}' | fzf --reverse)
    test -n "$pane"; and tmux switch-client -t (string split ' ' $pane)[1]
end
