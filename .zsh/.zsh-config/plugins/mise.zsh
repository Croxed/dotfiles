#! /usr/bin/env zsh

_load_mise() {
   if [ -f "$HOME/.local/bin/mise" ]; then
     eval "$($HOME/.local/bin/mise activate zsh)"
   fi
}

_load_mise
