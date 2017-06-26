function fish_greeting
    fish_logo
end

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
