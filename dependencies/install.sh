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
		read -r -p "$1 [$prompt] " REPLY

		# Default?
		if [ -z "$REPLY" ]; then
			REPLY=$default
		fi

		# Check if the reply is valid
		case "$REPLY" in
		Y* | y*) return 0 ;;
		N* | n*) return 1 ;;
		esac

	done
}

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function find_current_os_type() {
	os_type=$(uname)
	case "$os_type" in
	"Darwin")
		{
			: "macOS"
		}
		;;
	"Linux")
		{
			if type -p apt >/dev/null; then
				: "Ubuntu"
			elif type -p pacman >/dev/null; then
				: "Arch"
			else
				printf "%s\n" "Unsupported OS, exiting"
				exit 1
			fi
		}
		;;
	*)
		{
			prints "%s\n" "Unsupported OS, exiting"
			exit 1
		}
		;;
	esac

	printf "%s" "$_"
}

install_for_os() {
	current_os="$(find_current_os_type)"
	printf "%s\n" "Trying install for ${current_os}"
	printf "%s\n" "Trying to find ${CURRENT_DIR}/dependencies-${current_os}"

	if [[ -f "${CURRENT_DIR}/dependencies-${current_os}" ]]; then
		ask "Do you want to install dependencies for ${current_os}?" Y && bash "${CURRENT_DIR}/dependencies-${current_os}"
	else
		printf "%s not supported for dependencies." "${current_os}"
		exit 1
	fi

	if [[ ${current_os} == "macOS" ]]; then
		ask "Do you want to install sensible defaults?" Y && bash "${CURRENT_DIR}/macos"
		ask "Do you want to install QuickLook plugins?" Y && bash "${CURRENT_DIR}/qlInstall"
	fi
}

install_for_os

# Change your shell
bash "${CURRENT_DIR}/change-shell"
