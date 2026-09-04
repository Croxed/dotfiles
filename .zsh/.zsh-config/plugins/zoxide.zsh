#! /usr/bin/env zsh

if command -v zoxide &>/dev/null; then
    zsh-defer -a eval "$(zoxide init zsh)"
fi
