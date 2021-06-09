#! /usr/bin/env zsh


install_go() {
    if ! command -v go &>/dev/null; then
        (curl -L https://git.io/vQhTU | bash) &>/dev/null
    fi
}

install_go
