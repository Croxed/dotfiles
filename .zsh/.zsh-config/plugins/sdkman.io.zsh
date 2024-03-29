#!/usr/bin/env zsh 

_install_and_source_sdkman() {

  [ ! -d "$HOME/.sdkman" ] && {
      printf 'Installing sdkman\n'
      local tempFile="$(mktemp)"
      curl -s "https://get.sdkman.io" > "${tempFile}"
      bash "${tempFile}" 1> /dev/null 2>&1
      if ! $?; then
          printf 'Installation failed\n'
      else
          printf 'Installation complete\n'
      fi
  }

  source "$HOME/.sdkman/bin/sdkman-init.sh" &>/dev/null
}

zsh-defer _install_and_source_sdkman
