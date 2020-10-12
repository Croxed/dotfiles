[[ -r /etc/environment ]] && source /etc/environment
# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(hostname)}

export ZDOTDIR="$HOME/.zsh"
export GOROOT="$HOME/.go"
export GOPATH="$HOME/go"

typeset -gx LANG=en_GB.UTF-8
typeset -gx LC_*=en_GB.UTF-8
## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
