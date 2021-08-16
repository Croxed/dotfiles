#!/usr/bin/env zsh

if [ -n "$z4h_win_home" ]; then
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0.0

    export LIBGL_ALWAYS_INDIRECT=1
fi
