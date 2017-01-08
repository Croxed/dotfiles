#!/usr/bin/env bash

set -e
set -u

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

DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

progress()
{
  tput civis
  local -r pid=${1}
  local -r delay='0.05'
  local -r before=${2}
  spinners=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
  local temp
  while kill -0 $pid 2>/dev/null;
  do
    for spinner in "${spinners[@]}"
    do
      sleep ${delay}
      printf " \e[97m$spinner\e[39m  $before\r" 2>/dev/null
    done
  done
}

completed(){
  printf "\033[2K" 2>/dev/null
  printf " \e[34m\U2714\e[39m $1 [\e[32mSUCCEEDED\e[39m]\n" \
  2>/dev/null
  tput cnorm || true
}

failed(){
  printf "\033[2K" 2>/dev/null
  printf " \e[33m\U26A0\e[39m $1 [\e[31mFAILED\e[39m]\n" \
  2>/dev/null
  tput cnorm || true
}
info(){
  printf "\033[2K" 2>/dev/null
  printf " \e[34m\U2753\e[39m $1 [\e[33mINFO\e[39m]\n" \
  2>/dev/null
  tput cnorm || true
}
testing(){
  if command -v "$1" 2&>/dev/null; then
    echo "true"
  else
    echo "false"
  fi
}

control_dependencies(){
  for arg in "$@"; do
    tempfile="$(mktemp)"
    testing "$arg" > "${tempfile}" &
    progress $! "Controlling $arg"
    exec 3< "${tempfile}"
    read <&3 line
    if [ "$line" == "true" ]; then
      completed "Command $arg was found"
      elif [ "$line" == "false" ]; then
      failed "Command $arg was not found"
      exit -1
    fi
  done
}

link_file () {
  local src=$1 dst=$2

  local skip=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
    local currentSrc="$(readlink $dst)"
    if [ "$currentSrc" == "$src" ]
    then
      skip=true;
    else
      mv "$dst" "${dst}.backup"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
  fi
}

install_dotfiles () {
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

  mkdir -p "$HOME/.config"
  for src in $(find "$DOTFILES_ROOT/.config" -mindepth 1 -maxdepth 1)
  do
    dst="$HOME/.config/$(basename "$src")"
    link_file "$src" "$dst"
  done
}

dotfiles(){
  tempfile="$(mktemp)"
  install_dotfiles > ${tempfile} &
  progress $! "Installing dotfiles.."
  exec 3< ${tempfile}
  read <&3 line
  if [ "$line" == "true" ] || [ "$line" == "" ]; then
    completed "Done installing dotfiles"
    elif [ "$line" == "false" ]; then
    failed "Dotfiles not installed"
    exit -1
  fi
}

extra_dotfiles(){
  if [[ "$OSTYPE" == "linux*" ]]; then
    local overwrite_all=false backup_all=false skip_all=false

    for src in $(find "$DOTFILES_ROOT/Linux" -mindepth 1 -maxdepth 1)
    do
      if [[ "${IGNORE[@]}" =~ "$(basename $src)" ]]
      then
        continue
      fi
      dst="$HOME/$(basename "$src")"
      link_file "$src" "$dst"
    done

    mkdir -p "$HOME/.config"
    for src in $(find "$DOTFILES_ROOT/Linux/.config" -mindepth 1 -maxdepth 1)
    do
      dst="$HOME/.config/$(basename "$src")"
      link_file "$src" "$dst"
    done
  fi
}
extras(){
  tempfile="$(mktemp)"
  extra_dotfiles > ${tempfile} &
  progress $! "Installing dotfiles.."
  exec 3< ${tempfile}
  read <&3 line
  if [ "$line" == "true" ] || [ "$line" == "" ]; then
    completed "Done installing dotfiles"
    elif [ "$line" == "false" ]; then
    failed "Dotfiles not installed"
    exit -1
  fi
}

control_dependencies "tmux" "nvim" "git" "zsh"
dotfiles
extras
printf " All processes are successfully completed \U1F389\n"
