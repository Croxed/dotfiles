#!/bin/zsh

COMPDUMPFILE=${ZDOTDIR:-${HOME}}/.zcompdump

src()
{
    autoload -U zrecompile
    compinit -u -d $COMPDUMPFILE
    for f in ${ZDOTDIR:-$HOME}/.zshrc $COMPDUMPFILE; do
        zrecompile -p $f && command rm -f $f.zwc.old
    done
    source ${ZDOTDIR:-$HOME}/.zshrc
}

fancy-ctrl-z()
{
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}

pid2 ()
{
    local i
    for i in /proc/<->/stat; do
        [[ "$(< $i)" = *\((${(j:|:)~@})\)* ]] && echo $i:h:t
    done
}

duptree()
{
    dirs=(**/*(/))
    cd -- $dest_root
    mkdir -p -- $dirs
}

list100()
{
    zmodload zsh/stat
    ls -fld $1/**/*(d$(stat +device .)OL[1,100])
}

profile()
{
    ZSH_PROFILE_RC=1 zsh "$@"
}

globalias()
{
    zle _expand_alias
    # this will cause basic shell expressions and variables to be expanded
    # I prefer to have it only work on aliases
    # zle expand-word
    zle self-insert
}

edalias()
{
    [[ -z "$1" ]] && { echo "Usage: edalias <alias_to_edit>" ; return 1 } || vared aliases'[$1]' ;
}

edfunc()
{
    autoload -U zed
    [[ -z "$1" ]] && { echo "Usage: edfunc <function_to_edit>" ; return 1 } || zed -f "$1" ;
}

# save output in a variable for later use
unalias keep >/dev/null 2>&1
keep()
{
    if [[ $# -eq 1 && ($1 == '-h' || $1 == '--help') ]]; then
        cat << EOF
Examples:

    locate -i backup | grep -i thursday | keep
    echo $kept

    or:

    patch < mypatch.diff
    keep **/*.(orig|rej)
    vim \${\${kept:#*.orig}:r}
    rm $kept

EOF
    fi
    setopt localoptions nomarkdirs nonomatch nocshnullglob nullglob
    kept=()  # Erase old value in case of error on next line
    kept=($~*)
    if [[ ! -t 0 ]]; then
        local line
        while read line; do
            kept+=($line)
        done
    fi
    print -Rc - ${^kept%/}(T)
}
alias keep='noglob keep'

# see http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-tty_002c-freezing
ttyctl -f
