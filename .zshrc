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

emulate -L zsh && \
setopt typeset_silent pipe_fail extended_glob prompt_percent no_prompt_subst && \
setopt no_prompt_bang no_bg_nice no_aliases globdots

zmodload zsh/{datetime,langinfo,parameter,system,terminfo,zutil} || return
zmodload -F zsh/files b:{zf_mkdir,zf_mv,zf_rm,zf_rmdir,zf_ln}    || return
zmodload -F zsh/stat b:zstat                                     || return

SIMPL_ZSH_DIR=${HOME}/.zsh/.zsh-config

function -simpl-init-homebrew() {
  (( ARGC )) || return 0
  local dir=${1:h:h}
  export HOMEBREW_PREFIX=$dir
  export HOMEBREW_CELLAR=$dir/Cellar
  if [[ -e $dir/Homebrew/Library ]]; then
    export HOMEBREW_REPOSITORY=$dir/Homebrew
  else
    export HOMEBREW_REPOSITORY=$dir
  fi
}

if [[ $OSTYPE == darwin* ]]; then
  if [[ ! -e $SIMPL_ZSH_DIR/cache/init-darwin-paths ]] || ! source $SIMPL_ZSH_DIR/cache/init-darwin-paths; then
    autoload -Uz $SIMPL_ZSH_DIR/fn/-simpl-gen-init-darwin-paths
    -simpl-gen-init-darwin-paths && source $SIMPL_ZSH_DIR/cache/init-darwin-paths
  fi
  [[ -z $HOMEBREW_PREFIX ]] && -simpl-init-homebrew {/opt/homebrew,/usr/local}/bin/brew(N)
elif [[ $OSTYPE == linux* && -z $HOMEBREW_PREFIX ]]; then
  -simpl-init-homebrew {/home/linuxbrew/.linuxbrew,~/.linuxbrew}/bin/brew(N)
fi

fpath=(
  ${^${(M)fpath:#*/$ZSH_VERSION/functions}/%$ZSH_VERSION\/functions/site-functions}(-/N)
  ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/zsh/site-functions}(-/N)
  /opt/homebrew/share/zsh/site-functions(-/N)
  /usr{/local,}/share/zsh/{site-functions,vendor-completions}(-/N)
  $fpath
)

function simpl-expand() { zle _expand_alias || zle .expand-word || true }
zle -N z4h-expand

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

# History related config
typeset -gx HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
typeset -gx HISTSIZE=1000000000  # infinite command history
typeset -gx SAVEHIST=1000000000  # infinite command history
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicates
setopt HIST_FIND_NO_DUPS    # Don't display duplicates during search

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Autoload functions.
zstyle ':completion:*' menu no # don't use zsh's native completion menu
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true

# path to the framework root directory

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


if command -v atuin >/dev/null; then
	eval "$(atuin init zsh)"
fi
