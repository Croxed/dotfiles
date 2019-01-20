#!/usr/bin/env zsh

#
#                    ██
#                   ░██
#     ██████  ██████░██      ██████  █████
#    ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#       ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#  ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
# ░██ ██████ ██████ ░██  ░██░███   ░░█████
# ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL=/usr/bin/zsh || return 0

# path to the framework root directory
SIMPL_ZSH_DIR=${ZDOTDIR:-${HOME}}/.zsh-config

# use ~/.cache history location when not root
[[ $(whoami) == 'root' ]] || HISTFILE=~/.cache/.zsh_history

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

declare -a path_candidate
path_candidate=(
    "/opt/local/sbin"
    "/Applications/Xcode.app/Contents/Developer/usr/bin"
    "/usr/bin/core_perl"
    "$HOME/anaconda3/bin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "~/.cabal/bin"
    "~/.rbenv/bin"
    "~/.bin"
    "$HOME/.pyenv/bin"
    "~/.cargo/bin"
    "~/bin.local"
    "~/scripts"
    "~/.nexustools"
    "~/src/gocode/bin"
    "/usr/local/CrossPack-AVR/bin"
    "/usr/local/texlive/2016/bin/x86_64-darwin"
    )

# add all specified oaths to the path if not already, the -U flag means 'unique'
typeset -U path=($path_candidate[@] $path[@])

# strip empty fields from the path
path=("${path[@]:#}")

# used internally by zsh for loading themes and completions
typeset -U fpath=("$SIMPL_ZSH_DIR/"{completion,themes} $fpath)

# initialize the prompt
autoload -U promptinit && promptinit

# source shell configuration files
for f in "$SIMPL_ZSH_DIR"/{settings,plugins}/*?.zsh; do
    . "$f" 2>/dev/null
done

## User configuration below

export MANWIDTH=100
export IGNOREEOF=100
export HISTSIZE=10000
export SAVEHIST=10000

## ZPLUGIN
export ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
[[ -d ${ZDOTDIR:-$HOME}/.zplugin ]] ||(
mkdir "$ZPLG_HOME"
echo ">>> Downloading zplugin to $ZPLG_HOME/bin"
git clone --depth 10 https://github.com/zdharma/zplugin.git "$ZPLG_HOME/bin"
echo ">>> Done"
)

### Added by Zplugin's installer
source "$ZPLG_HOME/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

## zplugin start

zplugin load zdharma/history-search-multi-word

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-completions
zplugin light willghatch/zsh-saneopt
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

## zplugin end

# ...

# set the prompt last to allow configuration above to take effect
#
# To add or create your own theme create
#
#       themes/prompt_<PROMPT_NAME>_setup
#
# then change the prompt used here
#

