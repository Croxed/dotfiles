#!/bin/zsh

# load bracketed paste
autoload -Uz bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

# support colors in less, the standard pager
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

if [[ $TERM == 'linux' ]]; then
    # linux console 0-15 colors
    colors=(
    "\e]P0000000" "\e]P88dbc8d" "\e]P1d14545" "\e]P9d14545"
    "\e]P26baa17" "\e]PA8dbc8d" "\e]P3eab93d" "\e]PBffc123"
    "\e]P4204a87" "\e]PC3465a4" "\e]P5af86c8" "\e]PDaf86c8"
    "\e]P689b6e2" "\e]PE46a4ff" "\e]P7cccccc" "\e]PFffffff"
    )
    for col in "${colors[@]}"; do
        printf "$col"
    done
fi
