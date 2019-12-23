#! /bin/zsh
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

[[ -d ${ZDOTDIR:-$HOME}/.zplugin/bin/zmodules ]] ||{
    zplugin module build
}

zplugin light romkatv/powerlevel10k
zplugin ice wait silent; zplugin load zdharma/history-search-multi-word

zplugin ice wait lucid atload'_zsh_autosuggest_start'; zplugin light zsh-users/zsh-autosuggestions
zplugin ice wait silent; zplugin light zsh-users/zsh-history-substring-search
zplugin ice wait silent atinit'zpcompinit; zpcdreplay'; zplugin light zsh-users/zsh-completions
# Load syntax last
zplugin ice wait silent; zplugin light willghatch/zsh-saneopt
zplugin ice wait silent; zplugin light lukechilds/zsh-nvm
zplugin ice wait silent; zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin ice wait silent; zplugin snippet OMZ::plugins/gitignore/gitignore.plugin.zsh
zplugin ice wait silent; zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zplugin ice wait silent atinit'zpcompinit; zpcdreplay'; zplugin light zdharma/fast-syntax-highlighting
zplugin pack for fzf
## zplugin end
