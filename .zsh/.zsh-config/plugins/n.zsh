#!/usr/bin/env zsh 

[ ! -d "$HOME/n" ] && {
    printf 'Installing n\n'
    curl -sL https://raw.githubusercontent.com/mklement0/n-install/master/bin/n-install | bash -s -- -q -n
}
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
