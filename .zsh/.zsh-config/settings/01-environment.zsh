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