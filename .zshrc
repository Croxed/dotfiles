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

source $HOME/.p10k.zsh

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Autoload functions.
autoload -Uz zmv compinit
compinit

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

# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source "${ANTIDOTE}/antidote.zsh"
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

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
