set -gx GPG_TTY (tty 2>/dev/null)
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config

test -r $HOME/.env.fish; and source $HOME/.env.fish

set -l path_candidates \
    $HOME/bin \
    $HOME/development/cabo/bin \
    '/Applications/Sublime Text.app/Contents/SharedSupport/bin' \
    /opt/homebrew/opt/mysql-client/bin \
    $HOME/bin.local $HOME/.local/bin $HOME/.local/share/bob/nvim-bin \
    $HOME/anaconda3/bin $HOME/github.com/graalvm/Contents/Home/bin \
    $HOME/.gobrew/current/bin $HOME/.gobrew/bin $HOME/.nimble/bin $HOME/.bin \
    $HOME/n/bin $HOME/.symfony/bin $HOME/.phpenv/shims $HOME/.cabal/bin \
    $HOME/.rbenv/bin $HOME/.poetry/bin $HOME/.fzf/bin $HOME/.deno/bin \
    $HOME/.cargo/bin $HOME/scripts $HOME/.nexustools $HOME/src/gocode/bin \
    $HOME/.yarn/bin $HOME/.bun/bin $HOME/.config/yarn/global/node_modules/.bin \
    $HOME/go/bin /opt/homebrew/bin /opt/local/sbin /opt/local/bin \
    /usr/local/share/npm/bin /usr/local/opt/coreutils/libexec/gnubin /usr/bin/core_perl \
    $HOME/Library/Python/*/bin
for path in $path_candidates
    test -d $path; and fish_add_path --global $path
end

test -d $HOME/.go; and set -gx GOROOT $HOME/.go
set -q GOPATH; and fish_add_path --global $GOPATH/bin

for file in $XDG_CONFIG_HOME/fish/settings/*.fish
    source $file
end

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND

function fish_title
    status current-command | string replace fish (prompt_pwd)
end

function __cloud_prompt_on_command --on-event fish_preexec
    string match -rq '(^|[|;&[:space:]])aws([[:space:]]|$)' -- $argv; and set -gx _tide_show_aws 1; or set -e _tide_show_aws
    string match -rq '(^|[|;&[:space:]])kubectl([[:space:]]|$)' -- $argv; and set -gx _tide_show_kubectl 1; or set -e _tide_show_kubectl
end

function _tide_item_aws
    set -q _tide_show_aws; or return
    set -q AWS_PROFILE; and set -l AWS_DEFAULT_PROFILE $AWS_PROFILE
    set -q AWS_REGION; and set -l AWS_DEFAULT_REGION $AWS_REGION
    if test -n "$AWS_DEFAULT_PROFILE" -a -n "$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE/$AWS_DEFAULT_REGION"
    else if test -n "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
    end
end

function _tide_item_kubectl
    set -q _tide_show_kubectl; or return
    kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null | read -l context
    and _tide_print_item kubectl $tide_kubectl_icon' ' (string replace -r '/(|default)$' '' $context)
end

function __cd_child
    type -q fd; and set -l dir (fd --type directory --hidden --exclude .git . | fzf --height=60% --layout=reverse --border=horizontal --exact --no-multi)
    test -n "$dir"; and cd $dir
    commandline -f repaint
end

function fish_user_key_bindings
    fish_default_key_bindings
    functions -q fzf_configure_bindings; and fzf_configure_bindings --directory=\ct --history=\cr
    bind \ec __cd_child
    bind \e\[1\;2D prevd-or-backward-word
    bind \e\[1\;2C nextd-or-forward-word
    bind \e\[1\;2A 'cd ..; commandline -f repaint'
    bind \e\[1\;2B __cd_child
    bind \e\[C forward-char
end

function fisher-update --argument-names mode
    set -q XDG_CACHE_HOME; and set -l cache_home $XDG_CACHE_HOME; or set -l cache_home $HOME/.cache
    set -l state_file $cache_home/fisher-update
    set -l now (date +%s)
    set -l next_check 0
    test -r $state_file; and read next_check <$state_file
    test "$mode" != --auto -o $now -ge $next_check; or return
    status is-interactive; or return

    read --nchars 1 --prompt-str 'Update Fisher plugins and completions now? [y/N] ' answer
    echo
    if string match -qi y $answer
        fisher update; or return
        fish_update_completions

        mkdir -p $XDG_CONFIG_HOME/fish/completions
        for command in kubectl helm oc
            type -q $command; or continue
            set -l completion_file $XDG_CONFIG_HOME/fish/completions/$command.fish
            set -l temporary_file $completion_file.tmp
            $command completion fish >$temporary_file; and command mv $temporary_file $completion_file
        end
        if type -q gh
            set -l completion_file $XDG_CONFIG_HOME/fish/completions/gh.fish
            gh completion -s fish >$completion_file.tmp; and command mv $completion_file.tmp $completion_file
        end
    end

    mkdir -p (path dirname $state_file)
    echo (math "$now + 30 * 86400") >$state_file
end

set -g tide_left_prompt_items os pwd git newline character
set -g tide_right_prompt_items status cmd_duration jobs direnv bun node python rustc java php ruby go gcloud terraform nix_shell time context
type -q aws; and set -a tide_right_prompt_items aws
type -q kubectl; and set -a tide_right_prompt_items kubectl
set -g tide_prompt_add_newline_before true
set -g tide_prompt_transient_enabled false
set -g tide_left_prompt_frame_enabled true
set -g tide_left_prompt_prefix '╭─'
set -g tide_left_prompt_suffix ' '
set -g tide_character_icon ❯
set -g tide_character_color 5fd700
set -g tide_character_color_failure ff0000
set -g tide_pwd_color_anchors 00afff
set -g tide_pwd_color_dirs 0087af
set -g tide_pwd_color_truncated_dirs 8787af
set -g tide_time_format %T

set -g fish_greeting

if status is-interactive
    if not functions -q fisher
        curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        and fisher update
    else
        fisher-update --auto
    end

    type -q atuin; and atuin init fish | source
end
