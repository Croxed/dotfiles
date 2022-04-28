#! /usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# shellcheck disable=1091
. "$DIR"/utils.sh

neovim_dir="$DIR"/.neovim

main() {
	local version url type
	case "$OSTYPE" in
	darwin*)
		type="macos"
		;;
	linux*)
		type="linux64"
		;;
	*)
		printf '%s is unknown\n' "$OSTYPE" >&2
		exit 1
		;;

	esac

	response="$(get_latest_release neovim neovim "$type")"
	version="$(head -n1 <<<"$response")"
	url="$(grep -E 'tar.gz$' <<<"$response")"

	echo "Downloading $url"

	rm -rf "$neovim_dir" && mkdir -p "$neovim_dir"
	cd "$neovim_dir" || exit 1
	curl -fsSL "$url" | tar xz --strip-components=1
	ln -sfn "$neovim_dir"/bin/nvim "$HOME"/bin.local/nvim

	printf 'Successfully installed neovim version %s\n' "$version"
}

main
