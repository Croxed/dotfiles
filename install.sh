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
    "setup"
    "scripts"
    "linux"
    ".config"
)

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

noFile () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ''

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

getos() {
    case "$(uname)" in
        "Linux")   os="Linux" ;;
        "Darwin")  os="$(sw_vers -productName)" ;;
        *"BSD" | "DragonFly") os="BSD" ;;
        "CYGWIN"*) os="Windows" ;;
        "SunOS") os="Solaris" ;;
        *) printf "%s\n" "Unknown OS detected: $(uname)"; exit 1 ;;
    esac
}

getdistro() {
    [ "$distro" ] && return

    case "$os" in
        "Linux" )
                distro="$(awk -F 'NAME=' '/^NAME=/ {printf $2}' /etc/*ease)"
                distro="${distro//\"}"

                # Workaround for distros that store the value differently.
                [ -z "$distro" ] && distro="$(awk -F 'TAILS_PRODUCT_NAME="|"' '/^TAILS_PRODUCT_NAME=/ {printf $2}' /etc/*ease)"
                [ -z "$distro" ] && distro="$(awk '/BLAG/ {print $1; exit}' /etc/*ease)"
        ;;

        "Mac OS X")
            distro="$os"
        ;;

        "iPhone OS")
            distro="iOS $(sw_vers -productVersion)"
        ;;

        "BSD")
            distro="$(uname -s)"
            distro="${distro/DragonFly/DragonFlyBSD}"

            # Workaround for PCBSD as uname still displays FreeBSD.
            [ -f "/etc/pcbsd-lang" ] && distro="PCBSD"

            # Workaround for PacBSD as uname displays FreeBSD.
            [ -f "/etc/pacbsd-release" ] && distro="PacBSD"
        ;;

        "Windows")
            distro="$(wmic os get Caption /value)"

            # Strip crap from the output of wmic
            distro="${distro/Caption'='}"
            distro="${distro/Microsoft }"
        ;;

        "Solaris")
            distro="$(nawk 'NR==1{gsub(/^ \t]+|[ \t]+$/,""); printf $1 " " $2;}' /etc/release)"
        ;;
    esac
}

find_dependencies () {
    if [ ! -f "$DOTFILES_ROOT/setup/dependencies-${distro}" ]; then
        noFile "Could not find file with dependencies for distro ${distro}."
        return 1
    else
        success "Found dependency for $distro"
        return 0
    fi
}

install_packages () {
    if find_dependencies; then bash "$DOTFILES_ROOT/setup/dependencies-${distro}"; fi
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
        dst="$HOME/$(basename "$src")"
        link_file "$src" "$dst"
    done
}

install_other () {
    info 'installing other configs'
    local overwrite_all=false backup_all=false skip_all=false
    src="$DOTFILES_ROOT/scripts"
    dst="$HOME/$(basename "$src")"
    link_file "$src" "$dst"

    mkdir -p "$HOME/.config"
    for src in $(find "$DOTFILES_ROOT/.config" -mindepth 1 -maxdepth 1)
    do
        dst="$HOME/.config/$(basename "$src")"
        link_file "$src" "$dst"
    done

    ask "Install vim-plug?" Y && info "Installing vim-plug" && curl -fsLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && success "Installed vim-plug"
    if [[ "$os" == "Linux" ]]; then
        ask "Make ZSH the default shell?" Y && info "Making ZSH the default shell" && chsh -s "$(which zsh)"; success "Made ZSH default shell"
    elif [[ "$os" == "Mac OS X" ]]; then
        ask "Make ZSH the default shell?" Y && info "Making ZSH the default shell" && sudo dscl . -create /Users/$USER UserShell $(brew --prefix)/bin/zsh; success "Made ZSH default shell"
    fi
}

os_specific () {
    if [ -d "$DOTFILES_ROOT/$platform" ]; then
        for src in $(find "$DOTFILES_ROOT/$platform" -mindepth 1 -maxdepth 1)
        do
            if [[ "${IGNORE[@]}" =~ "$(basename $src)" ]]
            then
                continue
            fi
            dst="$HOME/$(basename "$src")"
            link_file "$src" "$dst"
        done

        mkdir -p "$HOME/.config"
        for src in $(find "$DOTFILES_ROOT/$platform/.config" -mindepth 1 -maxdepth 1)
        do
            dst="$HOME/.config/$(basename "$src")"
            link_file "$src" "$dst"
        done
    fi
}

install_bin () {
    info 'installing bin'
    local overwrite_all=false backup_all=false skip_all=false
    src="$DOTFILES_ROOT/bin"
    dst="$HOME/$(basename "$src")"
    link_file "$src" "$dst"
}

getos
getdistro
ask "Install packages?" Y && install_packages
echo ''
ask "Install dotfiles?" Y && install_dotfiles
echo ''
ask "Install bin?" Y && install_bin
echo ''
ask "Install other scripts and configs?" Y && install_other
echo ''
if [[ "$os" == "Linux" ]]; then
    ask "Install configs for $distro?" Y && os_specific
fi

echo ''
if [[ "$distro" == 'Mac OS X' ]]; then
  ask "Install sensible defaults for Mac OS X?" Y && bash "$DOTFILES_ROOT/setup/macos"
  ask "Install QuickLook plugins?" Y && bash "$DOTFILES_ROOT/setup/qlInstall"
fi
