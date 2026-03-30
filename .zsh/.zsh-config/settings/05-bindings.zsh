#!/bin/zsh

local keymap
for keymap in emacs viins vicmd; do
  # If NumLock is off, translate keys to make them appear the same as with NumLock on.
  bindkey -M $keymap -s '^[OM'     '^M'      # enter
  bindkey -M $keymap -s '^[OX'     '='
  bindkey -M $keymap -s '^[Oj'     '*'
  bindkey -M $keymap -s '^[Ok'     '+'
  bindkey -M $keymap -s '^[Ol'     '+'
  bindkey -M $keymap -s '^[Om'     '-'
  bindkey -M $keymap -s '^[On'     '.'
  bindkey -M $keymap -s '^[Oo'     '/'
  bindkey -M $keymap -s '^[Op'     '0'
  bindkey -M $keymap -s '^[Oq'     '1'
  bindkey -M $keymap -s '^[Or'     '2'
  bindkey -M $keymap -s '^[Os'     '3'
  bindkey -M $keymap -s '^[Ot'     '4'
  bindkey -M $keymap -s '^[Ou'     '5'
  bindkey -M $keymap -s '^[Ov'     '6'
  bindkey -M $keymap -s '^[Ow'     '7'
  bindkey -M $keymap -s '^[Ox'     '8'
  bindkey -M $keymap -s '^[Oy'     '9'

  # If someone switches our terminal to application mode (smkx), translate keys to make
  # them appear the same as in raw mode (rmkx).
  bindkey -M $keymap -s '^[OA'     '^[[A'    # up
  bindkey -M $keymap -s '^[OB'     '^[[B'    # down
  bindkey -M $keymap -s '^[OD'     '^[[D'    # left
  bindkey -M $keymap -s '^[OC'     '^[[C'    # right
  bindkey -M $keymap -s '^[OH'     '^[[H'    # home
  bindkey -M $keymap -s '^[OF'     '^[[F'    # end

  # TTY sends different key codes. Translate them to xterm equivalents.
  # Missing: {ctrl,alt,shift}+{up,down,left,right,home,end}, {ctrl,alt}+delete.
  bindkey -M $keymap -s '^[[1~'    '^[[H'    # home
  bindkey -M $keymap -s '^[[4~'    '^[[F'    # end

  # Urxvt sends different key codes. Translate them to xterm equivalents.
  bindkey -M $keymap -s '^[[7~'    '^[[H'    # home
  bindkey -M $keymap -s '^[[8~'    '^[[F'    # end
  bindkey -M $keymap -s '^[Oa'     '^[[1;5A' # ctrl+up
  bindkey -M $keymap -s '^[Ob'     '^[[1;5B' # ctrl+down
  bindkey -M $keymap -s '^[Od'     '^[[1;5D' # ctrl+left
  bindkey -M $keymap -s '^[Oc'     '^[[1;5C' # ctrl+right
  bindkey -M $keymap -s '^[[7\^'   '^[[1;5H' # ctrl+home
  bindkey -M $keymap -s '^[[8\^'   '^[[1;5F' # ctrl+end
  bindkey -M $keymap -s '^[[3\^'   '^[[3;5~' # ctrl+delete
  bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
  bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
  bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
  bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
  bindkey -M $keymap -s '^[^[[7~'  '^[[1;3H' # alt+home
  bindkey -M $keymap -s '^[^[[8~'  '^[[1;3F' # alt+end
  bindkey -M $keymap -s '^[^[[3~'  '^[[3;3~' # alt+delete
  bindkey -M $keymap -s '^[[a'     '^[[1;2A' # shift+up
  bindkey -M $keymap -s '^[[b'     '^[[1;2B' # shift+down
  bindkey -M $keymap -s '^[[d'     '^[[1;2D' # shift+left
  bindkey -M $keymap -s '^[[c'     '^[[1;2C' # shift+right
  bindkey -M $keymap -s '^[[7$'    '^[[1;2H' # shift+home
  bindkey -M $keymap -s '^[[8$'    '^[[1;2F' # shift+end

  # Tmux sends different key codes. Translate them to xterm equivalents.
  bindkey -M $keymap -s '^[[1~'    '^[[H'    # home
  bindkey -M $keymap -s '^[[4~'    '^[[F'    # end
  bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
  bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
  bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
  bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
  bindkey -M $keymap -s '^[^[[1~'  '^[[1;3H' # alt+home
  bindkey -M $keymap -s '^[^[[4~'  '^[[1;3F' # alt+end
  bindkey -M $keymap -s '^[^[[3~'  '^[[3;3~' # alt+delete

  # iTerm2 sends different key codes. Translate them to xterm equivalents.
  # Missing (depending on settings): ctrl+{up,down,left,right}, {ctrl,alt}+{delete,backspace}.
  bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
  bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
  bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
  bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
  bindkey -M $keymap -s '^[[1;9A'  '^[[1;3A' # alt+up
  bindkey -M $keymap -s '^[[1;9B'  '^[[1;3B' # alt+down
  bindkey -M $keymap -s '^[[1;9D'  '^[[1;3D' # alt+left
  bindkey -M $keymap -s '^[[1;9C'  '^[[1;3C' # alt+right
  bindkey -M $keymap -s '^[[1;9H'  '^[[1;3H' # alt+home
  bindkey -M $keymap -s '^[[1;9F'  '^[[1;3F' # alt+end

  # TODO: Add missing translations.
done

# Move cursor one char backward.
bindkey   '^[[D'    backward-char                  # left
# Move cursor one char forward.
bindkey   '^[[C'    forward-char                   # right

# Move cursor to the beginning of line.
bindkey   '^[[H'    beginning-of-line              # home
# Move cursor to the end of line.
bindkey   '^[[F'    end-of-line                    # end
# Delete the character under the cursor.
bindkey   '^D'      delete-char                    # ctrl+d
bindkey   '^[[3~'   delete-char                    # delete

# Delete line before cursor.
bindkey   '^[k'     backward-kill-line             # alt+k
bindkey   '^[K'     backward-kill-line             # alt+K
# Delete all lines.
bindkey   '^[j'     kill-buffer                    # alt+j
bindkey   '^[J'     kill-buffer                    # alt+J
# Undo and redo.
bindkey   '^[[Z'    undo                           # shift+tab
bindkey   '^[/'     redo                           # alt+/
# Show help for the command at cursor.
bindkey   '^[h'     run-help                       # alt+h
bindkey   '^[H'     run-help                       # alt+H
# cd into the previous directory.
bindkey   '^[[1;2D' z4h-cd-back                    # shift+left
# cd into the next directory.
bindkey   '^[[1;2C' z4h-cd-forward                 # shift+right
# cd into the parent directory.
bindkey   '^[[1;2A' z4h-cd-up                      # shift+up
if (( _z4h_use[fzf] )); then
  # cd into a subdirectory (interactive).
  bindkey '^[[1;2B' z4h-cd-down                    # shift+down
fi

autoload -Uz terminfo up-line-or-beginning-search down-line-or-beginning-search

typeset -A key=(
[Home]="$terminfo[khome]"
[End]="$terminfo[kend]"
[Insert]="$terminfo[kich1]"
[Backspace]="$terminfo[kbs]"
[Delete]="$terminfo[kdch1]"
[Up]="$terminfo[kcuu1]"
[Down]="$terminfo[kcud1]"
[Left]="$terminfo[kcub1]"
[Right]="$terminfo[kcuf1]"
[PageUp]="$terminfo[kpp]"
[PageDown]="$terminfo[knp]"
[ShiftTab]="$terminfo[kcbt]"
)

[[ -n "$key[Home]" ]] && bindkey -- "$key[Home]" beginning-of-line
[[ -n "$key[End]" ]] && bindkey -- "$key[End]" end-of-line
[[ -n "$key[Insert]" ]] && bindkey -- "$key[Insert]" overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]" ]] && bindkey -- "$key[Delete]" delete-char
[[ -n "$key[ShiftTab]" ]] && bindkey -- "$key[ShiftTab]" reverse-menu-complete
[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search
[[ -n "$key[Left]" ]] && bindkey -- "$key[Left]" backward-char
[[ -n "$key[Right]" ]] && bindkey -- "$key[Right]" forward-char

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle-line-init() { echoti smkx; }
    zle-line-finish() { echoti rmkx; }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# updates editor information when the keymap changes.
zle-keymap-select() { zle reset-prompt; zle -R; }

# ensures the prompt is redrawn when the terminal size changes.
TRAPWINCH() { zle && zle -R; }

zle -N globalias
zle -N fancy-ctrl-z
zle -N zle-keymap-select
zle -N edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N rationalise-dot

# use vi-mode
#bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-/ to perform backward search in history
bindkey '^_' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Ctrl-j/k do the same as arrow keys
bindkey "^K" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search

# Ctrl-z now toggles
bindkey '^Z' fancy-ctrl-z

# Alt-Enter to enter a linebreak without running the command
bindkey '^[^M' self-insert-unmeta

bindkey -M viins " " globalias
bindkey -M viins "^ " magic-space
bindkey -M isearch " " magic-space

# Expands ... to ../..
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

export KEYTIMEOUT=1
