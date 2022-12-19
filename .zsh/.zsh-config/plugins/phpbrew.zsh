#! /usr/bin/env

_install_phpbrew() {
  if ! command -v phpbrew &>/dev/null; then
      mkdir -p "$HOME"/bin.local "$HOME"/.zsh-settings
      curl -LsfS "https://github.com/phpbrew/phpbrew/raw/master/phpbrew" -o "$HOME"/bin.local/phpbrew
      chmod +x "$HOME"/bin.local/phpbrew
      phpbrew -q init
      ln -sfn "$HOME"/.phpbrew/bashrc "$HOME"/.zsh-settings/phpbrew.zsh
  fi
}

zsh-defer _install_phpbrew
