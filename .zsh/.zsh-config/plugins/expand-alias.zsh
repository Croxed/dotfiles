#! /usr/bin/env zsh

function __expand-alias() {
	zle _expand_alias
	#zle self-insert
}

zle -N __expand-alias
bindkey -M main ' ' __expand-alias
