if not test -f ~/.config/fish/functions/fisher.fish
    echo "Installing fisherman for the first time"
    curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
    fisher
end

# Base PATH
set -g -x PATH
set -g PATH $PATH /usr/local/bin
set -g PATH $PATH /usr/local/sbin
set -g PATH $PATH /sbin
set -g PATH $PATH /usr/sbin
set -g PATH $PATH /bin
set -g PATH $PATH /usr/bin

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
    /Applications/Xcode.app/Contents/Developer/usr/bin \
    /usr/bin/core_perl \
    /opt/local/bin \
    /usr/local/share/npm/bin \
    /usr/local/opt/coreutils/libexec/gnubin \
    ~/.cabal/bin \
    ~/.rbenv/bin \
    ~/.bin \
    ~/.cargo/bin \
    ~/bin.local \
    ~/scripts \
    ~/.nexustools \
    ~/src/gocode/bin \
    /usr/local/CrossPack-AVR/bin \
    /usr/local/texlive/2016/bin/x86_64-darwin
    if test -d $path_candidate
        set -gx PATH $path_candidate $PATH
    end
end

source $HOME/.config/fish/aliases.fish

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

function fish_greeting
    command clear
    echo -e "\e[01;35m" ;and figlet -f colossal (command getos) ;and echo -e "\e[00m"
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
