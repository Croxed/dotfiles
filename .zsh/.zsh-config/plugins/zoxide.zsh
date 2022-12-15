#! /usr/bin/env zsh

if command -v zoxide &>/dev/null; then
    zsh-defer eval "$(zoxide init zsh)"
fi
