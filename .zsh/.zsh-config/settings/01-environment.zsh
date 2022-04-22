# Set LANG to Swedish
# typeset -gx LANG=sv_SE.UTF-8

typeset -gx EDITOR='nvim'
typeset -gx FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
typeset -gx FZF_FIND_FILE_COMMAND='fd --type f --hidden --follow --exclude .git'
typeset -gx FZF_OPEN_COMMAND='fd --type f --hidden --follow --exclude .git'
typeset -gz FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC
typeset -gx PURE_GIT_UNTRACKED_DIRTY=0
typeset -gx ENABLE_CORRECTION=true
typeset -gx BAT_THEME='Nord'

#typeset -gx LANG=en_GB.UTF-8
#typeset -gx LC_*=en_GB.UTF-8
typeset -gx NVM_LAZY_LOAD=true
typeset -gx HISTSIZE='1000000000'
typeset -gx SAVEHIST='1000000000'
LS_COLORS+=':no=38;5;248'
typeset -gx ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'        # the default is hard to see
if [ -n $HISTFILE ]; then
    HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
fi