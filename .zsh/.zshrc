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
[[ "$EUID" -eq 0 ]] || HISTFILE=~/.cache/.zsh_history

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

# Set golang paths before sourcing into path
typeset -gx GOROOT="$HOME/.go"
typeset -gx GOPATH="$HOME/go"

# all candidated for sourcing into path
declare -a path_candidate
path_candidate=(
    "/opt/local/sbin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/bin/core_perl"
    "$HOME/anaconda3/bin"
    "$HOME/github.com/graalvm/Contents/Home/bin"
    "$HOME/.bin"
    "/Applications/Xcode.app/Contents/Developer/usr/bin"
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
    "$HOME/.config/yarn/global/node_modules/.bin"
    )

# add all specified oaths to the path if not already, the -U flag means 'unique'
typeset -U path=($path_candidate[@] $path[@])

# strip empty fields from the path
path=("${path[@]:#}")

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL="$(which zsh)" || return 0

# used internally by zsh for loading themes and completions
typeset -U fpath=("$SIMPL_ZSH_DIR/"{completion,themes} $fpath)

# source shell configuration files
for f in "$SIMPL_ZSH_DIR"/{settings,plugins}/*?.zsh; do
    . "$f" 2>/dev/null
done
