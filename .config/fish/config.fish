if not functions -q fisher
    echo "Installing fisher bootstrap"
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    #curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    curl https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
end

if not type -q starship
    echo "Installing starship"
    curl -sS https://starship.rs/install.sh | sh
end
starship init fish | source

set fish_greeting

# Base PATH
set -g -x PATH
set -g PATH $PATH /usr/local/bin
set -g PATH $PATH /usr/local/sbin
set -g PATH $PATH /sbin
set -g PATH $PATH /usr/sbin
set -g PATH $PATH /bin
set -g PATH $PATH /usr/bin

set -l path_candidates "$z4h_win_home/AppData/Local/Programs/Microsoft\ VS\ Code/bin/" "$HOME/development/cabo/bin" "/Applications/Sublime Text.app/Contents/SharedSupport/bin" "/opt/homebrew/opt/mysql-client/bin" "$HOME/bin.local" "$HOME/.local/bin" "$HOME/.local/share/bob/nvim-bin" "$HOME/anaconda3/bin" "$HOME/github.com/graalvm/Contents/Home/bin" "$HOME/.gobrew/current/bin" "$HOME/.gobrew/bin" "$HOME/.nimble/bin" "$HOME/.bin" "$HOME/n/bin" "$HOME/.symfony/bin" "$HOME/.phpenv/shims" "$HOME/.cabal/bin" "$HOME/.rbenv/bin" "$HOME/.symfony/bin" "$HOME/.poetry/bin" "$HOME/.fzf/bin" "$HOME/.deno/bin" "$HOME/.cargo/bin" "$HOME/scripts" "$HOME/.nexustools" "$HOME/src/gocode/bin" "$HOME/.yarn/bin" "$HOME/.bun/bin" "$HOME/.config/yarn/global/node_modules/.bin" "$HOME/go/bin" "/usr/local/bin" "/opt/local/sbin" "/opt/local/bin" "/usr/local/share/npm/bin" "/usr/local/opt/coreutils/libexec/gnubin" "/usr/bin/core_perl" "$HOME"/Library/Python/*/bin "/opt/homebrew/bin"
# Conditional PATH additions
set -l found_paths
for path_candidate in $path_candidates
    if test -d $path_candidate
        if contains $path_candidate $PATH || contains $path_candidate $found_paths
            continue
        end
        set found_paths $found_paths $path_candidate
    end
end

set -gx PATH $found_paths $PATH

# fish $HOME/.config/fish/aliases.fish

# Load settings
for file in ~/.config/fish/settings/*.fish
    source $file
end


# Load extra configs
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

# Remove duplicates in path
set --local path_sorted
for i in $PATH
    if not contains $i $path_sorted
        set path_sorted $path_sorted $i
    end
end


# finally, set the PATH variable
set PATH $path_sorted

setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end


set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_FIND_FILE_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_OPEN_COMMAND 'fd --type f --hidden --follow --exclude .git'

if status is-interactive && type -q atuin
    atuin init fish | source
end
