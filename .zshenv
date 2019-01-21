[[ -r /etc/environment ]] && source /etc/environment
# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(hostname)}

export ZDOTDIR="$HOME/.zsh"

export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
