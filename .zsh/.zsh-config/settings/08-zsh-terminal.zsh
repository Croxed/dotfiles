#! /usr/bin/env zsh

autoload -Uz add-zsh-hook || return

function -z4h-set-term-title() {
    emulate -L zsh -o no_prompt_bang -o prompt_subst -o prompt_percent

    local title=$1
    shift
    print -Prnv title -- $title
    printf -v title '\e]0;%s\a' "${(V)title}"

    if [[ -t 1 ]]; then
    print -rn -- $title
    elif [[ -v _z4h_tty_fd ]]; then
    print -rnu $_z4h_tty_fd -- $title
    fi
}

# When a command is running, display it in the terminal title.
function -z4h-set-term-title-preexec() {
  emulate -L zsh
  local _z4h_fmt
  if [[ -n $SSH_CONNECTON || $P9K_SSH == 1 ]]; then
    _z4h_fmt='%n@%m: ${1//\%/%%}'
  else
    _z4h_fmt='${1//\%/%%}'
  fi
  [[ -z $_z4h_fmt ]] || -z4h-set-term-title $_z4h_fmt "$@"
}

# When no command is running, display the current directory in the terminal title.
function -z4h-set-term-title-precmd() {
  local -i err=$?
  emulate -L zsh
  local _z4h_fmt
  if [[ -n $SSH_CONNECTON || $P9K_SSH == 1 ]]; then
    zstyle -s :z4h:term-title:ssh   precmd _z4h_fmt || _z4h_fmt='%n@%m: %~'
  else
    zstyle -s :z4h:term-title:local precmd _z4h_fmt || _z4h_fmt='%~'
  fi
  [[ -z $_z4h_fmt ]] || -z4h-set-term-title $_z4h_fmt
}

add-zsh-hook -- preexec -z4h-set-term-title-preexec || return
add-zsh-hook -- precmd  -z4h-set-term-title-precmd || return