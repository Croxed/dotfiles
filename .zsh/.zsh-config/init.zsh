#! /usr/bin/env zsh

# path to the framework root directory
SIMPL_ZSH_DIR=${ZDOTDIR:-${HOME}}/.zsh-config

fpath+=("$SIMPL_ZSH_DIR"/completions)

# all candidated for sourcing into path
declare -a path_candidate
path_candidate=(
    "/usr/local/bin"
    "/opt/local/sbin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/bin/core_perl"
    "$HOME/anaconda3/bin"
    "$HOME/github.com/graalvm/Contents/Home/bin"
    "$HOME/.bin"
    "$HOME/.cabal/bin"
    "$HOME/.rbenv/bin"
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

# Source custom plugins
z4h source $Z4H/laggardkernel/git-ignore/git-ignore.plugin.zsh
z4h source $Z4H/lukechilds/zsh-nvm/zsh-nvm.plugin.zsh
source $Z4H/jarmo/expand-aliases-oh-my-zsh/expand-aliases.plugin.zsh
