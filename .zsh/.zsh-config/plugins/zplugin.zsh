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

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-completions
zplugin light willghatch/zsh-saneopt
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

## zplugin end
