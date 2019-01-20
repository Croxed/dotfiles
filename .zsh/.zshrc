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

# path to the framework root directory
SIMPL_ZSH_DIR=${ZDOTDIR:-${HOME}}/.zsh-config

# use ~/.cache history location when not root
[[ $(whoami) == 'root' ]] || HISTFILE=~/.cache/.zsh_history

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

# Set golang paths before sourcing into path
typeset -gx GOROOT="$HOME/.go"
typeset -gx GOPATH="$HOME/go"

# all candidated for sourcing into path
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
    "$HOME/.fzf/bin"
    "$HOME/.pyenv/bin"
    "$GOPATH/bin"
    "$GOROOT/bin"
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

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL="$(which zsh)" || return 0

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

# ...

# set the prompt last to allow configuration above to take effect
#
# To add or create your own theme create
#
#       themes/prompt_<PROMPT_NAME>_setup
#
# then change the prompt used here
#

