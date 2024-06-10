#!/usr/bin/zsh

function __croxed.create_abbr -d "Create abbreviations"
    set -l name $argv[1]
    set -l body $argv[2..-1]
    if test (count $body) -lt 1
        echo "Something is wrong with $argv"
        return
    end

    # TODO: global scope abbr will be default in fish 3.6.0
    abbr -a -g $name $body
end


__croxed.create_abbr q 'exit 0'

if type -q exa
    # Use exa
    __croxed.create_abbr ls 'exa -a --icons --no-user --no-time'
    __croxed.create_abbr ll 'exa -al --icons --no-user --no-time'
    __croxed.create_abbr lt 'exa -al --icons --no-user --no-time --tree -L2'
else if type -q gls
    ## Use a long listing format ##
    __croxed.create_abbr ll 'gls -lah --color=auto'
    __croxed.create_abbr ls 'gls -Ah --color=auto'
else
    ## Use a long listing format ##
    __croxed.create_abbr ll 'ls -lah --color=auto'
    __croxed.create_abbr ls 'ls -Fhlp --color=auto'
end

function gbn
    git branch | awk '$1 ~ /\*/ {print $2}' | tr -d '\n'
end

__croxed.create_abbr ga 'git add'
__croxed.create_abbr la 'ls -ah'

__croxed.create_abbr mkdir 'mkdir -pv'
__croxed.create_abbr grep 'grep --color=auto'
__croxed.create_abbr debug "set -o nounset; set -o xtrace"
__croxed.create_abbr x 'chmod +x'

__croxed.create_abbr du 'du -kh'
__croxed.create_abbr df 'df -kTh'

if type -q lvim
    __croxed.create_abbr vim 'lvim'
    __croxed.create_abbr v 'lvim'
else if type -q nvim
    __croxed.create_abbr vim 'nvim'
    __croxed.create_abbr v 'nvim'
    __croxed.create_abbr sv 'sudo nvim'
else
    __croxed.create_abbr v 'vim'
    __croxed.create_abbr sv 'sudo vim'
end

#__croxed.create_abbr tmux 'tmux -u'

__croxed.create_abbr cdtemp 'cd $(mktemp -d)'

__croxed.create_abbr v 'f -e $EDITOR' # quick opening files with vim
__croxed.create_abbr m 'f -e mpv' # quick opening files with mplayer
__croxed.create_abbr o 'a -e xdg-open' # quick opening files with xdg-open
__croxed.create_abbr j 'zz' # directory jumping

__croxed.create_abbr gi 'git-ignore'

__croxed.create_abbr c "clear && printf '\e[3J'"

if set -q EUID
    if [ EUID = 0 ]
        __croxed.create_abbr reboot 'sudo reboot'
    end
end


# Useful tree __croxed.create_abbres
__croxed.create_abbr tree1 'tree --dirsfirst -ChFL 1'
__croxed.create_abbr tree2 'tree --dirsfirst -ChFL 2'
__croxed.create_abbr tree3 'tree --dirsfirst -ChFL 3'
__croxed.create_abbr tree4 'tree --dirsfirst -ChFL 4'
__croxed.create_abbr tree5 'tree --dirsfirst -ChFL 5'
__croxed.create_abbr tree6 'tree --dirsfirst -ChFL 6'

# Other shit #
__croxed.create_abbr wget 'wget -c'
__croxed.create_abbr df 'df -H'
__croxed.create_abbr du 'du -ch'
__croxed.create_abbr ports 'sudo lsof -iTCP -sTCP:LISTEN -P'

if type -q pacman
    # pacman stuff
    __croxed.create_abbr pup 'sudo pacman -Syyu' # update
    __croxed.create_abbr pin 'sudo pacman -S'    # install
    __croxed.create_abbr pun 'sudo pacman -Rs'   # remove
    __croxed.create_abbr pcc 'sudo pacman -Scc'  # clear cache
    __croxed.create_abbr pls 'pacman -Ql'        # list files
    __croxed.create_abbr prm 'sudo pacman -R --nosave --recursive' # really remove, configs and all
    # pkg stuff
    __croxed.create_abbr pkg 'makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
    __croxed.create_abbr spkg 'pkg --sign'
else if type -q brew
    # homebrew stuff
    __croxed.create_abbr brews 'brew list -1'
    __croxed.create_abbr bubo 'brew update && brew outdated'
    __croxed.create_abbr bubc 'brew upgrade && brew cleanup'
    __croxed.create_abbr bubu 'bubo && bubc'
end

__croxed.create_abbr mk 'make && make clean'
__croxed.create_abbr smk 'sudo make clean install && make clean'
__croxed.create_abbr ssmk 'sudo make clean install && make clean && rm -iv config.h'

# __croxed.create_abbres inside tmux session
if set -q $TMUX
    __croxed.create_abbr :sp 'tmux split-window'
    __croxed.create_abbr :vs 'tmux split-window -h'
end

__croxed.create_abbr rcp 'rsync -v --progress'
__croxed.create_abbr rmv 'rcp --remove-source-files'

__croxed.create_abbr mir 'sudo reflector --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist --verbose'

__croxed.create_abbr gif 'byzanz-record -x 1090 -w 750 -y 430 -h 480 -v -d 15 ~/Videos/$(date +%a-%d-%S).gif'
__croxed.create_abbr rec 'ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -qp 0 -preset ultrafast ~/Videos/$(date +%a-%d-%S).mkv'

__croxed.create_abbr calc 'python -qi -c "from math import *"'
__croxed.create_abbr brok 'sudo find . -type l -! -exec test -e {} \; -print'
__croxed.create_abbr timer 'time read -p "Press enter to stop"'

# shellcheck disable=2142
__croxed.create_abbr xp 'xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
__croxed.create_abbr get 'curl --continue-at - --location --progress-bar --remote-name --remote-time'

set -q OSTYPE; or set OSTYPE ''

if test (uname) = 'Darwin'
    # Flush the dns cache #
    __croxed.create_abbr flushdns 'sudo killall -HUP mDNSResponder'

    ## Show & hide hidden files in finder ##
    __croxed.create_abbr showFiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    __croxed.create_abbr hideFiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    # Update system with all available updates #
    __croxed.create_abbr sysupdate 'sudo softwareupdate -ia'

    __croxed.create_abbr stfu "osascript -e 'set volume output muted true'"
    __croxed.create_abbr pumpitup "osascript -e 'set volume 7'"
    __croxed.create_abbr emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
end

__croxed.create_abbr lod 'echo "ಠ_ಠ"'
__croxed.create_abbr idk 'echo "¯\_(ツ)_/¯"'
__croxed.create_abbr wtf 'echo "❨╯°□°❩╯ ︵ ┻━┻"'
__croxed.create_abbr wat 'echo "⚆_⚆"'