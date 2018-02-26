# Make the terminal pretty and such #
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad

eval "$(dircolors -b)"

git-yolo() {
if [ "$(uname)" = "Darwin" ]; then
    git commit -m "$(curl -s whatthecommit.com/index.txt)" && git push -f
else
    git commit -m "$(curl -s whatthecommit.com/index.txt)" && git push -f
fi
}

function macfeh() {
	open -b "drabweb.macfeh" "$@"
}

docker-attack(){
docker exec -it $1 bash
}
# Simple shit #
### Colored ls
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
fi

if [ "$(uname)" = "Darwin" ]
then
    ## Use a long listing format ##
    # alias ll='gls -lFHah --color=auto'
    # alias ls='gls -Fhlp --color=auto'
    alias ls='exa -bl --git'
    #alias ls='ls -FhlGp'
    alias ll='exa -lab --git'
else
    ## Use a long listing format ##
    alias ll='ls -lFHah --color=auto'
    alias ls='ls -Fhlp --color=auto'
fi

alias c="clear && printf '\e[3J'"

if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
fi


## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias termclock='tty-clock -C 2 -crsDBb'

alias dirs="dirs -v"

# Useful tree aliases
alias tree1='tree --dirsfirst -ChFL 1'
alias tree2='tree --dirsfirst -ChFL 2'
alias tree3='tree --dirsfirst -ChFL 3'
alias tree4='tree --dirsfirst -ChFL 4'
alias tree5='tree --dirsfirst -ChFL 5'
alias tree6='tree --dirsfirst -ChFL 6'

# do not delete / or prompt if deleting more than 3 files at a time #
#alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Using nvim instead of vim "
alias vim="nvim"

# Other shit #
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
alias ports='sudo lsof -iTCP -sTCP:LISTEN -P'

# To exit terminal
alias e='exit'

# See http://www.shellperson.net/using-sudo-with-an-alias/
alias sudo='sudo '

# Mac get stuck very often and are extremely slow and unstable on shutdowns. This forces a shutdown.
alias poweroff='sudo /sbin/shutdown -h now'

# To get my external IP
alias myip='curl icanhazip.com'

# Other IP / Method
alias localip="ifconfig en0 inet | grep 'inet ' | awk ' { print $2 } '"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

if [ "$(uname)" = "Darwin" ]; then
    # Flush the dns cache #
    alias flushdns='sudo killall -HUP mDNSResponder'

    ## Show & hide hidden files in finder ##
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    # Update system with all available updates #
    alias sysupdate='sudo softwareupdate -ia'

    alias brews='brew list -1'
    alias bubo='brew update && brew outdated'
    alias bubc='brew upgrade && brew cleanup'
    alias bubu='bubo && bubc'
    alias subl="open -a /Applications/Sublime\ Text.app"
    alias stfu="osascript -e 'set volume output muted true'"
    alias pumpitup="osascript -e 'set volume 7'"
    alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
fi

# Reload shell #
alias reload='exec "$SHELL"'
alias zr="source $ZDOTDIR/.zshrc"
alias updateall="apacman -Syu --noconfirm --noedit"
