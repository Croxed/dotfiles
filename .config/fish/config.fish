if not functions -q fisher
    echo "Installing fisher bootstrap"
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    #curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    curl https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
end

set fish_greeting

# Base PATH
set -g -x PATH
set -g PATH $PATH /usr/local/bin
set -g PATH $PATH /usr/local/sbin
set -g PATH $PATH /sbin
set -g PATH $PATH /usr/sbin
set -g PATH $PATH /bin
set -g PATH $PATH /usr/bin

set -l path_candidates "$HOME/development/cabo/bin" "$HOME/bin.local" "$HOME/.local/bin" "$HOME/.local/share/bob/nvim-bin" "$VOLTA_HOME/bin" "$HOME/anaconda3/bin" "$HOME/github.com/graalvm/Contents/Home/bin" "$HOME/go/bin" "$HOME/.gobrew/current/bin" "$HOME/.gobrew/bin" "$HOME/.nimble/bin" "$HOME/.bin" "$HOME/n/bin" "$HOME/.symfony/bin" "$HOME/.phpenv/shims" "$HOME/.cabal/bin" "$HOME/.rbenv/bin" "$HOME/.symfony/bin" "$HOME/.poetry/bin" "$HOME/.fzf/bin" "$HOME/.deno/bin" "$HOME/.cargo/bin" "$HOME/scripts" "$HOME/.nexustools" "$HOME/src/gocode/bin" "$HOME/.yarn/bin" "$HOME/.bun/bin" "$HOME/.config/yarn/global/node_modules/.bin" "/usr/local/bin" "/opt/local/sbin" "/opt/local/bin" "/usr/local/share/npm/bin" "/usr/local/opt/coreutils/libexec/gnubin" "/usr/bin/core_perl" "/opt/homebrew/bin" "$HOME"/Library/Python/*/bin "$HOME/.local/share/bob/nvim-bin"
# Conditional PATH additions
for path_candidate in $path_candidates
    if test -d $path_candidate
        if contains $path_candidate $PATH
            continue
        end
        set -gx PATH $path_candidate $PATH
    end
end

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

begin
    set -l NORD_DIRCOLORS "$HOME/.config/dircolors/nord"

    if test -e "$NORD_DIRCOLORS"
        eval (dircolors -c "$NORD_DIRCOLORS")
    end
end

set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_FIND_FILE_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_OPEN_COMMAND 'fd --type f --hidden --follow --exclude .git'
