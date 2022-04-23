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

ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

plugins=(
    romkatv/powerlevel10k
    # use zsh-defer magic to load the remaining plugins at hypersonic speed!
    romkatv/zsh-defer

    # user plugins
    laggardkernel/git-ignore
    hlissner/zsh-autopair
    peterhurford/up.zsh

    # core plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-completions

    # load this one last
    zsh-users/zsh-syntax-highlighting
)

zmodload -F zsh/stat b:zstat

function plugged() {
  local arg
  arg="$1"
  (( $#@ == 0 )) && print -Pru2 -- "%F{3}unplugged%f: No args passed to plugged" && return 1
  shift

  case "$arg" in
    init) __plugged-init $@
    ;;
    update) __update-plugins $@
    ;;
    compile) __plugin-compile $@
    ;;
    *) print -Pru2 -- "%F{3}unplugged%f: $arg is unknown" && return
    ;;
  esac
}

function __update-plugins() {
  for repo in $plugins; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    if [[ -d $plugin_dir ]]; then
      print -Pru2 -- "%F{3}unplugged%f: Updating %F{2}$repo%f"
      git -C $plugin_dir pull >/dev/null 2>&1 || { print -Pru2 -- "%F{3}unplugged%f: Failed to update %F{4}$repo%f" }
    fi
  done
}

function __plugged-init() {
  __maybe-update
  __plugin-compile
  __plugin-load
}

function __maybe-update() {
  local repo plugin_name plugin_dir initfile initfiles last_update_ts days
  days=10
  [[ ! -f $ZPLUGINDIR/last-update-ts ]] && print -n > $ZPLUGINDIR/last-update-ts
  if zstat -A last_update_ts +mtime -- $ZPLUGINDIR/last-update-ts 2>/dev/null &&
    (( EPOCHSECONDS - last_update_ts[1] >= 86400 * days )); then
    local REPLY
    {
    read -q ${(%):-"?%F{3}unplugged%f: update dependencies? [y/N]: "} && REPLY=y
    }
    print -n >$ZPLUGINDIR/last-update-ts || return
    print ''
    if [[ $REPLY == y ]]; then
    update-plugins && return
    fi
    print -Pru2 -- "%F{3}unplugged%f: won't ask to update again for %B$days%b day(s)"
  fi
}

function __plugin-load() {
  local repo plugin_name plugin_dir initfile initfiles
  for repo in $plugins; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      print -Pru2 -- "%F{3}unplugged%f: Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# if you want to compile your plugins you may see performance gains
function __plugin-compile() {
  autoload -U zrecompile
  local f compiled_ts source_ts
  for f in $ZPLUGINDIR/*/*.plugin.zsh{,-theme}(N); do
    if [[ -f "$f".zwc ]]; then
      zstat -A compiled_ts +mtime -- "$f".zwc
      zstat -A source_ts +mtime -- "$f"
      (( compiled_ts[1] - source_ts[1] >= 0 )) && continue
    fi
    zrecompile -pq "$f"
  done
}

plugged init || return
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit compdef
compinit

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY


# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# path to the framework root directory
SIMPL_ZSH_DIR=${HOME}/.zsh/.zsh-config

. "${SIMPL_ZSH_DIR}/init.zsh"
