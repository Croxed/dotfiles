#! /usr/bin/env bash
# Don't have author credit, but this was made by them and not me
unhide_cursor() {
	printf '\e[?25h'
}
trap unhide_cursor EXIT

clear
printf '\e[?25l'
while true; do
	printf "\033[;H\n\n\n"
	toilet -f future -t --g <<<"$(date +'%H:%M:%S')"
	sleep .1
done
