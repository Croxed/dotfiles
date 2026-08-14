#
#
#                    ██
#                   ░██
#     ██████  ██████░██      ██████  █████
#    ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#       ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#  ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
# ░██ ██████ ██████ ░██  ░██░███   ░░█████
# ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# ============================================================================
# Powerlevel10k instant prompt
# ============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ============================================================================
# Environment
# ============================================================================

path=(
  "$HOME/bin"
  $path
)

export GPG_TTY=$TTY

[[ -r "$HOME/.env.zsh" ]] && source "$HOME/.env.zsh"


# ============================================================================
# General Zsh behaviour
# ============================================================================

WORDCHARS=''
KEYTIMEOUT=20
ZLE_REMOVE_SUFFIX_CHARS=''

PROMPT_EOL_MARK='%K{red} %k'

zle_highlight=('paste:none')


# ============================================================================
# History
# ============================================================================

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"

HISTSIZE=1000000000
SAVEHIST=1000000000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_FCNTL_LOCK


# ============================================================================
# Directory history
#
# Used by Shift+Left / Shift+Right.
# ============================================================================

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT


# ============================================================================
# ZimFW
# ============================================================================

ZIM_HOME="${ZDOTDIR:-${HOME}}/.zim"

# Bootstrap ZimFW itself.
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  command mkdir -p "${ZIM_HOME}"

  command curl -fsSL \
    --create-dirs \
    -o "${ZIM_HOME}/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Rebuild init.zsh when .zimrc changes.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc}" ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init -q
fi

source "${ZIM_HOME}/init.zsh"


# ---------------------------------------------------------------------------
# Redraw and completion
# ---------------------------------------------------------------------------

zstyle ':z4h:*' fzf-command fzf
zstyle ':z4h:fzf-complete' recurse-dirs no
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat

zle -N z4h-fzf-complete
zle -N z4h-fzf-history
zle -N z4h-fzf-dir-history

bindkey '^I' z4h-fzf-complete
bindkey '^R' z4h-fzf-history
bindkey '^[r' z4h-fzf-dir-history

function _z4h_redraw_prompt() {
  emulate -L zsh

  local f

  # Re-run directory-change hooks.
  for f in chpwd "${chpwd_functions[@]}"; do
    (( $+functions[$f] )) || continue
    "$f" &>/dev/null || true
  done

  # Re-run precmd hooks so P10k and similar prompt integrations update.
  for f in precmd "${precmd_functions[@]}"; do
    (( $+functions[$f] )) || continue
    "$f" &>/dev/null || true
  done

  # Re-expand PS1/RPS1.
  zle .reset-prompt

  # Force redisplay.
  zle -R
}

# ============================================================================
# Completion cache for generated CLI completions
# ============================================================================

ZSH_GENERATED_COMPLETIONS="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/generated-completions"

mkdir -p "$ZSH_GENERATED_COMPLETIONS"


# ============================================================================
# Lazy generated completion helper
#
# Similar to what z4h does:
#
# - don't run expensive CLI completion generators during shell startup
# - generate on first TAB
# - reuse until the executable changes
# ============================================================================

function _z4h_generate_completion() {
  emulate -L zsh

  local command_name="$1"
  shift

  local executable="${commands[$command_name]-}"

  [[ -n "$executable" ]] || return 1

  local cache="$ZSH_GENERATED_COMPLETIONS/${command_name}-${EUID}.zsh"

  if [[ ! -r "$cache" || "$executable" -nt "$cache" ]]; then
    local tmp="${cache}.tmp.$$"

    "$executable" "$@" >| "$tmp" 2>/dev/null || {
      rm -f -- "$tmp"
      return 1
    }

    mv -f -- "$tmp" "$cache"

    zcompile -R -- "$cache.zwc" "$cache" 2>/dev/null || true
  fi

  source "$cache"
}


# ============================================================================
# kubectl
#
# z4h deliberately installs its own lazy completion for kubectl.
# ============================================================================

function _z4h_complete_kubectl() {
  emulate -L zsh

  # Remove our wrapper temporarily so kubectl's generated completion can
  # register the real function.
  unset '_comps[kubectl]'

  if ! _z4h_generate_completion kubectl completion zsh; then
    _default "$@"
    return
  fi

  local fn="${_comps[kubectl]-}"

  if [[ -n "$fn" && "$fn" != "_z4h_complete_kubectl" ]]; then
    "$fn" "$@"
  else
    _default "$@"
  fi

  # Reinstate lazy wrapper for future shells/completion refreshes.
  _comps[kubectl]=_z4h_complete_kubectl
}

if (( $+commands[kubectl] )); then
  compdef _z4h_complete_kubectl kubectl
fi


# ============================================================================
# helm
# ============================================================================

function _z4h_complete_helm() {
  emulate -L zsh

  unset '_comps[helm]'

  if ! _z4h_generate_completion helm completion zsh; then
    _default "$@"
    return
  fi

  local fn="${_comps[helm]-}"

  if [[ -n "$fn" && "$fn" != "_z4h_complete_helm" ]]; then
    "$fn" "$@"
  else
    _default "$@"
  fi

  _comps[helm]=_z4h_complete_helm
}

if (( $+commands[helm] )); then
  compdef _z4h_complete_helm helm
fi


# ============================================================================
# OpenShift oc
# ============================================================================

function _z4h_complete_oc() {
  emulate -L zsh

  unset '_comps[oc]'

  if ! _z4h_generate_completion oc completion zsh; then
    _default "$@"
    return
  fi

  local fn="${_comps[oc]-}"

  if [[ -n "$fn" && "$fn" != "_z4h_complete_oc" ]]; then
    "$fn" "$@"
  else
    _default "$@"
  fi

  _comps[oc]=_z4h_complete_oc
}

if (( $+commands[oc] )); then
  compdef _z4h_complete_oc oc
fi


# ============================================================================
# GitHub CLI
#
# Only provide the fallback when another _gh completion wasn't already found.
# ============================================================================

function _z4h_complete_gh() {
  emulate -L zsh

  local executable="${commands[gh]-}"

  [[ -n "$executable" ]] || {
    _default "$@"
    return
  }

  local cache="$ZSH_GENERATED_COMPLETIONS/gh-${EUID}.zsh"

  if [[ ! -r "$cache" || "$executable" -nt "$cache" ]]; then
    local tmp="${cache}.tmp.$$"

    "$executable" completion -s zsh >| "$tmp" 2>/dev/null || {
      rm -f -- "$tmp"
      _default "$@"
      return
    }

    mv -f -- "$tmp" "$cache"

    zcompile -R -- "$cache.zwc" "$cache" 2>/dev/null || true
  fi

  source "$cache"

  if (( $+functions[_gh] )); then
    _gh "$@"
  else
    _default "$@"
  fi
}

if (( $+commands[gh] )) && [[ -z "${_comps[gh]-}" ]]; then
  compdef _z4h_complete_gh gh
fi


# ============================================================================
# Bash-style completion support
#
# Zim's completion module has already initialized compinit. bashcompinit is
# only needed for CLIs that expose Bash's -C completion protocol.
# ============================================================================

autoload -Uz bashcompinit
bashcompinit


# AWS CLI.
if (( $+commands[aws_completer] )) && [[ -z "${_comps[aws]-}" ]]; then
  complete -C =aws_completer aws
fi


# ============================================================================
# Google Cloud SDK
# ============================================================================

if (( $+commands[gcloud] )) && [[ -z "${_comps[gcloud]-}" ]]; then
  typeset -a gcloud_dirs=(
    ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/google-cloud-sdk}
    "$HOME/google-cloud-sdk"
    /usr/share/google-cloud-sdk
    /snap/google-cloud-sdk/current
    /snap/google-cloud-cli/current
    /usr/lib/google-cloud-sdk
    /usr/lib64/google-cloud-sdk
    /opt/google-cloud-sdk
    /opt/local/libexec/google-cloud-sdk
  )

  for dir in "${gcloud_dirs[@]}"; do
    if [[ -r "$dir/completion.zsh.inc" ]]; then
      source "$dir/completion.zsh.inc"
      break
    fi
  done

  unset gcloud_dirs dir
fi


# ============================================================================
# z4h-like common fzf wrapper
# ============================================================================

function _z4h_fzf() {
  emulate -L zsh

  local layout="$1"
  shift

  local -a bindings=(
    'ctrl-h:backward-kill-word'
    'alt-j:clear-query'
    'ctrl-u:clear-query'
    'ctrl-k:kill-line'
    'alt-k:unix-line-discard'
    'ctrl-space:toggle'
    'ctrl-a:toggle-all'
  )

  if [[ "$layout" == default ]]; then
    bindings+=(
      'tab:up'
      'btab:down'
      'ctrl-r:up'
      'ctrl-s:down'
    )
  else
    bindings+=(
      'tab:down'
      'btab:up'
      'ctrl-r:down'
      'ctrl-s:up'
    )
  fi

  command fzf \
    --bind="${(j:,:)bindings}" \
    "$@"
}


# ============================================================================
# Ctrl-R — zsh4humans-like history picker
# ============================================================================

function z4h-fzf-history() {
  emulate -L zsh

  local query="${(j: :)${(@Z:cn:)BUFFER}}"

  [[ -n "$query" ]] && query+=' '

  local preview='printf "%s\n" {}'

  if (( $+commands[bat] )); then
    preview='printf "%s\n" {} | bat -l bash --color=always -pp --wrap=character'
  fi

  local choice

  choice="$(
    builtin fc -rl 1 |
      sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' |
      awk '!seen[$0]++' |
      _z4h_fzf reverse \
        --no-multi \
        --no-sort \
        --cycle \
        --exact \
        --no-mouse \
        --tabstop=1 \
        --query="$query" \
        --color=hl:201,hl+:201 \
        --border=horizontal \
        --height=80% \
        --layout=reverse \
        --preview-window='wrap:4:down:noborder' \
        --preview="$preview"
  )"

  [[ -n "$choice" ]] || return 0

  BUFFER="$choice"
  CURSOR=${#BUFFER}

  _z4h_redraw_prompt
}

zle -N z4h-fzf-history


# ============================================================================
# Shift+Up — cd ..
# ============================================================================

function z4h-cd-up() {
  builtin cd -q .. || return

  _z4h_redraw_prompt
}

zle -N z4h-cd-up


# ============================================================================
# Shift+Left / Shift+Right — directory history
# ============================================================================

function z4h-cd-back() {
  emulate -L zsh

  while (( $#dirstack )); do
    if builtin pushd -q +1 2>/dev/null; then
      _z4h_redraw_prompt
      return
    fi

    builtin popd -q +1 2>/dev/null || break
  done
  _z4h_redraw_prompt
}

function z4h-cd-forward() {
  emulate -L zsh

  while (( $#dirstack )); do
    if builtin pushd -q -0 2>/dev/null; then
      _z4h_redraw_prompt
      return
    fi

    builtin popd -q -0 2>/dev/null || break
  done
  _z4h_redraw_prompt
}

zle -N z4h-cd-back
zle -N z4h-cd-forward


# ============================================================================
# Shift+Down — directory picker
# ============================================================================

function z4h-cd-down() {
  emulate -L zsh

  local choice

  if (( $+commands[fd] )); then
    choice="$(
      command fd \
        --type directory \
        --hidden \
        --exclude .git \
        --strip-cwd-prefix \
        . 2>/dev/null |
      _z4h_fzf reverse \
        --color=hl:201,hl+:201 \
        --exact \
        --no-mouse \
        --tiebreak=length,begin,index \
        --no-multi \
        --cycle \
        --border=horizontal \
        --height=60% \
        --layout=reverse
    )"
  else
    choice="$(
      command find . \
        -mindepth 1 \
        -type d \
        -not -path '*/.git/*' \
        -print 2>/dev/null |
      sed 's#^\./##' |
      _z4h_fzf reverse \
        --color=hl:201,hl+:201 \
        --exact \
        --no-mouse \
        --tiebreak=length,begin,index \
        --no-multi \
        --cycle \
        --border=horizontal \
        --height=60% \
        --layout=reverse
    )"
  fi

  [[ -n "$choice" ]] || {
    _z4h_redraw_prompt
    return 0
  }

  builtin cd -- "$choice" || return

  _z4h_redraw_prompt
}

zle -N z4h-cd-down


# ============================================================================
# Autosuggestion behaviour
#
# Your z4h setting:
#
#   zstyle ':z4h:autosuggestions' forward-char 'accept'
#
# Right Arrow therefore accepts the entire suggestion.
# ============================================================================

function z4h-forward-char() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
  else
    zle forward-char
  fi
}

zle -N z4h-forward-char

# ============================================================================
# Key bindings
#
# z4h configuration:
#
# Shift+Left   previous directory
# Shift+Right  next directory
# Shift+Up     parent
# Shift+Down   child picker
#
# Ctrl+R       history
# Right        accept full autosuggestion
# ============================================================================

bindkey -e

bindkey '^/' undo
bindkey '^[/' redo

bindkey '^[[1;2D' z4h-cd-back
bindkey '^[[1;2C' z4h-cd-forward
bindkey '^[[1;2A' z4h-cd-up
bindkey '^[[1;2B' z4h-cd-down

bindkey '^R' z4h-fzf-history

bindkey '^[[C' z4h-forward-char

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# ============================================================================
# Powerlevel10k configuration
# ============================================================================

[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# path to the framework root directory
SIMPL_ZSH_DIR=${HOME}/.zsh/.zsh-config

. "${SIMPL_ZSH_DIR}/init.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && zsh-defer -c "source $HOME/.sdkman/bin/sdkman-init.sh"


export SCRIPT_TEMPLATE_DIR="$HOME/development/script-template"
#Source the init.sh
if [ -d "$SCRIPT_TEMPLATE_DIR" ]; then
  source "$SCRIPT_TEMPLATE_DIR"/init.sh
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && zsh-defer -c "source $HOME/.bun/_bun"