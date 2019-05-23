#!/usr/bin/env zsh

NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.}nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -fSsL "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" -o- | bash
fi

\. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
