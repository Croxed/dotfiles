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
#unsetopt correctall

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
fi

# ----------------------- Start of ZPLUG config ----------------------- #

#
# User configuration sourced by interactive shells
#

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

# Add zplug plugins
# OMZ Libs
# zplug "lib/compfix", from:oh-my-zsh, defer:0
# zplug "lib/clipboard", from:oh-my-zsh, defer:0
# zplug "lib/directories", from:oh-my-zsh, defer:0
# zplug "lib/grep", from:oh-my-zsh, defer:0
# zplug "lib/key-bindings", from:oh-my-zsh, defer:0
# zplug "lib/misc", from:oh-my-zsh, defer:0
# zplug "lib/termsupport", from:oh-my-zsh, defer:0
zplug "lib/theme-and-appearance", from:oh-my-zsh, defer:0

# Misc
# zsh-syntax-highlighting must be loaded after executing compinit command and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-autosuggestions", defer:3
zplug "zsh-users/zsh-completions"

# Set Theme
zplug "mafredri/zsh-async", from:github, defer:0  # Load this first
zplug "pecigonzalo/pure-spaceship-zsh-theme", use:pure.zsh, from:github, as:theme

# GIT
# zplug "plugins/git", from:oh-my-zsh
# zplug "pecigonzalo/gitfast-zsh-plugin", from:github
# zplug "plugins/git-extras", from:oh-my-zsh

# Basic utils
# zplug "plugins/sudo", from:oh-my-zsh
# zplug "plugins/colored-man-pages", from:oh-my-zsh
# zplug "plugins/ssh-agent", from:oh-my-zsh, if:"which ssh-agent"
# zplug "plugins/tmux", from:oh-my-zsh
# zplug "plugins/z", from:oh-my-zsh
zplug "rimraf/k", from:github, as:plugin

zplug "djui/alias-tips"
zplug "tcnksm/docker-alias", use:zshrc
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

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
export SPACESHIP_GIT_SYMBOL=""
#export DISABLE_UNTRACKED_FILES_DIRTY=true # Improves repo status check time.
export DISABLE_UPDATE_PROMPT=true
export EDITOR='vim'
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1 # https://github.com/neovim/neovim/pull/2007#issuecomment-74863439
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
# ----------------------- End of ZPLUG config ----------------------- #

# ===== Basics
setopt no_beep              # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

# ===== Changing Directories
setopt auto_cd           # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevarS        # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack
setopt auto_pushd        # make cd push the old directory onto the directory stack
setopt pushdminus        # swapped the meaning of cd +1 and cd -1; we want them to mean the opposite of what they mean im csh

# ===== Expansion and Globbing
setopt extendedglob # treat #, ~, and ^ as part of patterns for filename generation

# ===== History
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history       # save timestamp of command and duration
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # do not write events to history that are duplicates of previous events
setopt hist_ignore_all_dups   # delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_space      # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups      # when searching history don't display results already cycled through twice
setopt hist_reduce_blanks     # remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history
setopt hist_no_store          # remove the history (fc -l) command from the history list when invoked
setopt long_list_jobs         # list jobs in the long format by default


# ===== Completion
setopt always_to_end      # when completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu          # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs     # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word   # allow completion from within a word/phrase
setopt auto_list          # automatically list choices on ambiguous completion.
unsetopt complete_aliases   # an alias of a command should complete to the command completion
unsetopt menu_complete    # do not autoselect the first completion entry
unsetopt flowcontrol      # do not freezes output to the terminal until you type ^q

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

# ===== Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted

# ZSH Completion config
zstyle '*' single-ignored show
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache"

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
    clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
    gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
    ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
    operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
    usbmux uucp vcsa wwwrun xfs '_*'

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

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
    export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
fi

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
clear
greeting
#[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

if [ "$(uname)" = "Darwin" ]; then
    if type wal >/dev/null; then
        (wal -r &)
    fi
else
    if type wpg >/dev/null; then
        (wpg -t &)
    fi
fi
# ----------------------- End of config ----------------------- #
