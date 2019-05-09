#!/usr/bin/env zsh

[ ! -d "$HOME/.sdkman" ] && {
    printf 'Installing sdkman\n'
    (curl -s "https://get.sdkman.io" | bash) &> /dev/null &2>1
    printf 'Installation complete\n'
}

source "$HOME/.sdkman/bin/sdkman-init.sh"
