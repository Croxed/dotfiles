#!/usr/bin/env bash
set -e

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

dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

platform="unknown"

case "$OSTYPE" in
    solaris*) platform="SOLARIS" ;;
    darwin*)  platform="OSX" ;; 
    linux*)   platform="LINUX" ;;
    bsd*)     platform="BSD" ;;
    *)        platform="unknown: $OSTYPE" ;;
esac

if [[ "$platform" == 'LINUX' ]]; then
  distro=`lsb_release -si`
  if [ ! -f "dependencies-${distro}" ]; then
    echo "Could not find file with dependencies for distro ${distro}. Aborting."
    exit 2
  fi
elif [[ "$platform" == 'OSX' ]]; then
  distro="macos"
  if [ ! -f "dependencies-macos" ]; then
    echo "Could not find file with dependencies for macOS. Aborting."
    exit 2
  fi
else
  echo "OS not supported, yet."
  exit 2
fi


ask "Install packages?" Y && bash ./dependencies-${distro}

if [[ "$distro" == 'macos' ]]; then
  ask "Install sensible defaults for macOS?" Y && bash ./macos
fi

if [[ "$platform" == 'LINUX' ]]; then
  ask "Install symlink for .i3/?" Y && ln -sfn ${dir}/.i3 ${HOME}/.i3
  ask "Install symlink for scripts/? i3 uses these." Y && ln -sfn ${dir}/scripts ${HOME}/scripts
  ask "Install symlink for .Xresources?" Y && ln -sfn ${dir}/.Xresources ${HOME}/.Xresources
  ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc
  ask "Install symlink for .compton.conf?" Y && ln -sfn ${dir}/.compton.conf ${HOME}/.compton.conf
  ask "Install symlink for .gtkrc-2.0?" Y && ln -sfn ${dir}/.gtkrc-2.0 ${HOME}/.gtkrc-2.0
fi

if [[ "$distro" == "macos" ]]; then
  ask "Install symlink for .kwm/?" Y && ln -sfn ${dir}/.kwm ${HOME}/.kwm
  ask "Install plugins for QuickLook?" Y && bash ./qlInstall
fi

ask "Install symlink for .gitconfig?" Y && ln -sfn ${dir}/.gitconfig ${HOME}/.gitconfig
ask "Install symlink for .zsh?" Y && ln -sfn ${dir}/.zshrc ${HOME}/.zshrc
ask "Install symlink for .ncmpcpp?" Y && ln -sfn ${dir}/.ncmpcpp ${HOME}/.ncmpcpp
ask "Install symlink for .vim/?" Y && ln -sfn ${dir}/.vim ${HOME}/.vim && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ask "Install symlink for .zshrc.d/?" Y && ln -sfn ${dir}/.zshrc.d ${HOME}/.zshrc.d
ask "Install symlink for .config/?" Y && mkdir -p ${HOME}/.config && ln -sfn ${dir}/.config/* ${HOME}/.config
ask "Install symlink for .weechat/?" Y && ln -sfn ${dir}/.weechat ${HOME}/.weechat
