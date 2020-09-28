#! /usr/bin/env zsh

if [ ! -f "$HOME"/.local/share/lscolors.sh ]; then
    cd $Z4H/arcticicestudio/nord-dircolors/src || return
    dircolors -b dir_colors > "$HOME"/.local/share/lscolors.sh
    cd - &>/dev/null
fi

. "$HOME"/.local/share/lscolors.sh