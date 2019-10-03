#! /usr/bin/env bash

main() {
    status="$(playerctl status)"
    symbol=""
    if [ "$status" == 'Paused' ]; then
        symbol=""
    fi
    artist="$(playerctl metadata artist)"
    title="$(playerctl metadata title)"
    echo "${symbol} ${artist} - ${title}"
}

main
