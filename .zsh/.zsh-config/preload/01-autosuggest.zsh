if (( terminfo[colors] >= 256 )); then
	LS_COLORS+=':no=38;5;248'
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'        # the default is hard to see
else
	LS_COLORS+=':no=1;30'
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold' # the default is outside of 8-color range
fi

#ZSH_AUTOSUGGEST_MANUAL_REBIND=1
typeset -g ZSH_AUTOSUGGEST_EXECUTE_WIDGETS=()
typeset -g ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    emacs-forward-word
    forward-word
    vi-find-next-char
    vi-find-next-char-skip
    vi-forward-blank-word
    vi-forward-blank-word-end
    vi-forward-word
    vi-forward-word-end
  )
typeset -g ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char vi-forward-char)
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(end-of-line vi-add-eol vi-end-of-line)