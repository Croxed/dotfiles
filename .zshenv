[[ -r /etc/environment ]] && source /etc/environment
# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(hostname)}

export ZDOTDIR="$HOME/.zsh"
## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
