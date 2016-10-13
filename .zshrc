#
#                    ██
#                   ░██
#     ██████  ██████░██      ██████  █████
#    ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#       ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#  ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
# ░██ ██████ ██████ ░██  ░██░███   ░░█████
# ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#                     __

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

export GOPATH=~/gopath

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /usr/bin/core_perl \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  ~/.cabal/bin \
  ~/.rbenv/bin \
  ~/bin \
  ~/bin.local \
  ~/scripts \
  ~/.nexustools \
  ~/src/gocode/bin \
  /usr/local/CrossPack-AVR/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${PATH}:${path_candidate}
  fi
done

# ----------------------- Start of zplug config ----------------------- #

# Check if zplug is installed
[[ -d ~/.zplug ]] || {
git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/zplug && zplug update --self
}

# Load zplug
source ~/.zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search", nice:19
zplug "djui/alias-tips"
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh, nice:14
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-completions", use:"src"
zplug "zsh-users/zsh-syntax-highlighting", nice:17
zplug "zsh-users/zsh-autosuggestions", nice:18
zplug "rimraf/k"
zplug "plugins/gitfast", from:oh-my-zsh, nice:15
#zplug "oskarkrawczyk/honukai-iterm-zsh", use:"honukai.zsh-theme", nice:16
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:"pure.zsh", nice:16


platform="unknown"

case "$OSTYPE" in
  solaris*) platform="SOLARIS" ;;
  darwin*)  platform="OSX" ;;
  linux*)   platform="LINUX" ;;
  bsd*)     platform="BSD" ;;
  *)        platform="unknown: $OSTYPE" ;;
esac


if [[ "$platform" == "OSX" ]]; then
  echo -e "Loading plugins for OS X"
  zplug "unixorn/tumult.plugin.zsh"
  zplug "plugins/osx", from:oh-my-zsh
  zplug "plugins/brew", from:oh-my-zsh
  zplug "mwilliammyers/plugin-osx"
elif [[ "$platform" == "LINUX" ]]; then
  if [[ "$(lsb_release -si)" == "Arch" ]]; then
    echo "Loading plugins for Arch Linux..."
    zplug "plugins/archlinux", from:oh-my-zsh
  elif [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
    echo "Loading pluins for Ubuntu..."
    zplug "plugins/ubuntu", from:oh-my-zsh
  fi
else
  echo "Cannot identify your OS..."
fi

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# Make it easy to append your own customizations that override the above by
# loading all files from .zshrc.d directory
mkdir -p ~/.zshrc.d
if [ -n "$(ls ~/.zshrc.d)" ]; then
  for dotfile in ~/.zshrc.d/*
  do
    if [ -r "${dotfile}" ]; then
      source "${dotfile}"
    fi
  done
fi

### CONFIG ###
unset COMPLETION_WAITING_DOTS # https://github.com/tarruda/zsh-autosuggestions#known-issues
#export COMPLETION_WAITING_DOTS=true
export DEFAULT_USER="Oscar"
export DISABLE_CORRECTION=true
#export DISABLE_UNTRACKED_FILES_DIRTY=true # Improves repo status check time.
export DISABLE_UPDATE_PROMPT=true
export EDITOR='vim'
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1 # https://github.com/neovim/neovim/pull/2007#issuecomment-74863439
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "

### AUTOSUGGESTIONS ###
if zplug check zsh-users/zsh-autosuggestions; then
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
fi

# ----------------------- End of zplug config ----------------------- #

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# set some more options
setopt pushd_ignore_dups
#setopt pushd_silent

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
  if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

export LOCATE_PATH=/var/db/locate.database

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
  export JAVA_HOME=/Library/Java/Home
fi

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# Load any custom zsh completions we've installed
if [ -d ~/.zsh-completions ]; then
  for completion in ~/.zsh-completions/*
  do
    source "$completion"
  done
fi

# In case a plugin adds a redundant path entry, remove duplicate entries
# from PATH
#
# This snippet is from Mislav Marohnić <mislav.marohnic@gmail.com>'s
# dotfiles repo at https://github.com/mislav/dotfiles

dedupe_path() {
  typeset -a paths result
  paths=($path)

  while [[ ${#paths} -gt 0 ]]; do
    p="${paths[1]}"
    shift paths
    [[ -z ${paths[(r)$p]} ]] && result+="$p"
  done

  export PATH=${(j+:+)result}
}

dedupe_path
# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV"

# ----------------------- User config ----------------------- #

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
ufetch

#[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

if [[ "$platform" == "LINUX" ]]; then
  [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ] && exec startx
  export PANEL_FIFO="/tmp/panel-fifo"
fi

# ----------------------- End of config ----------------------- #
