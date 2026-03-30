# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' fzf-command fzf
# Better colors and spacing
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':fzf-tab:complete:*' fzf-flags \
    --color=hl:201,hl+:201 \
    --with-nth=2 \
    --delimiter='\000' \
    --ansi \
    --exact \
    --no-mouse \
    --tiebreak=length,begin,index \
    --multi \
    --cycle \
    --border=horizontal \
    --layout=reverse

#zstyle ':fzf-tab:*' fzf-preview ''

zstyle ':fzf-tab:*' fzf-flags \
    --color=hl:201,hl+:201 \
    --with-nth=2 \
    --delimiter='\000' \
    --ansi \
    --exact \
    --no-mouse \
    --tiebreak=length,begin,index \
    --multi \
    --bind=tab:accept \
    --cycle \
    --border=horizontal \
    --layout=reverse