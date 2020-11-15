#! /usr/bin/env zsh

fpath+=("$SIMPL_ZSH_DIR"/completions)

typeset -gx VOLTA_HOME="$HOME/.volta"
# all candidated for sourcing into path
declare -a path_candidate
path_candidate=(
    "/c/Users/oscwen/AppData/Local/Programs/Microsoft\ VS\ Code/bin/"
    "$HOME/development/cabo/bin"
    "/usr/local/bin"
    "/opt/local/sbin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/bin/core_perl"
    "$VOLTA_HOME/bin"
    "$HOME/anaconda3/bin"
    "$HOME/github.com/graalvm/Contents/Home/bin"
    "$HOME/.bin"
    "$HOME/.phpenv/bin"
    "$HOME/.cabal/bin"
    "$HOME/.rbenv/bin"
    "$HOME/.poetry/bin"
    "$HOME/.fzf/bin"
    "$HOME/.pyenv/bin"
    "$GOPATH/bin"
    "$GOROOT/bin"
    "$HOME/.cargo/bin"
    "$HOME/bin.local"
    "$HOME/scripts"
    "$HOME/.nexustools"
    "$HOME/src/gocode/bin"
    "$HOME/.yarn/bin"
    "$HOME/Development/cabo/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "$HOME/Library/Python/3.7/bin"
    )

# add all specified oaths to the path if not already, the -U flag means 'unique'
typeset -U path=($path_candidate[@] $path[@])

# strip empty fields from the path
path=("${path[@]:#}")

# source shell configuration files
for f in "$SIMPL_ZSH_DIR"/plugins/*?.zsh; do
    . "$f" 2>/dev/null
done

for f in "$SIMPL_ZSH_DIR"/settings/*?.zsh; do
    . "$f" 2>/dev/null
done

if [ -d "$HOME"/.zsh-settings ]; then
    for f in "$HOME"/.zsh-settings/*?.zsh; do
        . "$f" 2>/dev/null
    done
fi

# Source custom plugins
z4h source $Z4H/laggardkernel/git-ignore/git-ignore.plugin.zsh
z4h source $Z4H/lukechilds/zsh-nvm/zsh-nvm.plugin.zsh
source $Z4H/jarmo/expand-aliases-oh-my-zsh/expand-aliases.plugin.zsh
