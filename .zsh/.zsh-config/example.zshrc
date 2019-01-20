#!/bin/zsh

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL=/usr/bin/zsh || return 0

# path to the framework root directory
SIMPL_ZSH_DIR=~/.zsh

# use ~/.cache history location when not root
[[ $(whoami) == 'root' ]] || HISTFILE=~/.cache/.zsh_history

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

# add ~/bin to the path if not already, the -U flag means 'unique'
typeset -U path=(~/bin $path[@])

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

# ...

# set the prompt last to allow configuration above to take effect
#
# To add or create your own theme create
#
#       themes/prompt_<PROMPT_NAME>_setup
#
# then change the prompt used here
#
prompt simpl

