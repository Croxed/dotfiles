#!/usr/bin/env zsh

_source_mise() {
    if [ -f $HOME/.local/bin/mise ]; then
      eval "$($HOME/.local/bin/mise activate zsh)"
    fi
}

zsh-defer -a _source_mise
