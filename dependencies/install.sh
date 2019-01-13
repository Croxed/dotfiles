#! /usr/bin/env bash

# DETECT INFORMATION

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

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CURRENT_OS="MACOS" #CENTOS, UBUNUTU are other valid options
function findCurrentOSType()
{
    osType=$(uname)
    case "$osType" in
            "Darwin")
            {
                echo "Running on Mac OSX."
                CURRENT_OS="macOS"
            } ;;
            "Linux")
            {
                if command -v apt; then
                    CURRENT_OS="Ubuntu"
                elif command -v pacman; then
                    CURRENT_OS="Arch"
                else
                    echo "Unsupported OS, exiting"
                    exit
                fi
            } ;;
            *)
            {
                echo "Unsupported OS, exiting"
                exit
            } ;;
    esac
}

findCurrentOSType
if [[ "$CURRENT_OS" == "macOS" ]] && [[ -f "$CURRENT_DIR/dependencies-macOS" ]]; then
  ask "Do you want to install dependencies?" Y && bash "$CURRENT_DIR"/dependencies-"$CURRENT_OS"
  ask "Do you want to install sensible defaults?" Y && bash "$CURRENT_DIR"/macos
  ask "Do you want to install QuickLook plugins?" Y && bash "$CURRENT_DIR"/qlInstall
elif [[ -f "$CURRENT_DIR"/dependencies-"$CURRENT_OS" ]]; then
  ask "Do you want to install dependencies for $CURRENT_OS?" Y && bash "$CURRENT_DIR"/dependencies-"$CURRENT_OS"
else
  printf "%s not supported for dependencies." "$CURRENT_OS"
  exit 1
fi
