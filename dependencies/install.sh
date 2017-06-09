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
                CURRENT_OS="MACOS"
            } ;;
            "Linux")
            {
                # If available, use LSB to identify distribution
                if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
                    DISTRO=$(gawk -F= '/^NAME/{print $2}' /etc/os-release)
                else
                    DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
                fi
                CURRENT_OS=$(echo $DISTRO | tr 'a-z' 'A-Z' | tr -d "\"")
            } ;;
            *)
            {
                echo "Unsupported OS, exiting"
                exit
            } ;;
    esac
}

if [[ "$CURRENT_OS" == "MACOS" ]]; then
  ask "Do you want to install dependencies?" && bash "$CURRENT_DIR"/dependencies-"$CURRENT_OS"
  ask "Do you want to install sensible defaults?" && bash "$CURRENT_DIR"/macos
  ask "Do you want to install QuickLook plugins?" && bash "$CURRENT_DIR"/qlInstall
elif [[ -f "$CURRENT_DIR"/dependencies-"$CURRENT_OS" ]]; then
  ask "Do you want to install dependencies for $CURRENT_OS?" && bash "$CURRENT_DIR"/dependencies-"$CURRENT_OS"
else
  printf "$CURRENT_OS not supported for dependencies."
  exit 1
fi
