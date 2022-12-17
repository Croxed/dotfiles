#! /usr/bin/env zsh

_expand-ealias() {
  local ealiases
  typeset -a ealiases
  ealiases=("${(@k)aliases}")
  if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle magic-space
}

zle -N _expand-ealias

bindkey ' '    _expand-ealias
bindkey '^ '   magic-space          # control-space to bypass completion
bindkey -M isearch " "  magic-space # normal space during searches
