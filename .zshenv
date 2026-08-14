if [ -n "${ZSH_VERSION-}" ]; then
  : ${ZDOTDIR:=~}
  setopt no_global_rcs
  if [[ -o no_interactive ]]; then
    return
  fi
  setopt no_rcs

  # If you are certain that you must export some environment variables
  # in ~/.zshenv (see comments at the top!), do it here:
  #
  #   export GOPATH=$HOME/go
  #
  # Do not change anything else in this file.
fi

setopt rcs
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
