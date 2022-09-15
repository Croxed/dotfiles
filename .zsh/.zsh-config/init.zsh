#! /usr/bin/env zsh

required_completions=(
    docker 'https://github.com/docker/cli/raw/master/contrib/completion/zsh/_docker'
    docker-compose 'https://github.com/docker/compose/raw/master/contrib/completion/zsh/_docker-compose'
)

for key value in ${(kv)required_completions}; do
    if [ ! -f "$SIMPL_ZSH_DIR"/completion/_"$key" ]; then
        curl --create-dirs -fSsL "$value" -o "$SIMPL_ZSH_DIR"/completion/_"$key"
    fi
done

fpath+=("$SIMPL_ZSH_DIR"/completion)

typeset -gx GOROOT="$HOME"/.go
typeset -gx GOPATH="$HOME"/go
typeset -gx VOLTA_HOME="$HOME/.volta"
setopt NULL_GLOB
# all candidated for sourcing into path
declare -a path_candidate
path_candidate=(
    "$z4h_win_home/AppData/Local/Programs/Microsoft\ VS\ Code/bin/"
    "$HOME/development/cabo/bin"
    "$HOME/bin.local"
    "$HOME/.local/bin"
    "$VOLTA_HOME/bin"
    "$HOME/anaconda3/bin"
    "$HOME/github.com/graalvm/Contents/Home/bin"
    "$HOME/.bin"
    "$HOME/n/bin"
    "$HOME/.symfony/bin"
    "$HOME/.phpenv/shims"
    "$HOME/.cabal/bin"
    "$HOME/.rbenv/bin"
    "$HOME/.symfony/bin"
    "$HOME/.poetry/bin"
    "$HOME/.fzf/bin"
    "$GOPATH/bin"
    "$GOROOT/bin"
    "$HOME/.cargo/bin"
    "$HOME/scripts"
    "$HOME/.nexustools"
    "$HOME/src/gocode/bin"
    "$HOME/.yarn/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "/usr/local/bin"
    "/opt/local/sbin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/bin/core_perl"
    "$HOME"/Library/Python/*/bin
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
source $Z4H/jarmo/expand-aliases-oh-my-zsh/expand-aliases.plugin.zsh
z4h source $Z4H/hlissner/zsh-autopair/autopair.zsh
z4h source $Z4H/peterhurford/up.zsh/up.plugin.zsh
