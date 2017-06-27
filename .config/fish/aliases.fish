function ..
  cd .. $argv
end

switch (uname)
case Darwin
  function ls --description 'List contents of directory'
    command gls -Fhlp --color=auto $argv
  end

  function flushdns
    command sudo killall -HUP mDNSResponder $argv
  end

  ## Show & hide hidden files in finder ##
  function showFiles
    command defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app $argv
  end

  function hideFiles
    command defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app $argv
  end

  # Update system with all available updates #
  function sysupdate
    command sudo softwareupdate -ia $argv
  end

  function brews
    command brew list -1 $argv
  end

  function bubo
    command brew update $argv
    command brew outdated $argv
  end

  function bubc
    command brew upgrade $argv
    command brew cleanup $argv
  end

  function bubu
    bubo $argv
    bubc $argv
  end

  function subl
    open -a /Applications/Sublime\ Text.app $argv
  end

  function stfu
    command osascript -e 'set volume output muted true' $argv
  end

  function pumpitup
    command osascript -e 'set volume 7' $argv
  end

  function emptytrash
    command sudo rm -rfv /Volumes/*/.Trashes $argv and rm -rfv ~/.Trash $argv and rm -rfv /private/var/log/asl/*.asl $argv
  end
case "*"
  function ls --description 'List contents of directory'
    command ls -Fhlp --color=auto $argv
  end
end

function reboot
  sudo reboot $argv
end

function ll
  ls -al $argv
end

function grep
  command grep --color=auto $argv
end

function egrep
  command egrep --color=auto §argv
end

function fgrep
  command fgrep --color=auto §argv
end

function termclock
  command tty-clock -C 2 -crsDBb $argv
end

function dirs
  command dirs -v $argv
end

function mv
  command mv -i $argv
end

function cp
  command cp -i $argv
end

function ln
 command ln -i $argv
end

function vim
  command nvim $argv
end

function wget
  command wget -c $argv
end

function df
  command df -H $argv
end

function du
  command du -ch $argv
end

function ports
  command sudo lsof -iTCP -sTCP:LISTEN -P $argv
end

function poweroff
  command sudo /sbin/shutdown -h now $argv
end

function myip
  command curl icanhazip.com $argv
end

function localip
  command ifconfig en0 inet | grep 'inet ' | awk ' { print $2 } ' $argv
end

function ips
  command ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1' $argv
end

function reload
  command fish
end

function c
  command clear and printf '\e[3J'
end

function git-yolo
  git commit -m (curl http://whatthecommit.com | grep '<p>' | sed -r 's/^.{3}//') ;and git push -f
end

alias undopush="git push -f origin HEAD^:master"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gca="git commit -a -m"
alias gcm="git commit -m"
alias gbd="git branch -D"
alias gst="git status -sb --ignore-submodules"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias grs="git reset --soft"
alias grh="git reset --hard"
alias gb="git branch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git lg"
alias gpom="git pull origin master"

function tree1; tree --dirsfirst -ChFLQ 1 $argv; end
function tree2; tree --dirsfirst -ChFLQ 2 $argv; end
function tree3; tree --dirsfirst -ChFLQ 3 $argv; end
function tree4; tree --dirsfirst -ChFLQ 4 $argv; end
function tree5; tree --dirsfirst -ChFLQ 5 $argv; end
function tree6; tree --dirsfirst -ChFLQ 6 $argv; end