#! /usr/bin/env zsh


install_go() {
    if ! command -v gobrew &>/dev/null; then
        (curl -sL https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | bash) &>/dev/null
    fi
}

install_go
