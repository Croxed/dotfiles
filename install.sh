#!/usr/bin/env bash
#
# Inspired by https://github.com/holman/dotfiles
#

IGNORE=(
    ".git"
    ".gitignore"
    ".gitmodules"
    "README.md"
    ".DS_Store"
    "install.sh"
    "bin"
)

DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ''

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then

        if [ "$overwrite_all" == "false" ] && \
               [ "$backup_all" == "false" ] && \
               [ "$skip_all" == "false" ]
        then

            local currentSrc="$(readlink $dst)"

            if [ "$currentSrc" == "$src" ]
            then

                skip=true;

            else
                user "File already exists: $dst ($(basename "$src")), \
what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, \
[O]verwrite all, [b]ackup, [B]ackup all?"

                read -n 1 action

                case "$action" in
                    o )
                        overwrite=true;;
                    O )
                        overwrite_all=true;;
                    b )
                        backup=true;;
                    B )
                        backup_all=true;;
                    s )
                        skip=true;;
                    S )
                        skip_all=true;;
                    * )
                    ;;
                esac

            fi

        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [ "$overwrite" == "true" ]
        then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$backup" == "true" ]
        then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [ "$skip" == "true" ]
        then
            success "skipped $src"
        fi
    fi

    if [ "$skip" != "true" ]  # "false" or empty
    then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

detectOS () {
    platform="unknown"

    case "$OSTYPE" in
        solaris*) platform="SOLARIS" ;;
        darwin*)  platform="OSX" ;;
        linux*)   platform="LINUX" ;;
        bsd*)     platform="BSD" ;;
        *)        platform="unknown: $OSTYPE" ;;
    esac

    if [ "$platform" == 'LINUX' ]; then
      distro=`lsb_release -si`
        if [ ! -f "$DOTFILES_ROOT/setup/dependencies-${distro}" ]; then
            echo "Could not find file with dependencies for distro ${distro}. Aborting."
            exit 0
        fi
    elif [ "$platform" == 'OSX' ]; then
        distro="macos"
        if [ ! -f "$DOTFILES_ROOT/setup/dependencies-macos" ]; then
            echo "Could not find file with dependencies for macOS. Aborting."
            exit 0
        fi
    else
      echo "OS not supported, yet."
      exit 0
    fi
}

install_packages () {
    bash "$DOTFILES_ROOT/setup/dependencies-$distro"
}

install_dotfiles () {
    info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false

    for src in $(find "$DOTFILES_ROOT" -mindepth 1 -maxdepth 1)
    do
        if [[ "${IGNORE[@]}" =~ "$(basename $src)" ]]
        then
            continue
        fi
        dst="$HOME/.$(basename "$src")"
        link_file "$src" "$dst"
    done
}

install_bin () {
    info 'installing bin'
    local overwrite_all=false backup_all=false skip_all=false
    src="$DOTFILES_ROOT/bin"
    dst="$HOME/$(basename "$src")"
    link_file "$src" "$dst"

    ask "Install vim-plug?" Y && info "Installing vim-plug" && curl -fsLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && success "Installed vim-plug"
    if [ "$PLATFORM" == "LINUX" ]; then
        ask "Make ZSH the default shell?" Y && info "Making ZSH the default shell" && chsh -s "$(which zsh)" && success "Made ZSH default shell"
    elif [[ "$distro" == "macos" ]]; then
        ask "Make ZSH the default shell?" Y && info "Making ZSH the default shell" && sudo dscl . -create /Users/$USER UserShell $(brew --prefix)/bin/zsh && success "Made ZSH default shell"
    fi
}
detectOS
ask "Install packages?" Y && install_packages
echo ''
ask "Install dotfiles?" Y && install_dotfiles
echo ''
ask "Install bin?" Y && install_bin

echo ''
if [[ "$distro" == 'macos' ]]; then
  ask "Install sensible defaults for macOS?" Y && bash "$DOTFILES_ROOT/setup/.macos"
fi