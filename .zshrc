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
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

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


eval "$(atuin init zsh)"
