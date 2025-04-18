#!/usr/bin/zsh

alias q='exit 0'

if type -p eza >/dev/null 2>&1; then
    # Use exa
    alias ls='eza -a --icons --no-user --no-time'
    alias ll='eza -al --icons --no-user --no-time'
    alias lt='eza -al --icons --no-user --no-time --tree -L2'
elif type -p exa >/dev/null 2>&1; then
    # Use exa
    alias ls='exa -a --icons --no-user --no-time'
    alias ll='exa -al --icons --no-user --no-time'
    alias lt='exa -al --icons --no-user --no-time --tree -L2'
elif type -p gls >/dev/null 2>&1; then
    ## Use a long listing format ##
    alias ll='gls -lah --color=auto'
    alias ls='gls -Ah --color=auto'
    alias l.='gls -ld .*'
else
    ## Use a long listing format ##
    alias ll='ls -lah --color=auto'
    alias ls='ls -Fhlp --color=auto'
    alias l.='ls -ld .*'
fi

gbn() {
    git branch | awk '$1 ~ /\*/ {print $2}' | tr -d '\n'
}

alias ga='git add'
alias la='ls -ah'

alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias debug="set -o nounset; set -o xtrace"
alias x='chmod +x'

alias du='du -kh'
alias df='df -kTh'

if type -p 2lvim >/dev/null 2>&1; then
    alias vim='lvim'
    alias v='lvim'
elif type -p nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    alias v='vim'
    alias sv='sudo vim'
fi

#alias tmux='tmux -u'

alias cdtemp='cd $(mktemp -d)'

alias v='f -e ${EDITOR}' # quick opening files with vim
alias m='f -e mpv' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
alias j='zz' # directory jumping

alias gi='git-ignore'

alias c="clear && printf '\e[3J'"

[[ "$EUID" -eq 0 ]] && alias reboot='sudo reboot'

# Useful tree aliases
alias tree1='tree --dirsfirst -ChFL 1'
alias tree2='tree --dirsfirst -ChFL 2'
alias tree3='tree --dirsfirst -ChFL 3'
alias tree4='tree --dirsfirst -ChFL 4'
alias tree5='tree --dirsfirst -ChFL 5'
alias tree6='tree --dirsfirst -ChFL 6'

# Other shit #
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
alias ports='sudo lsof -iTCP -sTCP:LISTEN -P'

if type -p pacman >/dev/null 2>&1; then
    # pacman stuff
    alias pup='sudo pacman -Syyu' # update
    alias pin='sudo pacman -S'    # install
    alias pun='sudo pacman -Rs'   # remove
    alias pcc='sudo pacman -Scc'  # clear cache
    alias pls='pacman -Ql'        # list files
    alias prm='sudo pacman -R --nosave --recursive' # really remove, configs and all
    # pkg stuff
    alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
    alias spkg='pkg --sign'
elif type -p brew >/dev/null 2>&1; then
    # homebrew stuff
    alias brews='brew list -1'
    alias bubo='brew update && brew outdated'
    alias bubc='brew upgrade && brew cleanup'
    alias bubu='bubo && bubc'
fi

alias mk='make && make clean'
alias smk='sudo make clean install && make clean'
alias ssmk='sudo make clean install && make clean && rm -iv config.h'

# aliases inside tmux session
if [[ ! -z "$TMUX" ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi

alias rcp='rsync -v --progress'
alias rmv='rcp --remove-source-files'

alias mir='sudo reflector --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist --verbose'

alias gif='byzanz-record -x 1090 -w 750 -y 430 -h 480 -v -d 15 ~/Videos/$(date +%a-%d-%S).gif'
alias rec='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -qp 0 -preset ultrafast ~/Videos/$(date +%a-%d-%S).mkv'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

if [[ "$OSTYPE" == darwin* ]]; then
    # Flush the dns cache #
    alias flushdns='sudo killall -HUP mDNSResponder'

    ## Show & hide hidden files in finder ##
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    # Update system with all available updates #
    alias sysupdate='sudo softwareupdate -ia'

    alias stfu="osascript -e 'set volume output muted true'"
    alias pumpitup="osascript -e 'set volume 7'"
    alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
fi

alias lod='echo "ಠ_ಠ"'
alias idk='echo "¯\_(ツ)_/¯"'
alias wtf='echo "❨╯°□°❩╯ ︵ ┻━┻"'
alias wat='echo "⚆_⚆"'
