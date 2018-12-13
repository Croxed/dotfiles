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
# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
#unsetopt correctall

export GOROOT=$HOME/.go
export GOPATH=$HOME/go

for path_candidate in /opt/local/sbin \
    /Applications/Xcode.app/Contents/Developer/usr/bin \
    /usr/bin/core_perl \
    $HOME/anaconda3/bin \
    /opt/local/bin \
    /usr/local/share/npm/bin \
    /usr/local/opt/coreutils/libexec/gnubin \
    ~/.cabal/bin \
    ~/.rbenv/bin \
    ~/.bin \
    $HOME/.pyenv/bin \
    ~/.cargo/bin \
    ~/bin.local \
    ~/scripts \
    ~/.nexustools \
    ~/src/gocode/bin \
    /usr/local/CrossPack-AVR/bin \
    /usr/local/texlive/2016/bin/x86_64-darwin
do
    if [ -d ${path_candidate} ]; then
        path+=( ${path_candidate} )
    fi
done
export PATH

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

mkdir -p ${ZDOTDIR:-${HOME}}/zshrc.d
if [ -d ${ZDOTDIR:-{HOME}}/zshrc.d ]; then
    for dotfile in ${ZDOTDIR:-${HOME}}/zshrc.d/*
    do
        if [ -r "${dotfile}" ]; then
            source "${dotfile}"
        fi
    done
fi

# Export path to python, will help deoplete-jedi
export PYTHON3_PATH="$(which python3.6)"

# just type '...' to get '../..'
rationalise-dot() {
local MATCH
if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
  LBUFFER+=/
  zle self-insert
  zle self-insert
else
  zle self-insert
fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
## without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

restart () {
    exec $SHELL $SHELL_ARGS "$@"
}

eval `ssh-agent -s`

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

## ZPLUGIN
export ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
[[ -d ${ZDOTDIR:-$HOME}/.zplugin ]] ||(
mkdir "$ZPLG_HOME"
echo ">>> Downloading zplugin to $ZPLG_HOME/bin"
git clone --depth 10 https://github.com/zdharma/zplugin.git "$ZPLG_HOME/bin"
echo ">>> Done"
)

### Added by Zplugin's installer
source "$ZPLG_HOME/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

## zplugin start

zplugin load zdharma/history-search-multi-word

zplugin ice compile"*.lzui"

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-completions
zplugin light csurfer/tmuxrepl
zplugin light djui/alias-tips
zplugin light willghatch/zsh-saneopt
# zplugin light rupa/z
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zplugin ice svn; zplugin snippet PZT::modules/docker
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis

## zplugin end

### CONFIG ###
unset COMPLETION_WAITING_DOTS
#export COMPLETION_WAITING_DOTS=true
export DEFAULT_USER="Oscar"
export DISABLE_CORRECTION=true
export SPACESHIP_GIT_SYMBOL=""
#export DISABLE_UNTRACKED_FILES_DIRTY=true # Improves repo status check time.
export DISABLE_UPDATE_PROMPT=true
export EDITOR='vim'
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
###############################
# ===== Basics
setopt no_beep
setopt interactive_comments

# ===== Changing Directories
setopt auto_cd
setopt cdablevarS
setopt pushd_ignore_dups
setopt auto_pushd
setopt pushdminus

# ===== Expansion and Globbing
setopt extendedglob

# ===== History
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history
setopt hist_no_store
setopt long_list_jobs


# ===== Completion
setopt always_to_end
setopt auto_menu
setopt auto_name_dirs
setopt complete_in_word
setopt auto_list
unsetopt complete_aliases
unsetopt menu_complete
unsetopt flowcontrol

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
#REPORTTIME=2
#TIMEFMT="%U user %S system %P cpu %*Es total"

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}

# ===== Scripts and Functions
setopt multios

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

[[ -d ${ZDOTDIR:-${HOME}}/.zfunctions ]] ||(
mkdir -p ${ZDOTDIR:-${HOME}}/.zfunctions
)

fpath=( "${ZDOTDIR:-${HOME}}/.zfunctions" $fpath )

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit
compinit
zplugin cdreplay -q # <- execute compdefs provided by rest of plugins

if which jenv > /dev/null; then eval "$(jenv init -)"; fi
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh


if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi

fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache


export PATH=/usr/local/opt/curl/bin:$PATH
dedupe_path
## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
