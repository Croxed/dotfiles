if test uname = "Darwin"
    alias ll 'gls -lFHah --color=auto' --save 
    alias ls 'gls -Fhlp --color=auto' --save 
    alias flushdns 'sudo killall -HUP mDNSResponder' --save 
    alias showFiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app' --save 
    alias hideFiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app' --save 
    alias sysupdate 'sudo softwareupdate -ia' --save 
    alias brews 'brew list -1' --save 
    alias bubo 'brew update && brew outdated' --save 
    alias bubc 'brew upgrade && brew cleanup' --save 
    alias bubu 'bubo && bubc' --save 
    alias subl "open -a /Applications/Sublime\ Text.app" --save 
    alias stfu "osascript -e 'set volume output muted true'" --save 
    alias pumpitup "osascript -e 'set volume 7'" --save 
    alias emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl' --save 
else
    alias ll 'ls -lFHah --color=auto' --save 
    alias ls 'ls -Fhlp --color=auto' --save 
end
alias c "clear && printf '\e[3J'" --save 
alias reboot 'sudo reboot' --save 
alias cdtemp 'cd (mktemp -d)' --save 
alias grep 'grep --color auto' --save 
alias egrep 'egrep --color auto' --save 
alias fgrep 'fgrep --color auto' --save 
alias termclock 'tty-clock -C 2 -crsDBb' --save 
alias dirs "dirs -v" --save 
alias tree1 'tree --dirsfirst -ChFL 1' --save 
alias tree2 'tree --dirsfirst -ChFL 2' --save 
alias tree3 'tree --dirsfirst -ChFL 3' --save 
alias tree4 'tree --dirsfirst -ChFL 4' --save 
alias tree5 'tree --dirsfirst -ChFL 5' --save 
alias tree6 'tree --dirsfirst -ChFL 6' --save 
alias v 'f -e {$EDITOR}'  # quick opening files with vim --save 
alias m 'f -e mpv'  # quick opening files with mplayer --save 
alias o 'a -e xdg-open'  # quick opening files with xdg-open --save 
alias j 'zz'  # directory jumping --save 
alias mv 'mv -i' --save 
alias cp 'cp -i' --save 
alias ln 'ln -i' --save 
alias vim "nvim" --save 
alias wget 'wget -c' --save 
alias df 'df -H' --save 
alias du 'du -ch' --save 
alias ports 'sudo lsof -iTCP -sTCP:LISTEN -P' --save 
alias e 'exit' --save 
alias sudo 'sudo ' --save 
alias poweroff 'sudo /sbin/shutdown -h now' --save 
alias myip 'curl icanhazip.com' --save 
alias localip "ifconfig en0 inet | grep 'inet ' | awk ' { print $2 } '" --save 
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'" --save 
