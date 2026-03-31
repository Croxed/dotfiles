#! /usr/bin/env zsh

required_completions=(
    docker 'https://github.com/docker/cli/raw/master/contrib/completion/zsh/_docker'
)

for key value in ${(kv)required_completions}; do
    if [ ! -f "$SIMPL_ZSH_DIR"/completion/_"$key" ]; then
        curl --create-dirs -fSsL "$value" -o "$SIMPL_ZSH_DIR"/completion/_"$key"
    fi
done

fpath+=("$SIMPL_ZSH_DIR"/completion "$SIMPL_ZSH_DIR"/fn)

if [ -d /opt/homebrew/share/zsh/site-functions ]; then
  fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

setopt NULL_GLOB
# all candidated for sourcing into path
declare -a path_candidate
path_candidate=(
    "$HOME/development/cabo/bin"
    "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
    "/opt/homebrew/opt/mysql-client/bin"
    "$HOME/.atuin/bin"
    "$HOME/bin.local"
    "$HOME/.local/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "$HOME/anaconda3/bin"
    "$HOME/github.com/graalvm/Contents/Home/bin"
    "$HOME/.gobrew/current/bin"
    "$HOME/.gobrew/bin"
    "$HOME/.nimble/bin"
    "$HOME/.bin"
    "$HOME/n/bin"
    "$HOME/.symfony/bin"
    "$HOME/.phpenv/shims"
    "$HOME/.cabal/bin"
    "$HOME/.rbenv/bin"
    "$HOME/.symfony/bin"
    "$HOME/.poetry/bin"
    "$HOME/.fzf/bin"
    "$HOME/.deno/bin"
    "$HOME/.cargo/bin"
    "$HOME/scripts"
    "$HOME/.nexustools"
    "$HOME/src/gocode/bin"
    "$HOME/.yarn/bin"
    "$HOME/.bun/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "$HOME/go/bin"
    "/opt/homebrew/bin"
    "/usr/local/bin"
    "/opt/local/sbin"
    "/opt/local/bin"
    "/usr/local/share/npm/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/bin/core_perl"
    "/bin"
    "$HOME"/Library/Python/*/bin
    )

if [ -d "$HOME/.gobrew/current/go" ]; then
  typeset -gx GOROOT="$HOME/.gobrew/current/go"
fi

# add all specified oaths to the path if not already present, the -U flag means 'unique'
typeset -U path=($path_candidate[@] $path[@])

# strip empty fields from the path
path=("${path[@]:#}")

for f in "$SIMPL_ZSH_DIR"/preload/*.zsh; do
	source "$f"
done

_source_zsh_config() {
  # source shell configuration files
  for f in "$SIMPL_ZSH_DIR"/plugins/*.zsh; do
      source "$f"
  done

  for f in "$SIMPL_ZSH_DIR"/settings/*.zsh; do
      source "$f" 2>/dev/null
  done

  if [ -d "$HOME"/.zsh-settings ]; then
      for f in "$HOME"/.zsh-settings/*.zsh; do
          source "$f" 2>/dev/null
      done
  fi
}

if command -v fzf >/dev/null; then
	source <(fzf --zsh)
fi

# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source "${ANTIDOTE}/antidote.zsh"
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

# Source custom plugins
zsh-defer +a "_source_zsh_config"
