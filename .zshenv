# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.
#
# Do not modify this file unless you know exactly what you are doing.
# It is strongly recommended to keep all shell customization and configuration
# (including exported environment variables such as PATH) in ~/.zshrc or in
# files sourced from ~/.zshrc. If you are certain that you must export some
# environment variables in ~/.zshenv, do it where indicated by comments below.

if [ -n "${ZSH_VERSION-}" ]; then
  : ${ZDOTDIR:=~}
  setopt no_global_rcs
  if [[ -o no_interactive && -z "${Z4H_BOOTSTRAPPING-}" ]]; then
    return
  fi
  setopt no_rcs
  unset Z4H_BOOTSTRAPPING

  # If you are certain that you must export some environment variables
  # in ~/.zshenv (see comments at the top!), do it here:
  #
  #   export GOPATH=$HOME/go
  #
  # Do not change anything else in this file.
fi

ANTIDOTE_URL="https://github.com/mattmc3/antidote.git"
: "${ANTIDOTE:=${XDG_CACHE_HOME:-$HOME/.cache}/antidote}"

umask o-w

if [ ! -e "$ANTIDOTE"/antidote.zsh ]; then
  >&2 printf '\033[33mantidote\033[0m: fetching \033[4mantidote.zsh\033[0m\n'
  if command -v git >/dev/null 2>&1; then
    git clone --depth=1 "$ANTIDOTE_URL" "$ANTIDOTE" || return
  else
    >&2 printf '\033[33mantidote\033[0m: please install \033[32mgit\033[0m\n'
    return 1
  fi
fi

setopt rcs
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
