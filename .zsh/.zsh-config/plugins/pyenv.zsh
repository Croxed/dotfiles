#!/usr/bin/env zsh

export PYENV_ROOT="$HOME/.pyenv"
if [ ! -d "$PYENV_ROOT" ]; then
    if ! curl https://pyenv.run | bash >/dev/null; then
      printf 'Failed to install pyenv\n'
    fi
fi
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
