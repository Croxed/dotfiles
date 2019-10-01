#!/usr/bin/env zsh

[ ! -d "$HOME/.sdkman" ] && {
    printf 'Installing sdkman\n'
    local tempFile="$(mktemp)"
    curl -s "https://get.sdkman.io" > "${tempFile}"
    bash "${tempFile}" 1> /dev/null 2>&1
    printf 'Installation complete\n'
}

source "$HOME/.sdkman/bin/sdkman-init.sh"
