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
	/usr/local/opt/coreutils/libexec/gnubin \
	~/.cabal/bin \
	~/.rbenv/bin \
	~/.bin \
    ~/.cargo/bin \
	~/bin.local \
	~/scripts \
	~/.nexustools \
	~/src/gocode/bin \
	/usr/local/CrossPack-AVR/bin \
  /usr/local/texlive/2016/bin/x86_64-darwin
do
	if [ -d ${path_candidate} ]; then
		export PATH=${PATH}:${path_candidate}
	fi
done

if [[ "$(uname)" == "Linux" ]]; then
	[ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ] && exec startx
	export PANEL_FIFO="/tmp/panel-fifo"
fi
# ----------------------- Start of ZIM config ----------------------- #

#
# User configuration sourced by interactive shells
#

#PROMPT_LEAN_TMUX=""

[[ -d ${ZDOTDIR:-${HOME}}/.zfunctions ]] ||(
 mkdir -p ${ZDOTDIR:-${HOME}}/.zfunctions
)

fpath=( ${ZDOTDIR:-${HOME}}/.zfunctions $fpath )

export ZPLUG_HOME=${ZDOTDIR:-${HOME}}/.zplug
[[ -d ${ZDOTDIR:-${HOME}}/.zplug ]] ||(
 git clone https://github.com/zplug/zplug $ZPLUG_HOME
)

[[ -d ${ZDOTDIR:-${HOME}}/filthy ]] ||(
 git clone https://github.com/molovo/filthy ${ZDOTDIR:-${HOME}}/filthy
 ln -s ${ZDOTDIR:-${HOME}}/filthy/filthy.zsh ${ZDOTFIR:-${HOME}}/.zfunctions/prompt_filthy_setup
)

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "djui/alias-tips"
zplug "tcnksm/docker-alias", use:zshrc
zplug "plugins/git",   from:oh-my-zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

autoload -Uz promptinit
promptinit
prompt filthy

# Make it easy to append your own customizations that override the above by
# loading all files from .zshrc.d directory
mkdir -p ${ZDOTDIR:-${HOME}}/zshrc.d
if [ -d ${ZDOTDIR:-{HOME}}/zshrc.d ]; then
	for dotfile in ${ZDOTDIR:-${HOME}}/zshrc.d/*
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
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
# ----------------------- End of ZIM config ----------------------- #

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
HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history
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
    export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
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

eval `ssh-agent -s`

# Fun with SSH
if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
	if [[ "$(uname -s)" == "Darwin" ]]; then
		# We're on OS X. Try to load ssh keys using pass phrases stored in
		# the OSX keychain.
		#
		# You can use ssh-add -K /path/to/key to store pass phrases into
		# the OSX keychain
		ssh-add -k
	fi
fi

if [ -f ~/.ssh/id_rsa ]; then
	if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
		ssh-add ~/.ssh/id_rsa
	fi
fi

if [ -f ~/.ssh/id_dsa ]; then
	if [ $(ssh-add -L | grep -c ".ssh/id_dsa" ) -eq 0 ]; then
		ssh-add ~/.ssh/id_dsa
	fi
fi

# ----------------------- User config ----------------------- #
ufetch

#[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

export TTC_REPOS="~/OneDrive/Development/LenaSYS"
export TTC_WEATHER="Gothenburg"

eval $(thefuck --alias)
# ----------------------- End of config ----------------------- #
